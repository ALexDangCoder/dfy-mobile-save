import 'package:Dfy/domain/model/token_inf.dart';
import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  const MainState();
}

class MainStateInitial extends MainState {
  @override
  List<Object> get props => [];
}

class Loading extends MainState {
  @override
  List<Object> get props => [];
}

class GetListTokenSuccess extends MainState {
  List<TokenInf> items = [];

  GetListTokenSuccess(this.items);

  @override
  List<Object> get props => [];
}
