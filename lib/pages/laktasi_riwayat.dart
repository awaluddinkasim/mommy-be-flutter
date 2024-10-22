import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/cubit/laktasi_cubit.dart';
import 'package:mommy_be/cubit/laktasi_grafik_cubit.dart';
import 'package:mommy_be/cubit/laktasi_grafik_state.dart';
import 'package:mommy_be/cubit/laktasi_state.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/models/laktasi.dart';
import 'package:mommy_be/models/laktasi_grafik.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LaktasiRiwayatScreen extends StatefulWidget {
  const LaktasiRiwayatScreen({super.key, required this.baby});
  final Bayi baby;

  @override
  State<LaktasiRiwayatScreen> createState() => _LaktasiRiwayatScreenState();
}

class _LaktasiRiwayatScreenState extends State<LaktasiRiwayatScreen> {
  DateTime _tanggal = DateTime.now();

  @override
  void initState() {
    super.initState();
    final laktasi = context.read<LaktasiCubit>();
    Future.delayed(Duration.zero, () {
      laktasi.getLaktasi(widget.baby.id, _tanggal);
    });
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: PageTitle(title: "Riwayat Laktasi"),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Tanggal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                DateFormat('dd MMMM yyyy', 'ID').format(_tanggal),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  final riwayat = context.read<LaktasiCubit>();

                                  showDatePicker(
                                    context: context,
                                    initialDate: _tanggal,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _tanggal = value;
                                      });

                                      riwayat.getLaktasi(widget.baby.id, _tanggal);
                                    }
                                  });
                                },
                                icon: const Icon(Icons.date_range),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<LaktasiCubit, LaktasiState>(
                        builder: (context, state) {
                          if (state is LaktasiSuccess) {
                            if (state.laktasiList.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 36),
                                child: Text(
                                  "Tidak ada riwayat",
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }

                            context.read<LaktasiGrafikCubit>().getLaktasiCharts(widget.baby.id, _tanggal);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FilledButton.icon(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return DraggableScrollableSheet(
                                          expand: false,
                                          initialChildSize: 0.5,
                                          minChildSize: 0.5,
                                          maxChildSize: 0.9,
                                          builder: (context, scrollController) {
                                            return SingleChildScrollView(
                                              controller: scrollController,
                                              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                                              child: _Charts(baby: widget.baby, tanggal: _tanggal),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(CupertinoIcons.chart_bar_circle),
                                  label: const Text("Chart"),
                                ),
                                const SizedBox(height: 16),
                                DataTable(
                                  columnSpacing: 20,
                                  columns: const [
                                    DataColumn(label: Text('Posisi')),
                                    DataColumn(label: Text('Pukul')),
                                    DataColumn(label: Text('Durasi')),
                                  ],
                                  rows: [
                                    for (Laktasi laktasi in state.laktasiList)
                                      DataRow(
                                        cells: [
                                          DataCell(Text(laktasi.posisi)),
                                          DataCell(
                                            Text(DateFormat('HH:mm').format(laktasi.pukul)),
                                          ),
                                          DataCell(
                                            Text(laktasi.durasi),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ],
                            );
                          }

                          if (state is LaktasiLoading) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 36),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: RetryButton(
                              message: (state is LaktasiFailed) ? state.message : "Terjadi kesalahan",
                              onPressed: () => context.read<LaktasiCubit>().getLaktasi(widget.baby.id, _tanggal),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Charts extends StatefulWidget {
  final Bayi baby;
  final DateTime tanggal;

  const _Charts({
    required this.baby,
    required this.tanggal,
  });

  @override
  State<_Charts> createState() => _ChartsState();
}

class _ChartsState extends State<_Charts> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -25,
          child: Container(
            width: 50,
            height: 5,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              "Chart Laktasi ${DateFormat('dd MMMM yyyy', 'ID').format(widget.tanggal)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            BlocBuilder<LaktasiGrafikCubit, LaktasiGrafikState>(
              builder: (context, state) {
                if (state is LaktasiGrafikInitial) {
                  return Container();
                }

                if (state is LaktasiLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 36),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is LaktasiGrafikSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SfCartesianChart(
                        title: const ChartTitle(
                          text: 'Chart Durasi (Kiri)',
                        ),
                        primaryXAxis: const NumericAxis(
                          interval: 1,
                        ),
                        primaryYAxis: const NumericAxis(
                          title: AxisTitle(
                            text: 'Durasi (Menit)',
                          ),
                        ),
                        series: [
                          LineSeries<LaktasiGrafik, dynamic>(
                            animationDuration: 500,
                            dataSource: state.kiri
                                .map(
                                  (e) => LaktasiGrafik(
                                    e.index,
                                    e.durasi,
                                  ),
                                )
                                .toList(),
                            xValueMapper: (LaktasiGrafik data, _) => data.index,
                            yValueMapper: (LaktasiGrafik data, _) => data.durasi,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SfCartesianChart(
                        title: const ChartTitle(
                          text: 'Chart Durasi (Kanan)',
                        ),
                        primaryXAxis: const NumericAxis(
                          interval: 1,
                        ),
                        primaryYAxis: const NumericAxis(
                          title: AxisTitle(
                            text: 'Durasi (Menit)',
                          ),
                          axisLine: AxisLine(width: 1),
                        ),
                        series: [
                          LineSeries<LaktasiGrafik, dynamic>(
                            animationDuration: 500,
                            dataSource: state.kanan
                                .map(
                                  (e) => LaktasiGrafik(
                                    e.index,
                                    e.durasi,
                                  ),
                                )
                                .toList(),
                            xValueMapper: (LaktasiGrafik data, _) => data.index,
                            yValueMapper: (LaktasiGrafik data, _) => data.durasi,
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: RetryButton(
                    message: (state is LaktasiGrafikFailed) ? state.message : "Terjadi kesalahan",
                    onPressed: () => context.read<LaktasiGrafikCubit>().getLaktasiCharts(widget.baby.id, widget.tanggal),
                  ),
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
