import 'package:intl/intl.dart';
import 'package:mommy_be/data/laktasi.dart';
import 'package:mommy_be/models/laktasi.dart';
import 'package:mommy_be/shared/dio.dart';

class LaktasiService {
  Future<List<Laktasi>> getLaktasi(
      String token, int id, DateTime tanggal) async {
    final response = await Request.get(
        '/laktasi/$id?tanggal=${DateFormat('yyyy-MM-dd').format(tanggal)}',
        headers: {
          'Authorization': 'Bearer $token',
        });

    print(response);

    List<Laktasi> laktasiList = [];
    for (var item in response['data']['riwayatLaktasi']) {
      laktasiList.add(Laktasi.fromJson(item));
    }

    return laktasiList;
  }

  Future<void> postLaktasi(String token, DataLaktasi data) async {
    await Request.post(
      '/laktasi',
      headers: {
        'Authorization': 'Bearer $token',
      },
      data: data.toJson(),
    );
  }
}
