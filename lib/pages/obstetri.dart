import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/obstetri_cubit.dart';
import 'package:mommy_be/cubit/obstetri_state.dart';
import 'package:mommy_be/cubit/status_gizi_cubit.dart';
import 'package:mommy_be/pages/obstetri_create.dart';
import 'package:mommy_be/pages/status_gizi.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';

class ObstetriScreen extends StatefulWidget {
  const ObstetriScreen({super.key});

  @override
  State<ObstetriScreen> createState() => _ObstetriScreenState();
}

class _ObstetriScreenState extends State<ObstetriScreen> {
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
                    const Expanded(child: PageTitle(title: "Obstetri")),
                    FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ObstetriCreateScreen(),
                          ),
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
              BlocBuilder<ObstetriCubit, ObstetriState>(
                builder: (context, state) {
                  if (state is ObstetriLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is ObstetriSuccess) {
                    if (state.obstetri.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 36),
                        child: Text(
                          "Belum ada data obstetri",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return ExpansionPanelList(
                      expansionCallback: (index, isExpanded) {
                        context.read<ObstetriCubit>().toggleExpanded(index);
                      },
                      dividerColor: Colors.grey.shade300,
                      children: state.obstetri.map(
                        (obstetri) {
                          return ExpansionPanel(
                            headerBuilder: (context, isExpanded) {
                              return ListTile(
                                onLongPress: () {
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
                                                context.read<ObstetriCubit>().deleteObstetri(obstetri);
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
                                leading: const Icon(Icons.check_circle),
                                title: Text(
                                  "Data Obstetri ${state.obstetri.indexOf(obstetri) + 1}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            body: Padding(
                              padding: const EdgeInsets.fromLTRB(18, 0, 18, 32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1),
                                      1: FixedColumnWidth(12),
                                      2: FlexColumnWidth(1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          const Text(
                                            "Kehamilan ke-",
                                          ),
                                          const Text(":"),
                                          Text(obstetri.kehamilan.toString()),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          const Text(
                                            "Persalinan ke-",
                                          ),
                                          const Text(":"),
                                          Text(obstetri.persalinan.toString()),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          const Text(
                                            "Riwayat Abortus",
                                          ),
                                          const Text(":"),
                                          Text(obstetri.riwayatAbortus.toString()),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          const Text(
                                            "Metode Persalinan",
                                          ),
                                          const Text(":"),
                                          Text(obstetri.metodePersalinan.toString()),
                                        ],
                                      ),
                                      if (obstetri.persalinan > 1)
                                        TableRow(
                                          children: [
                                            const Text(
                                              "Jarak Kelahiran",
                                            ),
                                            const Text(":"),
                                            Text("${obstetri.jarakKelahiran} tahun"),
                                          ],
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(text: "Saat ini ada berada pada "),
                                        TextSpan(
                                          text: obstetri.resiko,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(text: " dalam aspek obstetri"),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Status Gizi",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      FilledButton(
                                        onPressed: () {
                                          context.read<StatusGiziCubit>().getStatusGizi(obstetri);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => StatusGiziScreen(
                                                obstetri: obstetri,
                                              ),
                                            ),
                                          );
                                        },
                                        style: const ButtonStyle(
                                          visualDensity: VisualDensity.compact,
                                        ),
                                        child: const Text("Check"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            isExpanded: obstetri.expanded,
                          );
                        },
                      ).toList(),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: RetryButton(
                      message: (state is ObstetriFailed) ? state.error : "Terjadi kesalahan",
                      onPressed: () => context.read<ObstetriCubit>().getObstetri(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
