import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/pertumbuhan_state.dart';
import 'package:mommy_be/data/pertumbuhan.dart';
import 'package:mommy_be/models/bayi.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/bayi_pertumbuhan_service.dart';

class PertumbuhanCubit extends Cubit<PertumbuhanState> {
  final _pertumbuhanService = BayiPertumbuhanService();
  PertumbuhanCubit() : super(PertumbuhanInitial());

  Future<void> getPertumbuhan(Bayi bayi) async {
    emit(PertumbuhanLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final pertumbuhan = await _pertumbuhanService.getPertumbuhan(token!, bayi);
      emit(PertumbuhanSuccess(pertumbuhan));
    } catch (e) {
      emit(PertumbuhanFailed(e.toString()));
    }
  }

  Future<void> storePertumbuhan(Bayi bayi, DataPertumbuhan data) async {
    emit(PertumbuhanLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final pertumbuhan = await _pertumbuhanService.postPertumbuhan(token!, bayi, data);
      emit(PertumbuhanSuccess(pertumbuhan));
    } catch (e) {
      emit(PertumbuhanFailed(e.toString()));
    }
  }

  Future<void> deletePertumbuhan(Bayi bayi, int id) async {
    emit(PertumbuhanLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final pertumbuhan = await _pertumbuhanService.deletePertumbuhan(token!, bayi, id);
      emit(PertumbuhanSuccess(pertumbuhan));
    } catch (e) {
      emit(PertumbuhanFailed(e.toString()));
    }
  }
}
