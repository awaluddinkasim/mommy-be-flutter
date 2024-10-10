import 'package:equatable/equatable.dart';
import 'package:mommy_be/models/laktasi.dart';

class LaktasiState extends Equatable {
  const LaktasiState();

  @override
  List<Object> get props => [];
}

class LaktasiInitial extends LaktasiState {}

class LaktasiLoading extends LaktasiState {}

class LaktasiSuccess extends LaktasiState {
  final List<Laktasi> laktasiList;

  const LaktasiSuccess(this.laktasiList);

  @override
  List<Object> get props => [laktasiList];
}

class LaktasiFailed extends LaktasiState {
  final String message;

  const LaktasiFailed(this.message);

  @override
  List<Object> get props => [message];
}
