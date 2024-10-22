import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/cubit/makanan_cubit.dart';
import 'package:mommy_be/cubit/nutrisi_harian_cubit.dart';
import 'package:mommy_be/cubit/nutrisi_harian_state.dart';
import 'package:mommy_be/pages/makanan.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';

class NutrisiHarianScreen extends StatefulWidget {
  const NutrisiHarianScreen({super.key});

  @override
  State<NutrisiHarianScreen> createState() => _NutrisiHarianScreenState();
}

class _NutrisiHarianScreenState extends State<NutrisiHarianScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  DateTime _tanggal = DateTime.now();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    final nutrisiHarian = context.read<NutrisiHarianCubit>();
    Future.delayed(Duration.zero, () {
      nutrisiHarian.getNutrisiHarian(_tanggal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  const Expanded(child: PageTitle(title: "Nutrisi Harian")),
                  FilledButton(
                    onPressed: () {
                      context.read<MakananCubit>().getMakanan();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MakananScreen(),
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
            SvgPicture.asset(
              'assets/svg/nutrisi.svg',
              height: 250,
            ),
            const Text(
              'Total kalori yang dikonsumsi',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            BlocBuilder<NutrisiHarianCubit, NutrisiHarianState>(
              builder: (context, state) {
                if (state is NutrisiHarianLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }

                if (state is NutrisiHarianSuccess) {
                  final totalKalori = context.read<NutrisiHarianCubit>().totalKalori;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "$totalKalori kkal",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (state.kebutuhanKalori != null)
                        if (state.kebutuhanKalori! < totalKalori)
                          const Text(
                            'Kebutuhan kalori telah terpenuhi',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          )
                        else
                          Text(
                            'Kurang ${state.kebutuhanKalori! - totalKalori} kkal',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                    ],
                  );
                }

                return const Text(
                  '0 kkal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                              final cubit = context.read<NutrisiHarianCubit>();

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

                                  cubit.getNutrisiHarian(_tanggal);
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
            const SizedBox(height: 16),
            TabBar(
              controller: tabController,
              isScrollable: true,
              tabs: const [
                Tab(
                  text: 'Sarapan',
                ),
                Tab(
                  text: 'Snack 1',
                ),
                Tab(
                  text: 'Makan Siang',
                ),
                Tab(
                  text: 'Snack 2',
                ),
                Tab(
                  text: 'Makan Malam',
                ),
              ],
              labelColor: Colors.black,
              dividerColor: Colors.black45,
            ),
            Expanded(
              child: BlocBuilder<NutrisiHarianCubit, NutrisiHarianState>(
                builder: (context, state) {
                  if (state is NutrisiHarianLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 36),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is NutrisiHarianSuccess) {
                    return TabBarView(
                      controller: tabController,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (state.nutrisiHarian
                                  .where(
                                    (element) => element.sesi == 'Sarapan',
                                  )
                                  .isNotEmpty)
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 12,
                                    ),
                                    child: Column(
                                      children: [
                                        for (var nutrisiHarian in state.nutrisiHarian.where(
                                          (element) => element.sesi == 'Sarapan',
                                        ))
                                          ListTile(
                                            leading: const Icon(Icons.fastfood),
                                            title: Text(nutrisiHarian.makanan.nama),
                                            subtitle: Text("Porsi ${nutrisiHarian.makanan.porsi} - ${nutrisiHarian.makanan.kalori} kkal"),
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                const Text(
                                  "Tidak ada data",
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (state.nutrisiHarian
                                  .where(
                                    (element) => element.sesi == 'Snack 1',
                                  )
                                  .isNotEmpty)
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 12,
                                    ),
                                    child: Column(
                                      children: [
                                        for (var nutrisiHarian in state.nutrisiHarian.where(
                                          (element) => element.sesi == 'Snack 1',
                                        ))
                                          ListTile(
                                            leading: const Icon(Icons.fastfood),
                                            title: Text(nutrisiHarian.makanan.nama),
                                            subtitle: Text("Porsi ${nutrisiHarian.makanan.porsi} - ${nutrisiHarian.makanan.kalori} kkal"),
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                const Text(
                                  "Tidak ada data",
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (state.nutrisiHarian
                                  .where(
                                    (element) => element.sesi == 'Makan Siang',
                                  )
                                  .isNotEmpty)
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 12,
                                    ),
                                    child: Column(
                                      children: [
                                        for (var nutrisiHarian in state.nutrisiHarian.where(
                                          (element) => element.sesi == 'Makan Siang',
                                        ))
                                          ListTile(
                                            leading: const Icon(Icons.fastfood),
                                            title: Text(nutrisiHarian.makanan.nama),
                                            subtitle: Text("Porsi ${nutrisiHarian.makanan.porsi} - ${nutrisiHarian.makanan.kalori} kkal"),
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                const Text(
                                  "Tidak ada data",
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (state.nutrisiHarian
                                  .where(
                                    (element) => element.sesi == 'Snack 2',
                                  )
                                  .isNotEmpty)
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 12,
                                    ),
                                    child: Column(
                                      children: [
                                        for (var nutrisiHarian in state.nutrisiHarian.where(
                                          (element) => element.sesi == 'Snack 2',
                                        ))
                                          ListTile(
                                            leading: const Icon(Icons.fastfood),
                                            title: Text(nutrisiHarian.makanan.nama),
                                            subtitle: Text("Porsi ${nutrisiHarian.makanan.porsi} - ${nutrisiHarian.makanan.kalori} kkal"),
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                const Text(
                                  "Tidak ada data",
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (state.nutrisiHarian
                                  .where(
                                    (element) => element.sesi == 'Makan Malam',
                                  )
                                  .isNotEmpty)
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 12,
                                    ),
                                    child: Column(
                                      children: [
                                        for (var nutrisiHarian in state.nutrisiHarian.where(
                                          (element) => element.sesi == 'Makan Malam',
                                        ))
                                          ListTile(
                                            leading: const Icon(Icons.fastfood),
                                            title: Text(nutrisiHarian.makanan.nama),
                                            subtitle: Text("Porsi ${nutrisiHarian.makanan.porsi} - ${nutrisiHarian.makanan.kalori} kkal"),
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                const Text(
                                  "Tidak ada data",
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: RetryButton(
                      message: (state is NutrisiHarianFailed) ? state.message : "Terjadi kesalahan",
                      onPressed: () => context.read<NutrisiHarianCubit>().getNutrisiHarian(_tanggal),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
