import 'package:flutter/material.dart';

class DataMonitorTidur {
  final DateTime tanggal;
  final TimeOfDay tidur;
  final TimeOfDay bangun;

  DataMonitorTidur({
    required this.tanggal,
    required this.tidur,
    required this.bangun,
  });

  Map<String, dynamic> toJson() {
    DateTime tidurDateTime = DateTime(
      tanggal.year,
      tanggal.month,
      tidur.hour < bangun.hour ? tanggal.day : tanggal.day - 1,
      tidur.hour,
      tidur.minute,
    );

    DateTime bangunDateTime = DateTime(
      tanggal.year,
      tanggal.month,
      tanggal.day,
      bangun.hour,
      bangun.minute,
    );

    return {
      'tanggal': tanggal.toString(),
      'tidur': tidurDateTime.toString(),
      'bangun': bangunDateTime.toString(),
    };
  }
}
