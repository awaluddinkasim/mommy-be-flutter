import 'package:mommy_be/models/obstetri.dart';
import 'package:mommy_be/shared/dio.dart';

class ObstetriService {
  Future<List<Obstetri>> getObstetri(String token) async {
    final response = await Request.get('/obstetri', headers: {
      'Authorization': 'Bearer $token'
    });

    List<Obstetri> obstetriList = [];

    for (var obstetri in response['data']['obstetri']) {
      obstetriList.add(Obstetri.fromJson(obstetri));
    }

    return obstetriList;
  }
}