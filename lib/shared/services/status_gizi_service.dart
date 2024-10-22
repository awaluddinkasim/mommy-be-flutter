import 'package:mommy_be/data/status_gizi.dart';
import 'package:mommy_be/models/obstetri.dart';
import 'package:mommy_be/models/status_gizi.dart';
import 'package:mommy_be/shared/dio.dart';

class StatusGiziService {
  Future<StatusGizi?> getStatusGizi(String token, Obstetri obstetri) async {
    final response = await Request.get(
      '/status-gizi/${obstetri.id}',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response['data']['statusGizi'] == null) return null;
    return StatusGizi.fromJson(response['data']['statusGizi']);
  }

  Future<StatusGizi> postStatusGizi(String token, Obstetri obstetri, DataStatusGizi data) async {
    final response = await Request.post(
      '/status-gizi/${obstetri.id}',
      data: data.toJson(),
      headers: {'Authorization': 'Bearer $token'},
    );

    return StatusGizi.fromJson(response['data']['statusGizi']);
  }

  Future<StatusGizi> putStatusGizi(String token, StatusGizi statusGizi, DataStatusGizi data) async {
    final response = await Request.put(
      '/status-gizi/${statusGizi.id}',
      data: data.toJson(),
      headers: {'Authorization': 'Bearer $token'},
    );

    return StatusGizi.fromJson(response['data']['statusGizi']);
  }
}
