import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mommy_be/pages/laktasi.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Home'),
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
              GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2 / 3,
                ),
                children: [
                  MenuItem(
                    onTap: () {},
                    image: Image.asset('assets/baby-monitor.png'),
                    label: 'Bayi',
                  ),
                  MenuItem(
                    onTap: () {},
                    image: Image.asset('assets/food.png'),
                    label: 'Nutrisi Harian',
                  ),
                  MenuItem(
                    onTap: () {},
                    image: Image.asset('assets/pregnancy.png'),
                    label: 'Kehamilan',
                  ),
                  MenuItem(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LaktasiScreen(),
                        ),
                      );
                    },
                    image: Image.asset('assets/bottle.png'),
                    label: 'Laktasi',
                  ),
                  MenuItem(
                    onTap: () {},
                    image: Image.asset('assets/pregnancy.png'),
                    label: 'Kehamilan',
                  ),
                  MenuItem(
                    onTap: () {},
                    image: Image.asset('assets/pregnancy.png'),
                    label: 'Kehamilan',
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

class MenuItem extends StatelessWidget {
  const MenuItem({
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
