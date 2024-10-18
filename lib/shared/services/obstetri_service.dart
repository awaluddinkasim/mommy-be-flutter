import 'package:mommy_be/data/obstetri.dart';
import 'package:mommy_be/models/obstetri.dart';
import 'package:mommy_be/shared/dio.dart';

class ObstetriService {
  Future<List<Obstetri>> getObstetri(String token) async {
    final response = await Request.get(
      '/obstetri',
      headers: {'Authorization': 'Bearer $token'},
    );

    List<Obstetri> obstetriList = [];

    for (var obstetri in response['data']['daftarObstetri']) {
      obstetriList.add(Obstetri.fromJson(obstetri));
    }

    return obstetriList;
  }

  Future<List<Obstetri>> postObstetri(String token, DataObstetri data) async {
    final response = await Request.post(
      '/obstetri',
      data: data.toJson(),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    List<Obstetri> obstetriList = [];

    for (var obstetri in response['data']['daftarObstetri']) {
      obstetriList.add(Obstetri.fromJson(obstetri));
    }

    return obstetriList;
  }

  Future<List<Obstetri>> deleteObstetri(String token, Obstetri data) async {
    final response = await Request.delete(
      '/obstetri/${data.id}',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    List<Obstetri> obstetriList = [];

    for (var obstetri in response['data']['daftarObstetri']) {
      obstetriList.add(Obstetri.fromJson(obstetri));
    }

    return obstetriList;
  }
}
