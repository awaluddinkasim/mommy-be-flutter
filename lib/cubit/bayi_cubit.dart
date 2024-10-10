import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/bayi_state.dart';
import 'package:mommy_be/data/bayi.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/bayi_service.dart';

class BayiCubit extends Cubit<BayiState> {
  final BayiService _bayiService = BayiService();

  BayiCubit() : super(BayiInitial());

  Future<void> getBayi() async {
    emit(BayiLoading());
    try {
      final token = await Constants.storage.read(key: 'token');

      emit(BayiSuccess(await _bayiService.getBayi(token!)));
    } catch (e) {
      emit(BayiFailed(e.toString()));
    }
  }

  Future<void> storeBayi(DataBayi data) async {
    emit(BayiLoading());
    try {
      final token = await Constants.storage.read(key: 'token');

      emit(BayiSuccess(await _bayiService.postBayi(token!, data)));
    } catch (e) {
      emit(BayiFailed(e.toString()));
    }
  }

  Future<void> deleteBayi(int id) async {
    emit(BayiLoading());
    try {
      final token = await Constants.storage.read(key: 'token');

      emit(BayiSuccess(await _bayiService.deleteBayi(token!, id)));
    } catch (e) {
      emit(BayiFailed(e.toString()));
    }
  }
}
