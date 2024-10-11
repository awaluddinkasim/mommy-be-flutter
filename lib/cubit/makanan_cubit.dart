import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/makanan_state.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/makanan_service.dart';

class MakananCubit extends Cubit<MakananState> {
  final MakananService _makananService = MakananService();

  MakananCubit() : super(MakananInitial());

  Future<void> getMakanan() async {
    emit(MakananLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      final makanan = await _makananService.getMakanan(token!);
      emit(MakananSuccess(makanan));
    } catch (e) {
      print(e);
      emit(MakananFailed(e.toString()));
    }
  }
}
