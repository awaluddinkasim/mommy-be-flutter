import 'package:intl/intl.dart';
import 'package:mommy_be/models/nutrisi_harian.dart';
import 'package:mommy_be/shared/dio.dart';

class NurtrisiHarianService {
  Future<List<NutrisiHarian>> getNutrisiHarian(
      String token, DateTime tanggal) async {
    final response = await Request.get(
        '/nutrisi-harian?tanggal=${DateFormat('yyyy-MM-dd').format(tanggal)}',
        headers: {
          'Authorization': 'Bearer $token',
        });

    List<NutrisiHarian> nutrisiHarianList = [];

    for (var item in response['data']['nutrisiHarian']) {
      nutrisiHarianList.add(NutrisiHarian.fromJson(item));
    }

    return nutrisiHarianList;
  }
}
