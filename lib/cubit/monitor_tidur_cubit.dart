import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/monitor_tidur_state.dart';
import 'package:mommy_be/data/monitor_tidur.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/bayi_tidur_service.dart';

class MonitorTidurCubit extends Cubit<MonitorTidurState> {
  final _monitorTidurService = BayiTidurService();
  MonitorTidurCubit() : super(MonitorTidurInitial());

  Future<void> getMonitorTidur(Bayi bayi, DateTime tanggal) async {
    emit(MonitorTidurLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final monitorTidur = await _monitorTidurService.getBayiTidur(token!, bayi, tanggal);
      emit(MonitorTidurSuccess(monitorTidur));
    } catch (e) {
      emit(MonitorTidurFailed(e.toString()));
    }
  }

  Future<void> storeMonitorTidur(Bayi bayi, DataMonitorTidur data) async {
    emit(MonitorTidurLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final result = await _monitorTidurService.postBayiTidur(token!, bayi, data);
      emit(MonitorTidurSuccess(result));
    } catch (e) {
      emit(MonitorTidurFailed(e.toString()));
    }
  }

  Future<void> deleteMonitorTidur(Bayi bayi, int id) async {
    emit(MonitorTidurLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final result = await _monitorTidurService.deleteBayiTidur(token!, bayi, id);
      emit(MonitorTidurSuccess(result));
    } catch (e) {
      emit(MonitorTidurFailed(e.toString()));
    }
  }
}
