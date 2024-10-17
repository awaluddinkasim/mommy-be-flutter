import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/status_gizi_cubit.dart';
import 'package:mommy_be/cubit/status_gizi_state.dart';
import 'package:mommy_be/data/status_gizi.dart';
import 'package:mommy_be/models/obstetri.dart';
import 'package:mommy_be/shared/widgets/input.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';
import 'package:mommy_be/shared/widgets/select.dart';
import 'package:numberpicker/numberpicker.dart';

class StatusGiziScreen extends StatefulWidget {
  final Obstetri obstetri;
  const StatusGiziScreen({super.key, required this.obstetri});

  @override
  State<StatusGiziScreen> createState() => _StatusGiziScreenState();
}

class _StatusGiziScreenState extends State<StatusGiziScreen> {
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
                child: PageTitle(title: "Status Gizi Kehamilan ke-${widget.obstetri.kehamilan}"),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: BlocBuilder<StatusGiziCubit, StatusGiziState>(
                    builder: (context, state) {
                      if (state is StatusGiziLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (state is StatusGiziSuccess) {
                        if (state.statusGizi == null) {
                          return _FormStatusGizi(
                            obstetri: widget.obstetri,
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Table(
                              columnWidths: const {
                                0: FlexColumnWidth(2),
                                1: FixedColumnWidth(16),
                                2: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    const Text("Tinggi Badan"),
                                    const Text(":"),
                                    Text("${state.statusGizi!.tinggiBadan} cm"),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    const Text("Berat Badan Sebelum Hamil"),
                                    const Text(":"),
                                    Text("${state.statusGizi!.bbSebelumHamil} kg"),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    const Text("Berat Badan Saat Hamil"),
                                    const Text(":"),
                                    Text("${state.statusGizi!.bbSaatHamil} kg"),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    const Text("Berat Badan Setelah Hamil"),
                                    const Text(":"),
                                    Text("${state.statusGizi!.bbSetelahMelahirkan} kg"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Table(
                              columnWidths: const {
                                0: FlexColumnWidth(2),
                                1: FixedColumnWidth(16),
                                2: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    const Text("IMT Pra Hamil"),
                                    const Text(":"),
                                    Text(
                                      "${state.statusGizi!.imtPraHamil}",
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    const Text("IMT Setelah Hamil"),
                                    const Text(":"),
                                    Text(
                                      "${state.statusGizi!.imtPostHamil}",
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    const Text("Resistensi Berat Badan"),
                                    const Text(":"),
                                    Text(
                                      "${state.statusGizi!.resistensiBB} kg",
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text.rich(TextSpan(children: [
                              const TextSpan(text: "Total kebutuhan kalori yang Anda butuhkan sehari-hari selama menyusui adalah "),
                              TextSpan(
                                text: "${state.statusGizi!.kebutuhanKalori} kkal",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ])),
                          ],
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: RetryButton(
                          message: (state is StatusGiziFailed) ? state.error : "Terjadi kesalahan",
                          onPressed: () => context.read<StatusGiziCubit>().getStatusGizi(widget.obstetri),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormStatusGizi extends StatefulWidget {
  final Obstetri obstetri;
  const _FormStatusGizi({required this.obstetri});

  @override
  State<_FormStatusGizi> createState() => __FormStatusGiziState();
}

class __FormStatusGiziState extends State<_FormStatusGizi> {
  final _tb = TextEditingController();
  final _bbSebelumHamil = TextEditingController();
  final _bbSaatHamil = TextEditingController();
  final _bbSetelahHamil = TextEditingController();

  double _tinggiBadan = 100.0;
  double _beratBadanSebelumHamil = 50.00;
  double _beratBadanSaatHamil = 50.00;
  double _beratBadanSetelahHamil = 50.00;

  String? _aktifitasHarian;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Input(
          controller: _tb,
          label: "Tinggi Badan",
          icon: const Icon(Icons.height),
          hintText: "Masukkan tinggi badan",
          readOnly: true,
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Tinggi Badan"),
              content: StatefulBuilder(
                builder: (context, setState1) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecimalNumberPicker(
                        value: _tinggiBadan,
                        minValue: 100,
                        maxValue: 250,
                        decimalPlaces: 1,
                        onChanged: (value) => setState1(() {
                          _tinggiBadan = value;
                        }),
                      ),
                    ],
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _tb.text = _tinggiBadan.toString();
                    Navigator.pop(context);
                  },
                  child: const Text("Tutup"),
                ),
              ],
            ),
          ),
        ),
        Input(
          controller: _bbSebelumHamil,
          label: "Berat Badan Sebelum Hamil",
          icon: const Icon(Icons.line_weight_rounded),
          hintText: "Masukkan berat badan",
          readOnly: true,
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Berat Badan"),
              content: StatefulBuilder(
                builder: (context, setState2) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecimalNumberPicker(
                        value: _beratBadanSebelumHamil,
                        minValue: 50,
                        maxValue: 200,
                        decimalPlaces: 2,
                        onChanged: (value) => setState2(() {
                          _beratBadanSebelumHamil = value;
                        }),
                      ),
                    ],
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _bbSebelumHamil.text = _beratBadanSebelumHamil.toString();
                    Navigator.pop(context);
                  },
                  child: const Text("Tutup"),
                ),
              ],
            ),
          ),
        ),
        Input(
          controller: _bbSaatHamil,
          label: "Berat Badan Saat Hamil",
          icon: const Icon(Icons.line_weight_rounded),
          hintText: "Masukkan berat badan",
          readOnly: true,
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Berat Badan"),
              content: StatefulBuilder(
                builder: (context, setState3) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecimalNumberPicker(
                        value: _beratBadanSaatHamil,
                        minValue: 50,
                        maxValue: 200,
                        decimalPlaces: 2,
                        onChanged: (value) => setState3(() {
                          _beratBadanSaatHamil = value;
                        }),
                      ),
                    ],
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _bbSaatHamil.text = _beratBadanSaatHamil.toString();
                    Navigator.pop(context);
                  },
                  child: const Text("Tutup"),
                ),
              ],
            ),
          ),
        ),
        Input(
          controller: _bbSetelahHamil,
          label: "Berat Badan Setelah Hamil",
          icon: const Icon(Icons.line_weight_rounded),
          hintText: "Masukkan berat badan",
          readOnly: true,
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Berat Badan"),
              content: StatefulBuilder(
                builder: (context, setState4) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecimalNumberPicker(
                        value: _beratBadanSetelahHamil,
                        minValue: 50,
                        maxValue: 200,
                        decimalPlaces: 2,
                        onChanged: (value) => setState4(() {
                          _beratBadanSetelahHamil = value;
                        }),
                      ),
                    ],
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _bbSetelahHamil.text = _beratBadanSetelahHamil.toString();
                    Navigator.pop(context);
                  },
                  child: const Text("Tutup"),
                ),
              ],
            ),
          ),
        ),
        Select(
          label: "Jenis Aktifitas Harian",
          icon: const Icon(Icons.fitness_center),
          hint: "Pilih Jenis Aktifitas Harian",
          items: const [
            DropdownMenuItem(
              value: "sedentary",
              child: Text("Sedentary"),
            ),
            DropdownMenuItem(
              value: "sedikit_aktif",
              child: Text("Sedikit Aktif"),
            ),
            DropdownMenuItem(
              value: "moderat",
              child: Text("Moderat"),
            ),
            DropdownMenuItem(
              value: "aktif",
              child: Text("Aktif"),
            ),
            DropdownMenuItem(
              value: "sangat_aktif",
              child: Text("Sangat Aktif"),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _aktifitasHarian = value!;
            });
          },
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () {
            context.read<StatusGiziCubit>().postStatusGizi(
                  widget.obstetri,
                  DataStatusGizi(
                    tinggiBadan: _tinggiBadan,
                    bbSebelumHamil: _beratBadanSebelumHamil,
                    bbSaatHamil: _beratBadanSaatHamil,
                    bbSetelahMelahirkan: _beratBadanSetelahHamil,
                    aktifitasHarian: _aktifitasHarian!,
                  ),
                );
          },
          child: const Text("Simpan"),
        ),
      ],
    );
  }
}
