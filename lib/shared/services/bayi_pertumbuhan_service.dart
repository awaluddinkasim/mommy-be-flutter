import 'package:mommy_be/data/pertumbuhan.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/models/pertumbuhan.dart';
import 'package:mommy_be/shared/dio.dart';

class BayiPertumbuhanService {
  Future<List<Pertumbuhan>> getPertumbuhan(String token, Bayi bayi) async {
    final response = await Request.get(
      '/baby/${bayi.id}/pertumbuhan',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    List<Pertumbuhan> pertumbuhan = [];

    for (var item in response['data']['pertumbuhan']) {
      pertumbuhan.add(Pertumbuhan.fromJson(item));
    }

    return pertumbuhan;
  }

  Future<List<Pertumbuhan>> postPertumbuhan(String token, Bayi bayi, DataPertumbuhan data) async {
    final response = await Request.post(
      '/baby/${bayi.id}/pertumbuhan',
      headers: {
        'Authorization': 'Bearer $token',
      },
      data: data.toJson(),
    );

    List<Pertumbuhan> pertumbuhan = [];

    for (var item in response['data']['pertumbuhan']) {
      pertumbuhan.add(Pertumbuhan.fromJson(item));
    }

    return pertumbuhan;
  }

  Future<List<Pertumbuhan>> deletePertumbuhan(String token, Bayi bayi, int id) async {
    final response = await Request.delete(
      '/baby/${bayi.id}/pertumbuhan/$id',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    List<Pertumbuhan> pertumbuhan = [];

    for (var item in response['data']['pertumbuhan']) {
      pertumbuhan.add(Pertumbuhan.fromJson(item));
    }

    return pertumbuhan;
  }
}
