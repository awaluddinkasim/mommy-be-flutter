import 'package:equatable/equatable.dart';
import 'package:mommy_be/models/laktasi_grafik.dart';

class LaktasiGrafikState extends Equatable {
  const LaktasiGrafikState();

  @override
  List<Object> get props => [];
}

class LaktasiGrafikInitial extends LaktasiGrafikState {}

class LaktasiGrafikLoading extends LaktasiGrafikState {}

class LaktasiGrafikSuccess extends LaktasiGrafikState {
  final List<LaktasiGrafik> kiri;
  final List<LaktasiGrafik> kanan;

  const LaktasiGrafikSuccess({
    required this.kiri,
    required this.kanan,
  });

  @override
  List<Object> get props => [kiri, kanan];
}

class LaktasiGrafikFailed extends LaktasiGrafikState {
  final String message;

  const LaktasiGrafikFailed(this.message);

  @override
  List<Object> get props => [message];
}
