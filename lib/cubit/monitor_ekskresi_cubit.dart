import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/monitor_ekskresi_state.dart';
import 'package:mommy_be/data/monitor_ekskresi.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/bayi_eksresi_service.dart';

class MonitorEkskresiCubit extends Cubit<MonitorEkskresiState> {
  final _monitorEkskresiService = BayiEkskresiService();
  MonitorEkskresiCubit() : super(MonitorEkskresiInitial());

  Future<void> getMonitorEkskresi(Bayi bayi, DateTime tanggal) async {
    emit(MonitorEkskresiLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final monitorEkskresi = await _monitorEkskresiService.getEkskresi(token!, bayi, tanggal);
      emit(MonitorEkskresiSuccess(monitorEkskresi));
    } catch (e) {
      emit(MonitorEkskresiFailed(e.toString()));
    }
  }

  Future<void> storeMonitorEkskresi(Bayi bayi, DataMonitorEkskresi data) async {
    emit(MonitorEkskresiLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final result = await _monitorEkskresiService.postEkskresi(token!, bayi, data);
      emit(MonitorEkskresiSuccess(result));
    } catch (e) {
      emit(MonitorEkskresiFailed(e.toString()));
    }
  }

  Future<void> deleteMonitorEkskresi(Bayi bayi, int id) async {
    emit(MonitorEkskresiLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final result = await _monitorEkskresiService.deleteEkskresi(token!, bayi, id);
      emit(MonitorEkskresiSuccess(result));
    } catch (e) {
      emit(MonitorEkskresiFailed(e.toString()));
    }
  }
}
