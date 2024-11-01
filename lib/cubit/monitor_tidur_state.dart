import 'package:equatable/equatable.dart';
import 'package:mommy_be/models/monitor_tidur.dart';

class MonitorTidurState extends Equatable {
  const MonitorTidurState();

  @override
  List<Object> get props => [];
}

class MonitorTidurInitial extends MonitorTidurState {}

class MonitorTidurLoading extends MonitorTidurState {}

class MonitorTidurSuccess extends MonitorTidurState {
  final List<MonitorTidur> monitorTidur;

  const MonitorTidurSuccess(this.monitorTidur);

  @override
  List<Object> get props => [monitorTidur];
}

class MonitorTidurFailed extends MonitorTidurState {
  final String message;

  const MonitorTidurFailed(this.message);

  @override
  List<Object> get props => [message];
}
