import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mommy_be/cubit/makanan_cubit.dart';
import 'package:mommy_be/cubit/makanan_state.dart';
import 'package:mommy_be/cubit/nutrisi_harian_cubit.dart';
import 'package:mommy_be/cubit/nutrisi_harian_state.dart';
import 'package:mommy_be/data/nutrisi_harian.dart';
import 'package:mommy_be/models/makanan.dart';
import 'package:mommy_be/shared/widgets/dialog/loading.dart';
import 'package:mommy_be/shared/widgets/dialog/message.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';
import 'package:mommy_be/shared/widgets/select.dart';

class MakananScreen extends StatefulWidget {
  const MakananScreen({super.key});

  @override
  State<MakananScreen> createState() => _MakananScreenState();
}

class _MakananScreenState extends State<MakananScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _selectedSesi;
  Makanan? _selectedMakanan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<NutrisiHarianCubit, NutrisiHarianState>(
          listener: (context, state) {
            if (state is NutrisiHarianLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const LoadingDialog();
                },
              );
            }
            if (state is NutrisiHarianFailed) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              showDialog(
                context: context,
                builder: (context) {
                  return MessageDialog(
                    status: 'Gagal',
                    message: state.message,
                    onOkPressed: () {
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                    },
                  );
                },
              );
            }
            if (state is NutrisiHarianSuccess) {
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
                const PageTitle(title: "Tambah Makanan"),
                const SizedBox(height: 16),
                SvgPicture.asset(
                  'assets/svg/food.svg',
                  height: 300,
                ),
                const SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BlocBuilder<MakananCubit, MakananState>(
                        builder: (context, state) {
                          if (state is MakananLoading) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          if (state is MakananSuccess) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Select(
                                  label: "Sesi",
                                  icon: const Icon(CupertinoIcons.clock),
                                  hint: "Pilih sesi",
                                  items: const [
                                    DropdownMenuItem(
                                      value: "Sarapan",
                                      child: Text("Sarapan"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Snack 1",
                                      child: Text("Snack 1"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Makan Siang",
                                      child: Text("Makan Siang"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Snack 2",
                                      child: Text("Snack 2"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Makan Malam",
                                      child: Text("Makan Malam"),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSesi = value!;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return "Sesi harus dipilih";
                                    }
                                    return null;
                                  },
                                ),
                                Select(
                                  label: "Makanan",
                                  icon: const Icon(Icons.fastfood),
                                  hint: "Pilih makanan",
                                  items: [
                                    for (Makanan makanan in state.makananList)
                                      DropdownMenuItem(
                                        value: makanan,
                                        child: Text(makanan.nama),
                                      ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedMakanan = value!;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return "Makanan harus dipilih";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                if (_selectedMakanan != null)
                                  Table(
                                    children: [
                                      TableRow(
                                          children: [const TableCell(child: Text("Makanan")), TableCell(child: Text(": ${_selectedMakanan!.nama}"))]),
                                      TableRow(children: [
                                        const TableCell(child: Text("Kalori")),
                                        TableCell(child: Text(": ${_selectedMakanan!.kalori} kcal"))
                                      ]),
                                      TableRow(
                                          children: [const TableCell(child: Text("Porsi")), TableCell(child: Text(": ${_selectedMakanan!.porsi}"))]),
                                    ],
                                  ),
                                const SizedBox(height: 24),
                                FilledButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<NutrisiHarianCubit>().storeNutrisiHarian(
                                            DataNutrisiHarian(
                                              sesi: _selectedSesi,
                                              makanan: _selectedMakanan!,
                                            ),
                                          );
                                    }
                                  },
                                  child: const Text("Submit"),
                                ),
                              ],
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: RetryButton(
                              message: (state is MakananFailed) ? state.message : "Terjadi kesalahan",
                              onPressed: () => context.read<MakananCubit>().getMakanan(),
                            ),
                          );
                        },
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
