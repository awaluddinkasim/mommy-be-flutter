import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/cubit/pertumbuhan_cubit.dart';
import 'package:mommy_be/cubit/pertumbuhan_state.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/models/pertumbuhan.dart';
import 'package:mommy_be/pages/baby/pertumbuhan_tambah.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BabyPertumbuhanScreen extends StatefulWidget {
  final Bayi bayi;
  const BabyPertumbuhanScreen({super.key, required this.bayi});

  @override
  State<BabyPertumbuhanScreen> createState() => _BabyPertumbuhanScreenState();
}

class _BabyPertumbuhanScreenState extends State<BabyPertumbuhanScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      context.read<PertumbuhanCubit>().getPertumbuhan(widget.bayi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BabyTambahPertumbuhanScreen(
                            bayi: widget.bayi,
                          ),
                        ),
                      );
                    },
                    child: const Text("Tambah Data"),
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<PertumbuhanCubit, PertumbuhanState>(builder: (context, state) {
                  if (state is PertumbuhanLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is PertumbuhanSuccess) {
                    if (state.pertumbuhan.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text("Belum ada data"),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        if (state.pertumbuhan.length > 1)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SfCartesianChart(
                                  title: const ChartTitle(
                                    text: 'Chart Pertumbuhan',
                                  ),
                                  primaryXAxis: const CategoryAxis(),
                                  primaryYAxis: const NumericAxis(),
                                  legend: const Legend(isVisible: true),
                                  series: [
                                    AreaSeries<Pertumbuhan, dynamic>(
                                      name: 'Panjang Badan',
                                      color: Colors.green.withOpacity(0.3),
                                      animationDuration: 500,
                                      dataSource: state.pertumbuhan,
                                      xValueMapper: (Pertumbuhan data, _) => DateFormat('dd MMM yy', 'ID').format(data.tanggal),
                                      yValueMapper: (Pertumbuhan data, _) => data.panjangBadan,
                                    ),
                                    AreaSeries<Pertumbuhan, dynamic>(
                                      name: 'Berat Badan',
                                      color: Colors.blue.withOpacity(0.3),
                                      animationDuration: 500,
                                      dataSource: state.pertumbuhan,
                                      xValueMapper: (Pertumbuhan data, _) => DateFormat('dd MMM yy', 'ID').format(data.tanggal),
                                      yValueMapper: (Pertumbuhan data, _) => data.beratBadan,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        for (Pertumbuhan data in state.pertumbuhan) _DataItem(data: data, widget: widget),
                      ],
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: RetryButton(
                      message: (state is PertumbuhanFailed) ? state.message : "Terjadi kesalahan",
                      onPressed: () => context.read<PertumbuhanCubit>().getPertumbuhan(widget.bayi),
                    ),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DataItem extends StatelessWidget {
  final Pertumbuhan data;
  const _DataItem({
    required this.data,
    required this.widget,
  });

  final BabyPertumbuhanScreen widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        title: Text(DateFormat('dd MMMM yyyy', 'ID').format(data.tanggal)),
        subtitle: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Panjang Badan"),
                  Text("Berat Badan"),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${data.panjangBadan} cm",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${data.beratBadan} kg",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        onTap: () {
                          context.read<PertumbuhanCubit>().deletePertumbuhan(
                                widget.bayi,
                                data.id,
                              );
                          Navigator.pop(context);
                        },
                        title: const Text("Hapus"),
                        leading: const Icon(Icons.delete),
                      )
                    ],
                  ),
                );
              },
            );
          },
          icon: const Icon(
            CupertinoIcons.ellipsis_vertical,
          ),
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
