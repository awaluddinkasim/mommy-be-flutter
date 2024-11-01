import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/cubit/monitor_tidur_cubit.dart';
import 'package:mommy_be/cubit/monitor_tidur_state.dart';
import 'package:mommy_be/data/monitor_tidur.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/models/monitor_tidur.dart';
import 'package:mommy_be/shared/widgets/input.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';

class BabyMonitorTidurScreen extends StatefulWidget {
  final Bayi bayi;
  const BabyMonitorTidurScreen({super.key, required this.bayi});

  @override
  State<BabyMonitorTidurScreen> createState() => _BabyMonitorTidurScreenState();
}

class _BabyMonitorTidurScreenState extends State<BabyMonitorTidurScreen> {
  final DateTime _tanggalHariIni = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  late DateTime _tanggal = _tanggalHariIni;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final cubit = context.read<MonitorTidurCubit>();

      cubit.getMonitorTidur(widget.bayi, _tanggal);
    });
  }

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
                            final cubit = context.read<MonitorTidurCubit>();

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

                                cubit.getMonitorTidur(widget.bayi, _tanggal);
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
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_tanggal == _tanggalHariIni)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: FilledButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return _FormDialog(widget.bayi, _tanggal);
                          },
                        );
                      },
                      child: const Text("Tambah Data"),
                    ),
                  ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: BlocBuilder<MonitorTidurCubit, MonitorTidurState>(
                    builder: (context, state) {
                      if (state is MonitorTidurLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (state is MonitorTidurSuccess) {
                        if (state.monitorTidur.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Text("Belum ada data"),
                            ),
                          );
                        }

                        return Column(
                          children: [
                            for (MonitorTidur data in state.monitorTidur) _DataItem(data: data, widget: widget),
                          ],
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: RetryButton(
                          message: (state is MonitorTidurFailed) ? state.message : "Terjadi kesalahan",
                          onPressed: () => context.read<MonitorTidurCubit>().getMonitorTidur(widget.bayi, _tanggal),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DataItem extends StatelessWidget {
  final MonitorTidur data;

  const _DataItem({
    required this.data,
    required this.widget,
  });

  final BabyMonitorTidurScreen widget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(CupertinoIcons.zzz),
      title: Text("${data.tidur.format(context)} - ${data.bangun.format(context)}"),
      subtitle: Text(data.durasiTidur),
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
                        context.read<MonitorTidurCubit>().deleteMonitorTidur(
                              widget.bayi,
                              data.id,
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
    );
  }
}

class _FormDialog extends StatefulWidget {
  final Bayi bayi;
  final DateTime tanggal;
  const _FormDialog(this.bayi, this.tanggal);

  @override
  State<_FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<_FormDialog> {
  final _formKey = GlobalKey<FormState>();

  final _tidur = TextEditingController();
  final _bangun = TextEditingController();

  TimeOfDay? _jamTidur;
  TimeOfDay? _jamBangun;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 18,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Input(
                controller: _tidur,
                label: "Jam Tidur",
                icon: const Icon(CupertinoIcons.clock),
                hintText: "Pilih Jam Tidur",
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      _jamTidur = time;
                      _tidur.text = time.format(context);
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Jam Tidur harus diisi";
                  }
                  return null;
                },
              ),
              Input(
                controller: _bangun,
                label: "Jam Bangun",
                icon: const Icon(CupertinoIcons.clock),
                hintText: "Pilih Jam Bangun",
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (time != null) {
                    setState(() {
                      _jamBangun = time;
                      _bangun.text = time.format(context);
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Jam Bangun harus diisi";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<MonitorTidurCubit>().storeMonitorTidur(
                          widget.bayi,
                          DataMonitorTidur(
                            tanggal: widget.tanggal,
                            tidur: _jamTidur!,
                            bangun: _jamBangun!,
                          ),
                        );
                    Navigator.pop(context);
                  }
                },
                child: const Text("Tambah"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
