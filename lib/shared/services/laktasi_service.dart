import 'package:intl/intl.dart';
import 'package:mommy_be/data/laktasi.dart';
import 'package:mommy_be/models/laktasi.dart';
import 'package:mommy_be/models/laktasi_grafik.dart';
import 'package:mommy_be/shared/dio.dart';

class LaktasiService {
  Future<List<Laktasi>> getLaktasi(String token, int id, DateTime tanggal) async {
    final response = await Request.get('/laktasi/$id?tanggal=${DateFormat('yyyy-MM-dd').format(tanggal)}', headers: {
      'Authorization': 'Bearer $token',
    });

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

  Future<Map<String, List<LaktasiGrafik>>> getLaktasiCharts(String token, int id, DateTime tanggal) async {
    final response = await Request.get('/laktasi/$id/charts?tanggal=${DateFormat('yyyy-MM-dd').format(tanggal)}', headers: {
      'Authorization': 'Bearer $token',
    });

    List<LaktasiGrafik> kiri = [];
    List<LaktasiGrafik> kanan = [];

    for (int i = 0; i < response['data']['kiri'].length; i++) {
      if (response['data']['kiri'].length == 1) {
        kiri.add(LaktasiGrafik.fromJson({'durasi': 0.0}, 0));
      }
      kiri.add(LaktasiGrafik.fromJson(response['data']['kiri'][i], i + 1));
    }
    for (int i = 0; i < response['data']['kanan'].length; i++) {
      if (response['data']['kanan'].length == 1) {
        kanan.add(LaktasiGrafik.fromJson({'durasi': 0.0}, 0));
      }
      kanan.add(LaktasiGrafik.fromJson(response['data']['kanan'][i], i + 1));
    }

    return {
      'kiri': kiri,
      'kanan': kanan,
    };
  }
}
