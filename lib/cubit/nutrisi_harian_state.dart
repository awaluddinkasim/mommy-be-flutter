import 'package:equatable/equatable.dart';
import 'package:mommy_be/models/nutrisi_harian.dart';

class NutrisiHarianState extends Equatable {
  const NutrisiHarianState();

  @override
  List<Object> get props => [];
}

class NutrisiHarianInitial extends NutrisiHarianState {}

class NutrisiHarianLoading extends NutrisiHarianState {}

class NutrisiHarianSuccess extends NutrisiHarianState {
  final List<NutrisiHarian> nutrisiHarian;

  const NutrisiHarianSuccess(this.nutrisiHarian);

  @override
  List<Object> get props => [nutrisiHarian];
}

class NutrisiHarianFailed extends NutrisiHarianState {
  final String message;

  const NutrisiHarianFailed(this.message);

  @override
  List<Object> get props => [message];
}
