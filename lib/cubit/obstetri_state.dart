import 'package:equatable/equatable.dart';
import 'package:mommy_be/models/obstetri.dart';

class ObstetriState extends Equatable {
  const ObstetriState();

  @override
  List<Object> get props => [];
}

class ObstetriInitial extends ObstetriState {}

class ObstetriLoading extends ObstetriState {}

class ObstetriSuccess extends ObstetriState {
  final List<Obstetri> obstetri;

  const ObstetriSuccess(this.obstetri);
  
  @override
  List<Object> get props => [obstetri];
}

class ObstetriFailed extends ObstetriState {
  final String error;

  const ObstetriFailed(this.error);
  
  @override
  List<Object> get props => [error];
}