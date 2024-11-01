import 'package:intl/intl.dart';
import 'package:mommy_be/data/monitor_ekskresi.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/models/monitor_ekskresi.dart';
import 'package:mommy_be/shared/dio.dart';

class BayiEkskresiService {
  Future<List<MonitorEkskresi>> getEkskresi(String token, Bayi bayi, DateTime tanggal) async {
    final response = await Request.get(
      '/baby/${bayi.id}/ekskresi?tanggal=${DateFormat('yyyy-MM-dd').format(tanggal)}',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    List<MonitorEkskresi> monitorEkskresiList = [];

    for (var item in response['data']['ekskresi']) {
      monitorEkskresiList.add(MonitorEkskresi.fromJson(item));
    }

    return monitorEkskresiList;
  }

  Future<List<MonitorEkskresi>> postEkskresi(String token, Bayi bayi, DataMonitorEkskresi data) async {
    final response = await Request.post(
      '/baby/${bayi.id}/ekskresi',
      headers: {
        'Authorization': 'Bearer $token',
      },
      data: data.toJson(),
    );

    List<MonitorEkskresi> monitorEkskresiList = [];

    for (var item in response['data']['ekskresi']) {
      monitorEkskresiList.add(MonitorEkskresi.fromJson(item));
    }

    return monitorEkskresiList;
  }

  Future<List<MonitorEkskresi>> deleteEkskresi(String token, Bayi bayi, int id) async {
    final response = await Request.delete(
      '/baby/${bayi.id}/ekskresi/$id',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    List<MonitorEkskresi> monitorEkskresiList = [];

    for (var item in response['data']['ekskresi']) {
      monitorEkskresiList.add(MonitorEkskresi.fromJson(item));
    }

    return monitorEkskresiList;
  }
}
