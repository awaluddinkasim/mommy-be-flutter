import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/status_gizi_cubit.dart';
import 'package:mommy_be/cubit/status_gizi_state.dart';
import 'package:mommy_be/data/status_gizi.dart';
import 'package:mommy_be/models/obstetri.dart';
import 'package:mommy_be/pages/status_gizi_edit.dart';
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
  String _kategoriIMT(double imt) {
    if (imt < 18.5) {
      return "Kurus";
    } else if (imt < 24.9) {
      return "Normal";
    } else if (imt < 29.9) {
      return "Gemuk";
    } else {
      return "Obesitas";
    }
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
                                0: FlexColumnWidth(1.5),
                                1: FixedColumnWidth(16),
                                2: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    const Text("IMT Pra Hamil"),
                                    const Text(":"),
                                    Text(
                                      "${state.statusGizi!.imtPraHamil} (${_kategoriIMT(state.statusGizi!.imtPraHamil)})",
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    const Text("IMT Setelah Hamil"),
                                    const Text(":"),
                                    Text(
                                      "${state.statusGizi!.imtPostHamil} (${_kategoriIMT(state.statusGizi!.imtPostHamil)})",
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
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: "Total kebutuhan kalori yang Anda butuhkan sehari-hari selama menyusui adalah "),
                                  TextSpan(
                                    text: "${state.statusGizi!.kebutuhanKalori} kkal",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            FilledButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StatusGiziEditScreen(statusGizi: state.statusGizi!),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit_note),
                              label: const Text("Edit"),
                            ),
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

  double _tinggiBadan = 150.0;
  double _beratBadanSebelumHamil = 60.00;
  double _beratBadanSaatHamil = 60.00;
  double _beratBadanSetelahHamil = 60.00;

  String? _aktifitasHarian;

  final List<Map> _aktifitasHarianList = [
    {"nama": "Sedentary", "penjelasan": "Sedikit bergerak, banyak duduk"},
    {"nama": "Sedikit Aktif", "penjelasan": "Olahraga 1-3 kali/pekan"},
    {"nama": "Moderat", "penjelasan": "Olahraga 3/5 kali/pekan"},
    {"nama": "Aktif", "penjelasan": "Olahraga 6-7 kali/pekan"},
    {"nama": "Sangat Aktif", "penjelasan": "Olahraga berat setiap hari"},
  ];

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
                        minValue: 30,
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
                        minValue: 30,
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
                        minValue: 30,
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
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1.5),
                  1: FixedColumnWidth(12),
                  2: FlexColumnWidth(2),
                },
                children: [
                  for (var aktifitas in _aktifitasHarianList)
                    TableRow(
                      children: [
                        TableCell(child: Text(aktifitas['nama'])),
                        const TableCell(child: Text(":")),
                        TableCell(child: Text(aktifitas['penjelasan'])),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        FilledButton(
          onPressed: () {
            context.read<StatusGiziCubit>().storeStatusGizi(
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
