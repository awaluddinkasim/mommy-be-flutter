import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/cubit/monitor_ekskresi_cubit.dart';
import 'package:mommy_be/cubit/monitor_ekskresi_state.dart';
import 'package:mommy_be/data/monitor_ekskresi.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/models/monitor_ekskresi.dart';
import 'package:mommy_be/shared/widgets/input.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';
import 'package:mommy_be/shared/widgets/select.dart';

class BabyMonitorEkskresiScreen extends StatefulWidget {
  final Bayi bayi;
  const BabyMonitorEkskresiScreen({super.key, required this.bayi});

  @override
  State<BabyMonitorEkskresiScreen> createState() =>
      _BabyMonitorEkskresiScreenState();
}

class _BabyMonitorEkskresiScreenState extends State<BabyMonitorEkskresiScreen> {
  final DateTime _tanggalHariIni =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  late DateTime _tanggal = _tanggalHariIni;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<MonitorEkskresiCubit>();
    Future.delayed(Duration.zero, () {
      cubit.getMonitorEkskresi(widget.bayi, _tanggal);
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
                            final cubit = context.read<MonitorEkskresiCubit>();

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

                                cubit.getMonitorEkskresi(widget.bayi, _tanggal);
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
                            builder: (context) =>
                                _FormDialog(widget.bayi, _tanggal));
                      },
                      child: const Text("Tambah Data"),
                    ),
                  ),
                const SizedBox(height: 16),
                BlocBuilder<MonitorEkskresiCubit, MonitorEkskresiState>(
                  builder: (context, state) {
                    if (state is MonitorEkskresiLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (state is MonitorEkskresiSuccess) {
                      if (state.monitorEkskresi.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text("Belum ada data"),
                          ),
                        );
                      }

                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
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
                                const Text(
                                  "Data Ekskresi",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(1.5),
                                    1: FixedColumnWidth(12),
                                    2: FlexColumnWidth(2),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        const TableCell(
                                            child: Text("Buang Air Kecil")),
                                        const TableCell(child: Text(":")),
                                        TableCell(
                                          child: Text(
                                            state.monitorEkskresi
                                                .where((e) =>
                                                    e.ekskresi ==
                                                    "Buang Air Kecil")
                                                .length
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        const TableCell(
                                            child: Text("Buang Air Besar")),
                                        const TableCell(child: Text(":")),
                                        TableCell(
                                          child: Text(
                                            state.monitorEkskresi
                                                .where((e) =>
                                                    e.ekskresi ==
                                                    "Buang Air Besar")
                                                .length
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          for (MonitorEkskresi data in state.monitorEkskresi)
                            _DataItem(data: data, widget: widget),
                        ],
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: RetryButton(
                        message: (state is MonitorEkskresiFailed)
                            ? state.message
                            : "Terjadi kesalahan",
                        onPressed: () => context
                            .read<MonitorEkskresiCubit>()
                            .getMonitorEkskresi(widget.bayi, _tanggal),
                      ),
                    );
                  },
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
  final MonitorEkskresi data;

  const _DataItem({
    required this.data,
    required this.widget,
  });

  final BabyMonitorEkskresiScreen widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        leading: const Icon(CupertinoIcons.drop),
        title: Text(data.ekskresi),
        subtitle: Text(data.pukul.format(context)),
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
                          context
                              .read<MonitorEkskresiCubit>()
                              .deleteMonitorEkskresi(
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

  String? _ekskresi;

  final _waktu = TextEditingController();

  TimeOfDay? _pukul;

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
              Select(
                label: "Ekskresi",
                hint: "Pilih Jenis Ekskresi",
                icon: const Icon(CupertinoIcons.drop),
                items: const [
                  DropdownMenuItem(
                    value: "Buang Air Kecil",
                    child: Text("BAK"),
                  ),
                  DropdownMenuItem(
                    value: "Buang Air Besar",
                    child: Text("BAB"),
                  ),
                  DropdownMenuItem(
                    value: "Keduanya",
                    child: Text("Keduanya"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _ekskresi = value;
                  });
                },
                validator: (value) {
                  if (_ekskresi == null || _ekskresi!.isEmpty) {
                    return "Ekskresi harus diisi";
                  }
                  return null;
                },
              ),
              Input(
                controller: _waktu,
                label: "Pukul",
                icon: const Icon(CupertinoIcons.clock),
                hintText: "Pilih Waktu",
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (time != null) {
                    setState(() {
                      _pukul = time;
                      _waktu.text = time.format(context);
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Waktu harus diisi";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<MonitorEkskresiCubit>().storeMonitorEkskresi(
                          widget.bayi,
                          DataMonitorEkskresi(
                            tanggal: widget.tanggal,
                            ekskresi: _ekskresi!,
                            pukul: _pukul!,
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
