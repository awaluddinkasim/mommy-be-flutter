import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/laktasi_grafik_state.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/laktasi_service.dart';

class LaktasiGrafikCubit extends Cubit<LaktasiGrafikState> {
  final LaktasiService _laktasiService = LaktasiService();
  LaktasiGrafikCubit() : super(LaktasiGrafikInitial());

  Future<void> getLaktasiCharts(int id, DateTime tanggal) async {
    emit(LaktasiGrafikLoading());

    try {
      final token = await Constants.storage.read(key: 'token');
      final response = await _laktasiService.getLaktasiCharts(token!, id, tanggal);

      emit(
        LaktasiGrafikSuccess(
          kiri: response['kiri'] ?? [],
          kanan: response['kanan'] ?? [],
        ),
      );
    } catch (e) {
      emit(LaktasiGrafikFailed(e.toString()));
    }
  }
}
