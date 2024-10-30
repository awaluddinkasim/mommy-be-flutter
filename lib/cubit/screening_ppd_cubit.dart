import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/screening_ppd_state.dart';
import 'package:mommy_be/data/screening_ppd.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/screening_ppd_service.dart';

class ScreeningPPDCubit extends Cubit<ScreeningPPDState> {
  final _screeningPPDService = ScreeningPPDService();
  ScreeningPPDCubit() : super(ScreeningPPDInitial());

  // set state to null
  Future<void> resetScreeningPPD() async {
    emit(const ScreeningPPDSuccess(null));
  }

  Future<void> getScreeningPPD() async {
    emit(ScreeningPPDLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final screeningPpd = await _screeningPPDService.getScreeningPPD(token!);
      emit(ScreeningPPDSuccess(screeningPpd));
    } catch (e) {
      emit(ScreeningPPDFailed(e.toString()));
    }
  }

  Future<void> storeScreeningPPD(DataScreeningPPD data) async {
    emit(ScreeningPPDLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final screeningPpd = await _screeningPPDService.postScreeningPPD(token!, data);
      emit(ScreeningPPDSuccess(screeningPpd));
    } catch (e) {
      emit(ScreeningPPDFailed(e.toString()));
    }
  }
}
