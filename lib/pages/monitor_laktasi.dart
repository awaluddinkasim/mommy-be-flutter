import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mommy_be/cubit/laktasi_cubit.dart';
import 'package:mommy_be/cubit/laktasi_state.dart';
import 'package:mommy_be/data/laktasi.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/pages/laktasi_riwayat.dart';
import 'package:mommy_be/shared/widgets/dialog/loading.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class MonitorLaktasiScreen extends StatefulWidget {
  final Bayi baby;

  const MonitorLaktasiScreen({super.key, required this.baby});

  @override
  State<MonitorLaktasiScreen> createState() => _MonitorLaktasiScreenState();
}

class _MonitorLaktasiScreenState extends State<MonitorLaktasiScreen> {
  late DateTime _currentTime;
  String _posisi = 'Kiri';
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  void _submit(int duration) async {
    context
        .read<LaktasiCubit>()
        .postLaktasi(
          DataLaktasi(
            babyId: widget.baby.id,
            posisi: _posisi,
            durasi: duration,
            mulai: _currentTime,
          ),
        )
        .then(
      (_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LaktasiRiwayatScreen(
              baby: widget.baby,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(child: PageTitle(title: "Monitor Laktasi")),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LaktasiRiwayatScreen(
                              baby: widget.baby,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.history),
                      label: const Text('Riwayat'),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/svg/breastfeeding.svg',
                width: 300,
              ),
              const SizedBox(height: 16),
              const Text(
                'Posisi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StreamBuilder(
                stream: _stopWatchTimer.rawTime,
                initialData: 0,
                builder: (context, snap) {
                  final value = snap.data;
                  final displayTime = StopWatchTimer.getDisplayTime(value ?? 0);

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              value: 'Kiri',
                              title: const Text('Kiri'),
                              groupValue: _posisi,
                              onChanged: _stopWatchTimer.isRunning
                                  ? null
                                  : (posisi) {
                                      setState(() {
                                        _posisi = 'Kiri';
                                      });
                                    },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              value: 'Kanan',
                              title: const Text('Kanan'),
                              groupValue: _posisi,
                              onChanged: _stopWatchTimer.isRunning
                                  ? null
                                  : (posisi) {
                                      setState(() {
                                        _posisi = 'Kanan';
                                      });
                                    },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          displayTime,
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (!_stopWatchTimer.isRunning)
                        FilledButton(
                          onPressed: () {
                            _currentTime = DateTime.now();
                            _stopWatchTimer.onResetTimer();
                            _stopWatchTimer.onStartTimer();
                          },
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                              Colors.blue,
                            ),
                          ),
                          child: const Text("Mulai"),
                        )
                      else
                        FilledButton(
                          onPressed: () {
                            _stopWatchTimer.onStopTimer();
                            _submit(_stopWatchTimer.rawTime.value);
                          },
                          child: const Text("Selesai"),
                        ),
                    ],
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
