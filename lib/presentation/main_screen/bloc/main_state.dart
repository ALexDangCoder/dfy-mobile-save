import 'package:Dfy/domain/model/token_model.dart';
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
  List<TokenModel> items = [];

  GetListTokenSuccess(this.items);

  @override
  List<Object> get props => [];
}