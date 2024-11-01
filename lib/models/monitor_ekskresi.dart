import 'package:flutter/material.dart';

class MonitorEkskresi {
  final int id;
  final DateTime tanggal;
  final String ekskresi;
  final TimeOfDay pukul;

  MonitorEkskresi({
    required this.id,
    required this.tanggal,
    required this.ekskresi,
    required this.pukul,
  });

  factory MonitorEkskresi.fromJson(Map<String, dynamic> json) {
    return MonitorEkskresi(
      id: json['id'],
      tanggal: DateTime.parse(json['tanggal']),
      ekskresi: json['ekskresi'],
      pukul: TimeOfDay.fromDateTime(DateTime.parse(json['pukul'])),
    );
  }
}
