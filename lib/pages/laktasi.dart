import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class LaktasiScreen extends StatefulWidget {
  const LaktasiScreen({super.key});

  @override
  State<LaktasiScreen> createState() => _LaktasiScreenState();
}

class _LaktasiScreenState extends State<LaktasiScreen> {
  late DateTime _currentTime;
  String _posisi = 'Kiri';
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  void _submit(int duration) async {
    print(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset('assets/svg/breastfeeding.svg'),
            const SizedBox(height: 16),
            StreamBuilder(
              stream: _stopWatchTimer.rawTime,
              initialData: 0,
              builder: (context, snap) {
                final value = snap.data;
                final displayTime = StopWatchTimer.getDisplayTime(value ?? 0);

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        displayTime,
                        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
    );
  }
}
