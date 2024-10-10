import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/cubit/bayi_cubit.dart';
import 'package:mommy_be/cubit/bayi_state.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/pages/monitor_laktasi.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';

class LaktasiScreen extends StatefulWidget {
  const LaktasiScreen({super.key});

  @override
  State<LaktasiScreen> createState() => _LaktasiScreenState();
}

class _LaktasiScreenState extends State<LaktasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: PageTitle(title: "Laktasi"),
              ),
              const SizedBox(height: 16),
              BlocBuilder<BayiCubit, BayiState>(
                builder: (context, state) {
                  if (state is BayiSuccess) {
                    if (state.bayiList.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 36),
                        child: Text(
                          "Belum ada data bayi",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (Bayi bayi in state.bayiList)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MonitorLaktasiScreen(
                                        baby: bayi,
                                      ),
                                    ),
                                  );
                                },
                                leading: Image.asset(
                                  "assets/icon/baby.png",
                                  width: 50,
                                ),
                                title: Text(
                                  bayi.nama,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(bayi.jenisKelamin),
                                trailing:
                                    const Icon(Icons.chevron_right_rounded),
                              ),
                            ),
                        ],
                      ),
                    );
                  }

                  if (state is BayiLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: RetryButton(
                      message: (state is BayiFailed)
                          ? state.message
                          : "Terjadi kesalahan",
                      onPressed: () => context.read<BayiCubit>().getBayi(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
