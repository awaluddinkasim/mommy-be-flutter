import 'package:equatable/equatable.dart';
import 'package:mommy_be/models/pertumbuhan.dart';

class PertumbuhanState extends Equatable {
  const PertumbuhanState();

  @override
  List<Object> get props => [];
}

class PertumbuhanInitial extends PertumbuhanState {}

class PertumbuhanLoading extends PertumbuhanState {}

class PertumbuhanSuccess extends PertumbuhanState {
  final List<Pertumbuhan> pertumbuhan;

  const PertumbuhanSuccess(this.pertumbuhan);

  @override
  List<Object> get props => [pertumbuhan];
}

class PertumbuhanFailed extends PertumbuhanState {
  final String message;

  const PertumbuhanFailed(this.message);

  @override
  List<Object> get props => [message];
}
