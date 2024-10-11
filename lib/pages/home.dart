import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/auth_cubit.dart';
import 'package:mommy_be/cubit/auth_state.dart';
import 'package:mommy_be/cubit/bayi_cubit.dart';
import 'package:mommy_be/models/nutrisi_harian.dart';
import 'package:mommy_be/pages/auth/login.dart';
import 'package:mommy_be/pages/baby.dart';
import 'package:mommy_be/pages/laktasi.dart';
import 'package:mommy_be/pages/nutrisi_harian.dart';
import 'package:mommy_be/shared/widgets/dialog/loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().user;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocListener<AuthCubit, AuthState>(
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
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: () {
                        context.read<AuthCubit>().logout();
                      },
                      icon: const Icon(Icons.exit_to_app),
                      label: const Text("Logout"),
                      style: const ButtonStyle(
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Image.asset('assets/main.png'),
              const SizedBox(height: 28),
              const Text(
                'Menu',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              if (MediaQuery.of(context).orientation == Orientation.landscape)
                GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 7 / 8,
                  ),
                  children: [
                    GridMenuItem(
                      onTap: () {
                        context.read<BayiCubit>().getBayi();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BabyScreen(),
                          ),
                        );
                      },
                      image: Image.asset('assets/baby-monitor.png'),
                      label: 'Bayi',
                    ),
                    GridMenuItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NutrisiHarianScreen(),
                          ),
                        );
                      },
                      image: Image.asset('assets/food.png'),
                      label: 'Nutrisi Harian',
                    ),
                    GridMenuItem(
                      onTap: () {},
                      image: Image.asset('assets/pregnancy.png'),
                      label: 'Obstetri',
                    ),
                    GridMenuItem(
                      onTap: () {
                        context.read<BayiCubit>().getBayi();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LaktasiScreen(),
                          ),
                        );
                      },
                      image: Image.asset('assets/bottle.png'),
                      label: 'Monitor Laktasi',
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HorizontalMenuItem(
                      onTap: () {
                        context.read<BayiCubit>().getBayi();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BabyScreen(),
                          ),
                        );
                      },
                      image: Image.asset('assets/baby-monitor.png'),
                      label: 'Data Bayi',
                      deskripsi:
                          'Kelola data profil tentang bayi Anda dengan mudah',
                    ),
                    HorizontalMenuItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NutrisiHarianScreen(),
                          ),
                        );
                      },
                      image: Image.asset('assets/food.png'),
                      label: 'Nutrisi Harian',
                      deskripsi: 'Lacak dan rencanakan asupan nutrisi harian.',
                    ),
                    HorizontalMenuItem(
                      onTap: () {},
                      image: Image.asset('assets/pregnancy.png'),
                      label: 'Obstetri',
                      deskripsi: 'Panduan seputar kehamilan dan persalinan.',
                    ),
                    HorizontalMenuItem(
                      onTap: () {
                        context.read<BayiCubit>().getBayi();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LaktasiScreen(),
                          ),
                        );
                      },
                      image: Image.asset('assets/bottle.png'),
                      label: 'Monitor Laktasi',
                      deskripsi:
                          'Catat dan pantau jadwal serta durasi menyusui.',
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalMenuItem extends StatelessWidget {
  const HorizontalMenuItem({
    super.key,
    required this.onTap,
    required this.image,
    required this.label,
    required this.deskripsi,
  });

  final Function() onTap;
  final Widget image;
  final String label;
  final String deskripsi;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: ListTile(
        onTap: onTap,
        leading: image,
        title: Text(label),
        subtitle: Text(
          deskripsi,
          style: const TextStyle(color: Colors.black45),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class GridMenuItem extends StatelessWidget {
  const GridMenuItem({
    super.key,
    required this.onTap,
    required this.image,
    required this.label,
  });

  final Function() onTap;
  final Widget image;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 100,
                child: image,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
