import 'package:intl/intl.dart';
import 'package:mommy_be/data/monitor_tidur.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/models/monitor_tidur.dart';
import 'package:mommy_be/shared/dio.dart';

class BayiTidurService {
  Future<List<MonitorTidur>> getBayiTidur(String token, Bayi bayi, DateTime tanggal) async {
    final response = await Request.get(
      '/baby/${bayi.id}/monitor-tidur?tanggal=${DateFormat('yyyy-MM-dd').format(tanggal)}',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    List<MonitorTidur> monitorTidurList = [];

    for (var item in response['data']['monitorTidur']) {
      monitorTidurList.add(MonitorTidur.fromJson(item));
    }

    return monitorTidurList;
  }

  Future<List<MonitorTidur>> postBayiTidur(String token, Bayi bayi, DataMonitorTidur data) async {
    final response = await Request.post(
      '/baby/${bayi.id}/monitor-tidur',
      headers: {
        'Authorization': 'Bearer $token',
      },
      data: data.toJson(),
    );

    List<MonitorTidur> monitorTidurList = [];

    for (var item in response['data']['monitorTidur']) {
      monitorTidurList.add(MonitorTidur.fromJson(item));
    }

    return monitorTidurList;
  }

  Future<List<MonitorTidur>> deleteBayiTidur(String token, Bayi bayi, int id) async {
    final response = await Request.delete(
      '/baby/${bayi.id}/monitor-tidur/$id',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    List<MonitorTidur> monitorTidurList = [];

    for (var item in response['data']['monitorTidur']) {
      monitorTidurList.add(MonitorTidur.fromJson(item));
    }

    return monitorTidurList;
  }
}
