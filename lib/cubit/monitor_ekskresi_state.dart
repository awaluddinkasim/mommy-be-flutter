import 'package:equatable/equatable.dart';
import 'package:mommy_be/models/monitor_ekskresi.dart';

class MonitorEkskresiState extends Equatable {
  const MonitorEkskresiState();

  @override
  List<Object?> get props => [];
}

class MonitorEkskresiInitial extends MonitorEkskresiState {}

class MonitorEkskresiLoading extends MonitorEkskresiState {}

class MonitorEkskresiSuccess extends MonitorEkskresiState {
  final List<MonitorEkskresi> monitorEkskresi;

  const MonitorEkskresiSuccess(this.monitorEkskresi);

  @override
  List<Object?> get props => [monitorEkskresi];
}

class MonitorEkskresiFailed extends MonitorEkskresiState {
  final String message;

  const MonitorEkskresiFailed(this.message);

  @override
  List<Object?> get props => [message];
}
