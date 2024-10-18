import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/laktasi_state.dart';
import 'package:mommy_be/data/laktasi.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/laktasi_service.dart';

class LaktasiCubit extends Cubit<LaktasiState> {
  final LaktasiService _laktasiService = LaktasiService();
  LaktasiCubit() : super(LaktasiInitial());

  Future<void> getLaktasi(int id, DateTime tanggal) async {
    emit(LaktasiLoading());
    try {
      final token = await Constants.storage.read(key: 'token');

      final laktasiList = await _laktasiService.getLaktasi(token!, id, tanggal);
      emit(LaktasiSuccess(laktasiList));
    } catch (e) {
      print(e);
      emit(LaktasiFailed(e.toString()));
    }
  }

  Future<void> postLaktasi(DataLaktasi data) async {
    emit(LaktasiLoading());
    try {
      final token = await Constants.storage.read(key: 'token');

      await _laktasiService.postLaktasi(token!, data);
      emit(const LaktasiSuccess([]));
    } catch (e) {
      emit(LaktasiFailed(e.toString()));
    }
  }
}
