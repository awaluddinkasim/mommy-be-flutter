import 'package:flutter/material.dart';

class DataMonitorEkskresi {
  final DateTime tanggal;
  final String ekskresi;
  final TimeOfDay pukul;

  DataMonitorEkskresi({
    required this.tanggal,
    required this.ekskresi,
    required this.pukul,
  });

  Map<String, dynamic> toJson() => {
        'tanggal': tanggal.toString(),
        'ekskresi': ekskresi,
        'pukul': DateTime(tanggal.year, tanggal.month, tanggal.day, pukul.hour, pukul.minute).toString(),
      };
}
