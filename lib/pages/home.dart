import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/auth_cubit.dart';
import 'package:mommy_be/cubit/bayi_cubit.dart';
import 'package:mommy_be/cubit/obstetri_cubit.dart';
import 'package:mommy_be/cubit/screening_ppd_cubit.dart';
import 'package:mommy_be/pages/baby.dart';
import 'package:mommy_be/pages/laktasi.dart';
import 'package:mommy_be/pages/nutrisi_harian.dart';
import 'package:mommy_be/pages/obstetri.dart';
import 'package:mommy_be/pages/screening_ppd.dart';
import 'package:mommy_be/pages/user.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserScreen(),
                          ),
                        ).then((_) {
                          setState(() {});
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 16,
                              child: Icon(Icons.person),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 70,
                              child: Text(
                                user.nama,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
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
                    _GridMenuItem(
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
                    _GridMenuItem(
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
                    _GridMenuItem(
                      onTap: () {
                        context.read<ObstetriCubit>().getObstetri();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ObstetriScreen(),
                          ),
                        );
                      },
                      image: Image.asset('assets/pregnancy.png'),
                      label: 'Obstetri',
                    ),
                    _GridMenuItem(
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
                    _HorizontalMenuItem(
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
                      deskripsi: 'Kelola data profil tentang bayi Anda dengan mudah',
                    ),
                    _HorizontalMenuItem(
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
                    _HorizontalMenuItem(
                      onTap: () {
                        context.read<ObstetriCubit>().getObstetri();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ObstetriScreen(),
                          ),
                        );
                      },
                      image: Image.asset('assets/pregnancy.png'),
                      label: 'Obstetri',
                      deskripsi: 'Panduan seputar kehamilan dan persalinan.',
                    ),
                    _HorizontalMenuItem(
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
                      deskripsi: 'Catat dan pantau jadwal serta durasi menyusui.',
                    ),
                    _HorizontalMenuItem(
                      onTap: () {
                        context.read<ScreeningPPDCubit>().getScreeningPPD();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScreeningPPDScreen(),
                          ),
                        );
                      },
                      image: Image.asset('assets/ppd.png'),
                      label: 'Screening PPD',
                      deskripsi: 'Skrining kesehatan mental ibu pasca persalinan.',
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

class _HorizontalMenuItem extends StatelessWidget {
  const _HorizontalMenuItem({
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

class _GridMenuItem extends StatelessWidget {
  const _GridMenuItem({
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
