import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/status_gizi_state.dart';
import 'package:mommy_be/data/status_gizi.dart';
import 'package:mommy_be/models/obstetri.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/status_gizi_service.dart';

class StatusGiziCubit extends Cubit<StatusGiziState> {
  final StatusGiziService _statusGiziService = StatusGiziService();

  StatusGiziCubit() : super(StatusGiziInitial());

  Future<void> getStatusGizi(Obstetri obstetri) async {
    emit(StatusGiziLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final statusGizi = await _statusGiziService.getStatusGizi(token!, obstetri);
      emit(StatusGiziSuccess(statusGizi));
    } catch (e) {
      emit(StatusGiziFailed(e.toString()));
    }
  }

  Future<void> postStatusGizi(Obstetri obstetri, DataStatusGizi data) async {
    emit(StatusGiziLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final statusGizi = await _statusGiziService.postStatusGizi(token!, obstetri, data);
      emit(StatusGiziSuccess(statusGizi));
    } catch (e) {
      emit(StatusGiziFailed(e.toString()));
    }
  }
}
