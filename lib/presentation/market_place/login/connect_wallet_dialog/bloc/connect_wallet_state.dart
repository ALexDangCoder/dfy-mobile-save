part of 'connect_wallet_cubit.dart';

@immutable
abstract class ConnectWalletState {
  final String contentDialog = '';
  final String contentRightButton = '';
}

class ConnectWalletInitial extends ConnectWalletState {}

class HasNoWallet extends ConnectWalletState {
  @override
  String get contentDialog => S.current.create_now;

  @override
  String get contentRightButton => S.current.create;
}

class NeedLoginToUse extends ConnectWalletState {
  @override
  String get contentDialog => S.current.login_now;

  @override
  String get contentRightButton => S.current.login;
}
