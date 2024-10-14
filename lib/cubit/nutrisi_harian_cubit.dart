
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/nutrisi_harian_state.dart';

class NutrisiHarianCubit extends Cubit<NutrisiHarianState> {
  NutrisiHarianCubit() : super(NutrisiHarianInitial());
}