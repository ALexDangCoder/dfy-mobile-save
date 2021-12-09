part of 'wallet_cubit.dart';

@immutable
abstract class WalletState extends Equatable {}

class WalletInitial extends WalletState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class WalletScreenState extends WalletState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class NavigatorSuccessfully extends WalletState {
  @override
  List<Object?> get props => [];
}

class NavigatorReset extends WalletState {
  @override
  List<Object?> get props => [];
}

class ImportNftSuccess extends WalletState {
  @override
  List<Object?> get props => [];
}

class ImportNftFail extends WalletState {
  @override
  List<Object?> get props => [];
}