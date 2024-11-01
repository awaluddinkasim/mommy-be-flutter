import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/status_gizi_cubit.dart';
import 'package:mommy_be/cubit/status_gizi_state.dart';
import 'package:mommy_be/data/status_gizi.dart';
import 'package:mommy_be/models/status_gizi.dart';
import 'package:mommy_be/shared/widgets/dialog/loading.dart';
import 'package:mommy_be/shared/widgets/dialog/message.dart';
import 'package:mommy_be/shared/widgets/input.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:mommy_be/shared/widgets/select.dart';
import 'package:numberpicker/numberpicker.dart';

class StatusGiziEditScreen extends StatefulWidget {
  final StatusGizi statusGizi;

  const StatusGiziEditScreen({super.key, required this.statusGizi});

  @override
  State<StatusGiziEditScreen> createState() => _StatusGiziEditScreenState();
}

class _StatusGiziEditScreenState extends State<StatusGiziEditScreen> {
  final _tb = TextEditingController();
  final _bbSebelumHamil = TextEditingController();
  final _bbSaatHamil = TextEditingController();
  final _bbSetelahHamil = TextEditingController();

  late double _tinggiBadan;
  late double _beratBadanSebelumHamil;
  late double _beratBadanSaatHamil;
  late double _beratBadanSetelahHamil;

  String? _aktifitasHarian;

  final List<Map> _aktifitasHarianList = [
    {"nama": "Sedentary", "penjelasan": "Sedikit bergerak, banyak duduk"},
    {"nama": "Sedikit Aktif", "penjelasan": "Olahraga 1-3 kali/pekan"},
    {"nama": "Moderat", "penjelasan": "Olahraga 3/5 kali/pekan"},
    {"nama": "Aktif", "penjelasan": "Olahraga 6-7 kali/pekan"},
    {"nama": "Sangat Aktif", "penjelasan": "Olahraga berat setiap hari"},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _tb.text = widget.statusGizi.tinggiBadan.toString();
      _bbSebelumHamil.text = widget.statusGizi.bbSebelumHamil.toString();
      _bbSaatHamil.text = widget.statusGizi.bbSaatHamil.toString();
      _bbSetelahHamil.text = widget.statusGizi.bbSetelahMelahirkan.toString();

      setState(() {
        _tinggiBadan = widget.statusGizi.tinggiBadan;
        _beratBadanSebelumHamil = widget.statusGizi.bbSebelumHamil;
        _beratBadanSaatHamil = widget.statusGizi.bbSaatHamil;
        _beratBadanSetelahHamil = widget.statusGizi.bbSetelahMelahirkan;
        _aktifitasHarian = widget.statusGizi.aktifitasHarian.toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<StatusGiziCubit, StatusGiziState>(
          listener: (context, state) {
            if (state is StatusGiziLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const LoadingDialog();
                },
              );
            }
            if (state is StatusGiziFailed) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              showDialog(
                context: context,
                builder: (context) {
                  return MessageDialog(
                    status: 'Gagal',
                    message: state.error,
                    onOkPressed: () {
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                    },
                  );
                },
              );
            }
            if (state is StatusGiziSuccess) {
              final navigator = Navigator.of(context);

              navigator.pop();
              navigator.pop();
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: PageTitle(title: "Edit Status Gizi"),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                        value: _aktifitasHarian,
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
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1),
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
                      ),
                      const SizedBox(height: 32),
                      FilledButton(
                        onPressed: () {
                          context.read<StatusGiziCubit>().updateStatusGizi(
                                widget.statusGizi,
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
