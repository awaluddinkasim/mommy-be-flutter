import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/pages/baby/ekskresi.dart';
import 'package:mommy_be/pages/baby/pertumbuhan.dart';
import 'package:mommy_be/pages/baby/tidur.dart';

class BabyDetailScreen extends StatefulWidget {
  final Bayi baby;

  const BabyDetailScreen({super.key, required this.baby});

  @override
  State<BabyDetailScreen> createState() => _BabyDetailScreenState();
}

class _BabyDetailScreenState extends State<BabyDetailScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List pages = [
      BabyMonitorTidurScreen(bayi: widget.baby),
      BabyMonitorEkskresiScreen(bayi: widget.baby),
      BabyPertumbuhanScreen(bayi: widget.baby),
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(widget.baby.nama),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.zzz),
            label: "Monitor Tidur",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.drop),
            label: "Monitor Ekskresi",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: "Pertumbuhan",
          ),
        ],
      ),
    );
  }
}
