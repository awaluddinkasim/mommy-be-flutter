import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/obstetri_cubit.dart';
import 'package:mommy_be/cubit/obstetri_state.dart';
import 'package:mommy_be/data/obstetri.dart';
import 'package:mommy_be/shared/widgets/dialog/loading.dart';
import 'package:mommy_be/shared/widgets/dialog/message.dart';
import 'package:mommy_be/shared/widgets/input.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:mommy_be/shared/widgets/select.dart';

class ObstetriCreateScreen extends StatefulWidget {
  const ObstetriCreateScreen({super.key});

  @override
  State<ObstetriCreateScreen> createState() => _ObstetriCreateScreenState();
}

class _ObstetriCreateScreenState extends State<ObstetriCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final _kehamilan = TextEditingController();
  final _persalinan = TextEditingController();
  final _riwayatAbortus = TextEditingController();
  final _jarakKelahiran = TextEditingController();

  String? _metodePersalinan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<ObstetriCubit, ObstetriState>(
          listener: (context, state) {
            if (state is ObstetriLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const LoadingDialog();
                },
              );
            }
            if (state is ObstetriFailed) {
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
            if (state is ObstetriSuccess) {
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
                  child: PageTitle(title: "Tambah Data"),
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Input(
                        controller: _kehamilan,
                        label: "Kehamilan ke",
                        icon: const Icon(Icons.numbers),
                        hintText: "Masukkan data",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Wajib diisi";
                          }
                          return null;
                        },
                      ),
                      Input(
                        controller: _persalinan,
                        label: "Persalinan ke",
                        icon: const Icon(Icons.numbers),
                        hintText: "Masukkan data",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Wajib diisi";
                          }
                          return null;
                        },
                      ),
                      Input(
                        controller: _riwayatAbortus,
                        label: "Riwayat Abortus",
                        icon: const Icon(Icons.numbers),
                        hintText: "Masukkan data",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Wajib diisi";
                          }
                          return null;
                        },
                      ),
                      Select(
                        label: "Metode Persalinan",
                        icon: const Icon(Icons.data_array),
                        hint: "Pilih metode persalinan",
                        items: const [
                          DropdownMenuItem(
                            value: "normal",
                            child: Text("Normal"),
                          ),
                          DropdownMenuItem(
                            value: "caesar",
                            child: Text("Caesar"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _metodePersalinan = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Pilih metode";
                          }
                          return null;
                        },
                      ),
                      Input(
                        controller: _jarakKelahiran,
                        label: "Jarak Kelahiran",
                        icon: const Icon(Icons.numbers),
                        hintText: "Masukkan data",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Wajib diisi";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ObstetriCubit>().storeObstetri(
                                  DataObstetri(
                                    kehamilan: int.parse(_kehamilan.text),
                                    persalinan: int.parse(_persalinan.text),
                                    riwayatAbortus:
                                        int.parse(_riwayatAbortus.text),
                                    metodePersalinan: _metodePersalinan!,
                                    jarakKelahiran:
                                        int.parse(_jarakKelahiran.text),
                                  ),
                                );
                          }
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
