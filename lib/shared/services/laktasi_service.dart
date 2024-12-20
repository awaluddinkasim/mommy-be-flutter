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

    List<LaktasiGrafik> kiriHarian = [];
    List<LaktasiGrafik> kananHarian = [];

    for (int i = 0; i < response['data']['kiri'].length; i++) {
      DateTime tanggalInit = DateTime.parse(response['data']['kiri'][i]['tanggal']).subtract(const Duration(days: 1));

      if (response['data']['kiri'].length == 1) {
        kiriHarian.add(LaktasiGrafik.fromJson({'durasi': 0.0, 'tanggal': tanggalInit.toString()}, 0));
      }
      kiriHarian.add(LaktasiGrafik.fromJson(response['data']['kiri'][i], i + 1));
    }
    for (int i = 0; i < response['data']['kanan'].length; i++) {
      DateTime tanggalInit = DateTime.parse(response['data']['kanan'][i]['tanggal']).subtract(const Duration(days: 1));

      if (response['data']['kanan'].length == 1) {
        kananHarian.add(LaktasiGrafik.fromJson({'durasi': 0.0, 'tanggal': tanggalInit.toString()}, 0));
      }
      kananHarian.add(LaktasiGrafik.fromJson(response['data']['kanan'][i], i + 1));
    }

    List<LaktasiGrafik> kiriMingguan = [];
    List<LaktasiGrafik> kananMingguan = [];

    for (int i = 0; i < response['data']['kiriMingguan'].length; i++) {
      kiriMingguan.add(LaktasiGrafik.fromJson(response['data']['kiriMingguan'][i], i + 1));
    }
    for (int i = 0; i < response['data']['kananMingguan'].length; i++) {
      kananMingguan.add(LaktasiGrafik.fromJson(response['data']['kananMingguan'][i], i + 1));
    }

    return {
      'kiri_harian': kiriHarian,
      'kanan_harian': kananHarian,
      'kiri_mingguan': kiriMingguan,
      'kanan_mingguan': kananMingguan,
    };
  }
}
