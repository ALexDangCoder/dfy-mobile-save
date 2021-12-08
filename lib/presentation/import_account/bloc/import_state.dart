import 'package:Dfy/domain/model/wallet.dart';
import 'package:equatable/equatable.dart';

abstract class ImportState extends Equatable {}

class ImportInitial extends ImportState {
  @override
  List<Object?> get props => [];
}
class NavState extends ImportState {
  final Wallet wallet;

  NavState(this.wallet);
  @override
  List<Object?> get props => [];
}
class ErrorState extends ImportState {
  final String message;

  ErrorState(this.message);
  @override
  List<Object?> get props => [];
}

