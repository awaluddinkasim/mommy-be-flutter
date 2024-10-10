import 'package:mommy_be/models/makanan.dart';

class NutrisiHarian {
  final Makanan makanan;
  final String sesi;
  final DateTime tanggal;

  NutrisiHarian(
      {required this.makanan, required this.sesi, required this.tanggal});

  factory NutrisiHarian.fromJson(Map<String, dynamic> json) {
    return NutrisiHarian(
      makanan: Makanan.fromJson(json['makanan']),
      sesi: json['sesi'],
      tanggal: DateTime.parse(json['tanggal']),
    );
  }
}
