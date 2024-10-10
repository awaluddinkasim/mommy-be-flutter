import 'package:equatable/equatable.dart';
import 'package:mommy_be/models/bayi.dart';

class BayiState extends Equatable {
  const BayiState();

  @override
  List<Object> get props => [];
}

class BayiInitial extends BayiState {}

class BayiLoading extends BayiState {}

class BayiSuccess extends BayiState {
  final List<Bayi> bayiList;

  const BayiSuccess(this.bayiList);

  @override
  List<Object> get props => [bayiList];
}

class BayiFailed extends BayiState {
  final String message;

  const BayiFailed(this.message);

  @override
  List<Object> get props => [message];
}
