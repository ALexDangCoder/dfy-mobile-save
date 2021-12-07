import 'package:Dfy/domain/model/wallet.dart';
import 'package:equatable/equatable.dart';

abstract class RestoreState extends Equatable {}

class RestoreInitial extends RestoreState {
  @override
  List<Object?> get props => [];
}

class NavState extends RestoreState {
  final Wallet wallet;

  NavState(this.wallet);
  @override
  List<Object?> get props => [];
}

class ErrorState extends RestoreState {
  @override
  List<Object?> get props => [];
}


