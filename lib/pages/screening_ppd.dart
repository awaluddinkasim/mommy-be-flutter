import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mommy_be/cubit/screening_ppd_cubit.dart';
import 'package:mommy_be/cubit/screening_ppd_state.dart';
import 'package:mommy_be/data/screening_ppd.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';
import 'package:mommy_be/shared/widgets/select.dart';

class ScreeningPPDScreen extends StatefulWidget {
  const ScreeningPPDScreen({super.key});

  @override
  State<ScreeningPPDScreen> createState() => _ScreeningPPDScreenState();
}

class _ScreeningPPDScreenState extends State<ScreeningPPDScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PageTitle(title: "Screening PPD"),
              const SizedBox(height: 16),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: BlocBuilder<ScreeningPPDCubit, ScreeningPPDState>(
                    builder: (context, state) {
                      if (state is ScreeningPPDLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (state is ScreeningPPDSuccess) {
                        if (state.screeningPPD == null) {
                          return const _FormScreening();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/ppd.svg',
                              height: 300,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Hasil Screening PPD",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              state.screeningPPD!.tingkatRisiko,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Total Skor: ${state.screeningPPD!.totalScore}"),
                            const SizedBox(height: 16),
                            Text(state.screeningPPD!.pesan),
                            const SizedBox(height: 16),
                            FilledButton.icon(
                              onPressed: () {
                                context.read<ScreeningPPDCubit>().resetScreeningPPD();
                              },
                              label: const Text("Tes Ulang"),
                              icon: const Icon(Icons.refresh),
                            ),
                          ],
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: RetryButton(
                          message: (state is ScreeningPPDFailed) ? state.message : "Terjadi kesalahan",
                          onPressed: () => context.read<ScreeningPPDCubit>().getScreeningPPD(),
                        ),
                      );
                    },
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

class _FormScreening extends StatefulWidget {
  const _FormScreening();

  @override
  State<_FormScreening> createState() => __FormScreeningState();
}

class __FormScreeningState extends State<_FormScreening> {
  final _formKey = GlobalKey<FormState>();

  final _answers = <int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  final List<Map> _questions = [
    {
      "pertanyaan": "Saya bisa menertawakan banyak hal atau melihat sisi kelucuan dari sebuah situasi",
      "opsi": [
        {"text": "Selalu", "value": 0},
        {"text": "Kadang-kadang", "value": 1},
        {"text": "Jarang", "value": 2},
        {"text": "Tidak pernah", "value": 3},
      ],
    },
    {
      "pertanyaan": "Saya bisa melihat hal-hal ke depan dengan senang hati",
      "opsi": [
        {"text": "Sama seperti sebelumnya", "value": 0},
        {"text": "Agak berkurang dari biasanya", "value": 1},
        {"text": "Kurang dari biasanya", "value": 2},
        {"text": "Tidak bisa sama sekali", "value": 3},
      ],
    },
    {
      "pertanyaan": "Saya menyalahkan diri sendiri saat terjadi sesuatu yang salah",
      "opsi": [
        {"text": "Tidak pernah sama sekali", "value": 0},
        {"text": "Tidak terlalu sering", "value": 1},
        {"text": "Ya, kadang-kadang", "value": 2},
        {"text": "Ya, setiap saat", "value": 3},
      ],
    },
    {
      "pertanyaan": "Saya merasa cemas atau khawatir tanpa alasan yang jelas",
      "opsi": [
        {"text": "Tidak pernah sama sekali", "value": 0},
        {"text": "Jarang", "value": 1},
        {"text": "Ya, kadang-kadang", "value": 2},
        {"text": "Ya, sering", "value": 3},
      ],
    },
    {
      "pertanyaan": "Saya merasa takut atau panik tanpa alasan yang jelas",
      "opsi": [
        {"text": "Tidak pernah sama sekali", "value": 0},
        {"text": "Jarang", "value": 1},
        {"text": "Ya, kadang-kadang", "value": 2},
        {"text": "Ya, sering", "value": 3},
      ],
    },
    {
      "pertanyaan": "Saya merasa kesulitan untuk mengatasi berbagai hal",
      "opsi": [
        {"text": "Saya mampu mengatasi semuanya dengan baik", "value": 0},
        {"text": "Sebagian besar bisa saya atasi", "value": 1},
        {"text": "Ya, kadang-kadang", "value": 2},
        {"text": "Ya, setiap saat", "value": 3},
      ],
    },
    {
      "pertanyaan": "Saya merasa tidak bahagia hingga kesulitan untuk tidur",
      "opsi": [
        {"text": "Tidak pernah sama sekali", "value": 0},
        {"text": "Jarang", "value": 1},
        {"text": "Ya, kadang-kadang", "value": 2},
        {"text": "Ya, setiap saat", "value": 3},
      ],
    },
    {
      "pertanyaan": "Saya sedih dan merasa diri saya ini menyedihkan",
      "opsi": [
        {"text": "Tidak pernah sama sekali", "value": 0},
        {"text": "Jarang", "value": 1},
        {"text": "Ya, kadang-kadang", "value": 2},
        {"text": "Ya, setiap saat", "value": 3},
      ],
    },
    {
      "pertanyaan": "Saya menangis karena merasa tidak bahagia",
      "opsi": [
        {"text": "Tidak pernah sama sekali", "value": 0},
        {"text": "Jarang", "value": 1},
        {"text": "Ya, kadang-kadang", "value": 2},
        {"text": "Ya, setiap saat", "value": 3},
      ],
    },
    {
      "pertanyaan": "Terlintas pikiran untuk menyakiti diri sendiri",
      "opsi": [
        {"text": "Tidak pernah sama sekali", "value": 0},
        {"text": "Jarang", "value": 1},
        {"text": "Ya, kadang-kadang", "value": 2},
        {"text": "Ya, setiap saat", "value": 3},
      ],
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < _questions.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(_questions[i]['pertanyaan']),
                const SizedBox(height: 8),
                Select(
                  icon: const Icon(Icons.menu),
                  items: _questions[i]['opsi']
                      .map<DropdownMenuItem>((e) => DropdownMenuItem(
                            value: e['value'],
                            child: Text(
                              e['text'],
                              softWrap: true,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _answers[i] = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Pilih jawaban";
                    }
                    return null;
                  },
                ),
              ],
            ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<ScreeningPPDCubit>().storeScreeningPPD(
                      DataScreeningPPD(
                        q1: _answers[0],
                        q2: _answers[1],
                        q3: _answers[2],
                        q4: _answers[3],
                        q5: _answers[4],
                        q6: _answers[5],
                        q7: _answers[6],
                        q8: _answers[7],
                        q9: _answers[8],
                        q10: _answers[9],
                      ),
                    );
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}
