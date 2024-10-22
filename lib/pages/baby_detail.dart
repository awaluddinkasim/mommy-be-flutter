import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mommy_be/models/bayi.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.baby.nama),
      ),
      body: SingleChildScrollView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.zzz),
            label: "Monitor Tidur",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: "Pertumbuhan",
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
