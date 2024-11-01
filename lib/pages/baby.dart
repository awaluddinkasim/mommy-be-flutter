import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/cubit/bayi_cubit.dart';
import 'package:mommy_be/cubit/bayi_state.dart';
import 'package:mommy_be/data/bayi.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/pages/baby_detail.dart';
import 'package:mommy_be/shared/widgets/input.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';
import 'package:mommy_be/shared/widgets/select.dart';

class BabyScreen extends StatefulWidget {
  const BabyScreen({super.key});

  @override
  State<BabyScreen> createState() => _BabyScreenState();
}

class _BabyScreenState extends State<BabyScreen> {
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
                child: Row(
                  children: [
                    const Expanded(child: PageTitle(title: "Data Bayi")),
                    FilledButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: const SingleChildScrollView(
                                padding: EdgeInsets.symmetric(
                                  vertical: 32,
                                  horizontal: 28,
                                ),
                                child: FormBaby(),
                              ),
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<BayiCubit, BayiState>(
                builder: (context, state) {
                  if (state is BayiSuccess) {
                    if (state.bayiList.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 36),
                        child: Text(
                          "Belum ada data",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (Bayi bayi in state.bayiList)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BabyDetailScreen(baby: bayi),
                                    ),
                                  );
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                leading: Image.asset(
                                  "assets/icon/baby.png",
                                  width: 50,
                                ),
                                title: Text(
                                  bayi.nama,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(bayi.jenisKelamin),
                                    Text(DateFormat(
                                      "dd MMMM yyyy",
                                      "ID",
                                    ).format(bayi.tanggalLahir)),
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
                                                  context.read<BayiCubit>().deleteBayi(
                                                        bayi.id,
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
                            ),
                        ],
                      ),
                    );
                  }

                  if (state is BayiLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: RetryButton(
                      message: (state is BayiFailed) ? state.message : "Terjadi kesalahan",
                      onPressed: () => context.read<BayiCubit>().getBayi(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormBaby extends StatefulWidget {
  const FormBaby({
    super.key,
  });

  @override
  State<FormBaby> createState() => _FormBabyState();
}

class _FormBabyState extends State<FormBaby> {
  final _formKey = GlobalKey<FormState>();

  final _nama = TextEditingController();
  final _tanggalLahir = TextEditingController();

  late String _jenisKelamin;
  late DateTime _dob;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Input(
            controller: _nama,
            label: "Nama",
            icon: const Icon(Icons.person),
            hintText: "Masukkan nama",
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Nama tidak boleh kosong";
              }
              return null;
            },
          ),
          Input(
            controller: _tanggalLahir,
            label: "Tanggal Lahir",
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
                  _dob = date;
                  _tanggalLahir.text = DateFormat(
                    'dd MMMM yyyy',
                    'ID',
                  ).format(date);
                });
              }
            },
            icon: const Icon(Icons.calendar_today),
            hintText: "Pilih tanggal lahir",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Tanggal lahir tidak boleh kosong";
              }
              return null;
            },
          ),
          Select(
            label: "Jenis Kelamin",
            icon: const Icon(Icons.transgender),
            items: const [
              DropdownMenuItem(value: "Laki-laki", child: Text("Laki-laki")),
              DropdownMenuItem(value: "Perempuan", child: Text("Perempuan")),
            ],
            onChanged: (value) {
              setState(() {
                _jenisKelamin = value!;
              });
            },
            hint: "Pilih jenis kelamin",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Jenis kelamin tidak boleh kosong";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<BayiCubit>().storeBayi(
                      DataBayi(
                        nama: _nama.text,
                        tanggalLahir: _dob,
                        jenisKelamin: _jenisKelamin,
                      ),
                    );
                Navigator.pop(context);
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}
