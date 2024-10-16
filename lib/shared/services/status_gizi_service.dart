import 'package:mommy_be/data/status_gizi.dart';
import 'package:mommy_be/models/obstetri.dart';
import 'package:mommy_be/models/status_gizi.dart';
import 'package:mommy_be/shared/dio.dart';

class StatusGiziService {
  Future<List<StatusGizi>> getStatusGizi(String token, Obstetri obstetri) async {
    final response = await Request.get(
      '/status-gizi/${obstetri.id}',
      headers: {'Authorization': 'Bearer $token'},
    );

    List<StatusGizi> statusGiziList = [];

    for (var statusGizi in response['data']['statusGizi']) {
      statusGiziList.add(StatusGizi.fromJson(statusGizi));
    }

    return statusGiziList;
  }

  Future<List<StatusGizi>> postStatusGizi(String token, Obstetri obstetri, DataStatusGizi data) async {
    final response = await Request.post(
      '/status-gizi/${obstetri.id}',
      data: data.toJson(),
      headers: {'Authorization': 'Bearer $token'},
    );

    List<StatusGizi> statusGiziList = [];

    for (var statusGizi in response['data']['statusGizi']) {
      statusGiziList.add(StatusGizi.fromJson(statusGizi));
    }

    return statusGiziList;
  }
}
