import 'package:flutter/material.dart';

class MonitorTidur {
  final int id;
  final DateTime tanggal;
  final TimeOfDay tidur;
  final TimeOfDay bangun;
  final String durasiTidur;

  MonitorTidur({
    required this.id,
    required this.tanggal,
    required this.tidur,
    required this.bangun,
    required this.durasiTidur,
  });

  factory MonitorTidur.fromJson(Map<String, dynamic> json) {
    return MonitorTidur(
      id: json['id'],
      tanggal: DateTime.parse(json['tanggal']),
      tidur: TimeOfDay.fromDateTime(DateTime.parse(json['tidur'])),
      bangun: TimeOfDay.fromDateTime(DateTime.parse(json['bangun'])),
      durasiTidur: json['durasi_tidur'],
    );
  }
}
