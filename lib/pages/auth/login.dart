import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/auth_cubit.dart';
import 'package:mommy_be/cubit/auth_state.dart';
import 'package:mommy_be/pages/auth/register.dart';
import 'package:mommy_be/pages/home.dart';
import 'package:mommy_be/shared/widgets/dialog/loading.dart';
import 'package:mommy_be/shared/widgets/dialog/message.dart';
import 'package:mommy_be/shared/widgets/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/main.png',
              ),
              const SizedBox(height: 16),
              const Text(
                "Mommy Be",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 28),
              Input(
                controller: _email,
                label: "Email",
                icon: const Icon(Icons.mail),
                hintText: "Masukkan email",
              ),
              Input(
                controller: _password,
                label: "Password",
                icon: const Icon(Icons.lock),
                hintText: "Masukkan password",
                obscureText: !_showPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  icon: Icon(
                    !_showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const LoadingDialog();
                      },
                    );
                  }
                  if (state is AuthFailed) {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    showDialog(
                      context: context,
                      builder: (context) {
                        return MessageDialog(
                          status: 'Gagal',
                          message: state.error,
                          onOkPressed: () {
                            Navigator.pop(context);
                            FocusScope.of(context).unfocus();
                          },
                        );
                      },
                    );
                  }
                  if (state is AuthSuccess) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
                child: FilledButton(
                  onPressed: () {
                    context.read<AuthCubit>().login(
                          _email.text,
                          _password.text,
                        );
                  },
                  child: const Text("L O G I N"),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  const Text(
                    "Belum punya akun?",
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text("Daftar Disini"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
