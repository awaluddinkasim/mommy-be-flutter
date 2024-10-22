import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/nutrisi_harian_state.dart';
import 'package:mommy_be/data/nutrisi_harian.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/nurtrisi_harian_service.dart';

class NutrisiHarianCubit extends Cubit<NutrisiHarianState> {
  final NurtrisiHarianService _nurtrisiHarianService = NurtrisiHarianService();
  NutrisiHarianCubit() : super(NutrisiHarianInitial());

  double get totalKalori => (state as NutrisiHarianSuccess).nutrisiHarian.fold(
        0,
        (prev, current) => prev + current.makanan.kalori,
      );

  Future<void> getNutrisiHarian(DateTime tanggal) async {
    emit(NutrisiHarianLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final result = await _nurtrisiHarianService.getNutrisiHarian(token!, tanggal);
      emit(NutrisiHarianSuccess(
        nutrisiHarian: result['nutrisiHarian'],
        kebutuhanKalori: result['kebutuhanKalori'],
      ));
    } catch (e) {
      print(e);
      emit(NutrisiHarianFailed(e.toString()));
    }
  }

  Future<void> storeNutrisiHarian(DataNutrisiHarian data) async {
    emit(NutrisiHarianLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final result = await _nurtrisiHarianService.postNutrisiHarian(token!, data);
      emit(NutrisiHarianSuccess(
        nutrisiHarian: result['nutrisiHarian'],
        kebutuhanKalori: result['kebutuhanKalori'],
      ));
    } catch (e) {
      emit(NutrisiHarianFailed(e.toString()));
    }
  }
}
