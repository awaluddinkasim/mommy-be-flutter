import 'package:mommy_be/data/bayi.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/shared/dio.dart';

class BayiService {
  Future<List<Bayi>> getBayi(String token) async {
    final response = await Request.get('/baby', headers: {
      'Authorization': 'Bearer $token',
    });

    List<Bayi> bayiList = [];
    for (var item in response['data']['babies']) {
      bayiList.add(Bayi.fromJson(item));
    }

    return bayiList;
  }

  Future<List<Bayi>> postBayi(String token, DataBayi data) async {
    final response = await Request.post(
      '/baby',
      headers: {
        'Authorization': 'Bearer $token',
      },
      data: data.toJson(),
    );

    List<Bayi> bayiList = [];

    for (var item in response['data']['babies']) {
      bayiList.add(Bayi.fromJson(item));
    }

    return bayiList;
  }

  Future<List<Bayi>> deleteBayi(String token, int id) async {
    final response = await Request.delete(
      '/baby/$id',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    List<Bayi> bayiList = [];

    for (var item in response['data']['babies']) {
      bayiList.add(Bayi.fromJson(item));
    }

    return bayiList;
  }
}
