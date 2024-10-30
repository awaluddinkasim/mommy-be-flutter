import 'package:equatable/equatable.dart';
import 'package:mommy_be/models/screening_ppd.dart';

class ScreeningPPDState extends Equatable {
  const ScreeningPPDState();

  @override
  List<Object?> get props => [];
}

class ScreeningPPDInitial extends ScreeningPPDState {}

class ScreeningPPDLoading extends ScreeningPPDState {}

class ScreeningPPDSuccess extends ScreeningPPDState {
  final ScreeningPPD? screeningPPD;

  const ScreeningPPDSuccess(this.screeningPPD);

  @override
  List<Object?> get props => [screeningPPD];
}

class ScreeningPPDFailed extends ScreeningPPDState {
  final String message;

  const ScreeningPPDFailed(this.message);

  @override
  List<Object> get props => [message];
}
