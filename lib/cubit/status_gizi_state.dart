
import 'package:equatable/equatable.dart';
import 'package:mommy_be/models/status_gizi.dart';

class StatusGiziState extends Equatable {
  const StatusGiziState();

  @override
  List<Object> get props => [];
}

class StatusGiziInitial extends StatusGiziState {}

class StatusGiziLoading extends StatusGiziState {}

class StatusGiziSuccess extends StatusGiziState {
  final List<StatusGizi> statusGizi;

  const StatusGiziSuccess(this.statusGizi);
  
  @override
  List<Object> get props => [statusGizi];
}

class StatusGiziFailed extends StatusGiziState {
  final String error;

  const StatusGiziFailed(this.error);
  
  @override
  List<Object> get props => [error];
}