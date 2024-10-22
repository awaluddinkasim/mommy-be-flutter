import 'package:intl/intl.dart';
import 'package:mommy_be/data/nutrisi_harian.dart';
import 'package:mommy_be/models/nutrisi_harian.dart';
import 'package:mommy_be/shared/dio.dart';

class NurtrisiHarianService {
  Future<Map<String, dynamic>> getNutrisiHarian(
    String token,
    DateTime tanggal,
  ) async {
    final response = await Request.get('/nutrisi-harian?tanggal=${DateFormat('yyyy-MM-dd').format(tanggal)}', headers: {
      'Authorization': 'Bearer $token',
    });

    List<NutrisiHarian> nutrisiHarianList = [];

    for (var item in response['data']['nutrisiHarian']) {
      nutrisiHarianList.add(NutrisiHarian.fromJson(item));
    }

    return {
      'nutrisiHarian': nutrisiHarianList,
      'kebutuhanKalori': response['data']['kebutuhanKalori'],
    };
  }

  Future<Map<String, dynamic>> postNutrisiHarian(String token, DataNutrisiHarian data) async {
    final response = await Request.post('/nutrisi-harian', data: data.toJson(), headers: {
      'Authorization': 'Bearer $token',
    });

    List<NutrisiHarian> nutrisiHarianList = [];

    for (var item in response['data']['nutrisiHarian']) {
      nutrisiHarianList.add(NutrisiHarian.fromJson(item));
    }

    return {
      'nutrisiHarian': nutrisiHarianList,
      'kebutuhanKalori': response['data']['kebutuhanKalori'],
    };
  }
}
