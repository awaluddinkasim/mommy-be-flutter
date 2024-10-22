import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/cubit/auth_cubit.dart';
import 'package:mommy_be/cubit/auth_state.dart';
import 'package:mommy_be/pages/auth/login.dart';
import 'package:mommy_be/pages/user_edit.dart';
import 'package:mommy_be/shared/widgets/dialog/loading.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().user;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LoadingDialog(),
              );
            }
            if (state is AuthInitial) {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 96),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: SizedBox(
                      height: 180,
                      width: 180,
                      child: Image.asset(
                        'assets/user.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  user.nama,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "${user.usia} Tahun",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text("Email"),
                          subtitle: Text(user.email),
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: const Text("Nomor HP"),
                          subtitle: Text(user.nomorHp),
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          leading: const Icon(Icons.calendar_today),
                          title: const Text("Tgl. Lahir"),
                          subtitle: Text(DateFormat('dd MMMM yyyy', 'ID').format(user.tanggalLahir)),
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserEditScreen(user: user),
                              ),
                            ).then((_) {
                              setState(() {});
                            });
                          },
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.blue,
                            ),
                          ),
                          child: const Text("Edit Akun"),
                        ),
                        FilledButton.icon(
                          onPressed: () {
                            context.read<AuthCubit>().logout();
                          },
                          icon: const Icon(Icons.exit_to_app),
                          label: const Text("Logout"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
