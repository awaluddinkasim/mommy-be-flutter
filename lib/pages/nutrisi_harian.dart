import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mommy_be/pages/makanan.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';

class NutrisiHarianScreen extends StatefulWidget {
  const NutrisiHarianScreen({super.key});

  @override
  State<NutrisiHarianScreen> createState() => _NutrisiHarianScreenState();
}

class _NutrisiHarianScreenState extends State<NutrisiHarianScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  DateTime _tanggal = DateTime.now();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Expanded(child: PageTitle(title: "Nutrisi Harian")),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MakananScreen(),
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
              child: TabBarView(
                controller: tabController,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.fastfood),
                                  title: Text("Nasi Kuning"),
                                  subtitle: Text("1 porsi - 400 kcal"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.fastfood),
                                  title: Text("Milo"),
                                  subtitle: Text("1.75 porsi - 200 kcal"),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.fastfood),
                                  title: Text("Jagung Bakar"),
                                  subtitle: Text("1.25 porsi - 125 kcal"),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
