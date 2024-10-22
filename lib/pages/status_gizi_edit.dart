import 'package:flutter/material.dart';
import 'package:mommy_be/models/status_gizi.dart';

class StatusGiziEditScreen extends StatefulWidget {
  final StatusGizi statusGizi;

  const StatusGiziEditScreen({super.key, required this.statusGizi});

  @override
  State<StatusGiziEditScreen> createState() => _StatusGiziEditScreenState();
}

class _StatusGiziEditScreenState extends State<StatusGiziEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(),
      ),
    );
  }
}
