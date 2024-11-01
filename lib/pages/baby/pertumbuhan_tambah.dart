import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/cubit/pertumbuhan_cubit.dart';
import 'package:mommy_be/cubit/pertumbuhan_state.dart';
import 'package:mommy_be/data/pertumbuhan.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/shared/widgets/dialog/loading.dart';
import 'package:mommy_be/shared/widgets/dialog/message.dart';
import 'package:mommy_be/shared/widgets/input.dart';
import 'package:numberpicker/numberpicker.dart';

class BabyTambahPertumbuhanScreen extends StatefulWidget {
  final Bayi bayi;
  const BabyTambahPertumbuhanScreen({super.key, required this.bayi});

  @override
  State<BabyTambahPertumbuhanScreen> createState() => _BabyTambahPertumbuhanScreenState();
}

class _BabyTambahPertumbuhanScreenState extends State<BabyTambahPertumbuhanScreen> {
  final _formKey = GlobalKey<FormState>();

  final _tgl = TextEditingController();
  final _pb = TextEditingController();
  final _bb = TextEditingController();

  DateTime? _tanggal;
  double _panjangBadan = 25.0;
  double _beratBadan = 10.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Tambah Data Pertumbuhan"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocListener<PertumbuhanCubit, PertumbuhanState>(
          listener: (context, state) {
            if (state is PertumbuhanLoading) {
              showDialog(
                context: context,
                builder: (context) => const LoadingDialog(),
              );
            }

            if (state is PertumbuhanFailed) {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) => MessageDialog(
                  message: state.message,
                  status: 'Gagal',
                  onOkPressed: () {
                    Navigator.pop(context);
                  },
                ),
              );
            }

            if (state is PertumbuhanSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Input(
                  controller: _tgl,
                  label: "Tanggal",
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() {
                        _tanggal = date;
                        _tgl.text = DateFormat(
                          'dd MMMM yyyy',
                          'ID',
                        ).format(date);
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  hintText: "Pilih tanggal",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Tanggal tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                Input(
                  controller: _pb,
                  label: "Panjang Badan (cm)",
                  icon: const Icon(Icons.height),
                  hintText: "Masukkan tinggi badan",
                  readOnly: true,
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Panjang Badan"),
                      content: StatefulBuilder(
                        builder: (context, setState1) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DecimalNumberPicker(
                                value: _panjangBadan,
                                minValue: 0,
                                maxValue: 200,
                                decimalPlaces: 1,
                                onChanged: (value) => setState1(() {
                                  _panjangBadan = value;
                                }),
                              ),
                            ],
                          );
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _pb.text = _panjangBadan.toString();
                            Navigator.pop(context);
                          },
                          child: const Text("Tutup"),
                        ),
                      ],
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Panjang badan tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                Input(
                  controller: _bb,
                  label: "Berat Badan (kg)",
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
                                value: _beratBadan,
                                minValue: 0,
                                maxValue: 100,
                                decimalPlaces: 2,
                                onChanged: (value) => setState2(() {
                                  _beratBadan = value;
                                }),
                              ),
                            ],
                          );
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _bb.text = _beratBadan.toString();
                            Navigator.pop(context);
                          },
                          child: const Text("Tutup"),
                        ),
                      ],
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Berat badan tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<PertumbuhanCubit>().storePertumbuhan(
                            widget.bayi,
                            DataPertumbuhan(
                              tanggal: _tanggal!,
                              panjangBadan: _panjangBadan,
                              beratBadan: _beratBadan,
                            ),
                          );
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
