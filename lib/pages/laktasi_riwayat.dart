import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/cubit/laktasi_cubit.dart';
import 'package:mommy_be/cubit/laktasi_state.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/models/laktasi.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';

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
    Future.delayed(Duration.zero, () {
      context.read<LaktasiCubit>().getLaktasi(widget.baby.id, _tanggal);
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
                                DateFormat('dd MMMM yyyy', 'ID')
                                    .format(_tanggal),
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

                            return DataTable(
                              columns: const [
                                DataColumn(label: Text('Posisi')),
                                DataColumn(label: Text('Mulai')),
                                DataColumn(label: Text('Selesai')),
                              ],
                              rows: [
                                for (Laktasi laktasi in state.laktasiList)
                                  DataRow(
                                    cells: [
                                      DataCell(Text(laktasi.posisi)),
                                      DataCell(
                                        Text(DateFormat('HH:mm')
                                            .format(laktasi.mulai)),
                                      ),
                                      DataCell(
                                        Text(DateFormat('HH:mm')
                                            .format(laktasi.selesai)),
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
                              message: (state is LaktasiFailed)
                                  ? state.message
                                  : "Terjadi kesalahan",
                              onPressed: () => context
                                  .read<LaktasiCubit>()
                                  .getLaktasi(widget.baby.id, _tanggal),
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
