import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BabyMonitorEkskresiScreen extends StatefulWidget {
  const BabyMonitorEkskresiScreen({super.key});

  @override
  State<BabyMonitorEkskresiScreen> createState() => _BabyMonitorEkskresiScreenState();
}

class _BabyMonitorEkskresiScreenState extends State<BabyMonitorEkskresiScreen> {
  DateTime _tanggal = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Row(
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
                          DateFormat('dd MMMM yyyy', 'ID').format(_tanggal),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // final cubit = context.read<NutrisiHarianCubit>();

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

                                // cubit.getNutrisiHarian(_tanggal);
                              }
                            });
                          },
                          icon: const Icon(Icons.date_range),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
