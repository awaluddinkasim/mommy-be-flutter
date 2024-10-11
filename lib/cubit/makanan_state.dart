import 'package:equatable/equatable.dart';
import 'package:mommy_be/models/makanan.dart';

class MakananState extends Equatable {
  const MakananState();

  @override
  List<Object> get props => [];
}

class MakananInitial extends MakananState {}

class MakananLoading extends MakananState {}

class MakananSuccess extends MakananState {
  final List<Makanan> makananList;
  const MakananSuccess(this.makananList);

  @override
  List<Object> get props => [makananList];
}

class MakananFailed extends MakananState {
  final String message;

  const MakananFailed(this.message);

  @override
  List<Object> get props => [message];
}
