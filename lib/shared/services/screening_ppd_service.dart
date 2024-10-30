import 'package:mommy_be/data/screening_ppd.dart';
import 'package:mommy_be/models/screening_ppd.dart';
import 'package:mommy_be/shared/dio.dart';

class ScreeningPPDService {
  Future<ScreeningPPD?> getScreeningPPD(String token) async {
    final response = await Request.get(
      '/screening-ppd',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response['data']['ppdScreening'] == null) return null;
    return ScreeningPPD.fromJson(response['data']['ppdScreening']);
  }

  Future<ScreeningPPD> postScreeningPPD(String token, DataScreeningPPD data) async {
    final response = await Request.post(
      '/screening-ppd',
      headers: {
        'Authorization': 'Bearer $token',
      },
      data: data.toJson(),
    );

    return ScreeningPPD.fromJson(response['data']['ppdScreening']);
  }
}
