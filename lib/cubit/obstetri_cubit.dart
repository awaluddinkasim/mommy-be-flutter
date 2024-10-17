import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/obstetri_state.dart';
import 'package:mommy_be/data/obstetri.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/obstetri_service.dart';

class ObstetriCubit extends Cubit<ObstetriState> {
  final ObstetriService _obstetriService = ObstetriService();

  ObstetriCubit() : super(ObstetriInitial());

  void toggleExpanded(int index) {
    final obstetriList = (state as ObstetriSuccess).obstetri;
    final obstetri = obstetriList.map((e) {
      if (obstetriList.indexOf(e) == index) {
        return e.copyWith(expanded: !e.expanded);
      } else {
        return e;
      }
    }).toList();

    emit(ObstetriSuccess(obstetri));
  }

  Future<void> getObstetri() async {
    emit(ObstetriLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final obstetri = await _obstetriService.getObstetri(token!);
      emit(ObstetriSuccess(obstetri));
    } catch (e) {
      emit(ObstetriFailed(e.toString()));
    }
  }

  Future<void> storeObstetri(DataObstetri data) async {
    emit(ObstetriLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final obstetri = await _obstetriService.postObstetri(token!, data);
      emit(ObstetriSuccess(obstetri));
    } catch (e) {
      emit(ObstetriFailed(e.toString()));
    }
  }
}
