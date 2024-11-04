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
  final List<LaktasiGrafik> kiriHarian;
  final List<LaktasiGrafik> kananHarian;
  final List<LaktasiGrafik> kiriMingguan;
  final List<LaktasiGrafik> kananMingguan;

  const LaktasiGrafikSuccess({
    required this.kiriHarian,
    required this.kananHarian,
    required this.kiriMingguan,
    required this.kananMingguan,
  });

  @override
  List<Object> get props => [
        kiriHarian,
        kananHarian,
        kiriMingguan,
        kananMingguan,
      ];
}

class LaktasiGrafikFailed extends LaktasiGrafikState {
  final String message;

  const LaktasiGrafikFailed(this.message);

  @override
  List<Object> get props => [message];
}
