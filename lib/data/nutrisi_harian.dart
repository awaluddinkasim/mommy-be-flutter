import 'package:mommy_be/models/makanan.dart';

class DataNutrisiHarian {
  final String sesi;
  final Makanan makanan;

  DataNutrisiHarian({required this.sesi, required this.makanan});

  Map<String, dynamic> toJson() => {
        'sesi': sesi,
        'makanan_id': makanan.id,
      };
}
