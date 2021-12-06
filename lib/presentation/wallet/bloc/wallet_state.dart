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

class NavigatorSucces extends WalletState {
  @override
  List<Object?> get props => [];
}
