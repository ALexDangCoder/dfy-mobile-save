part of 'connect_wallet_dialog_cubit.dart';

@immutable
abstract class ConnectWalletDialogState extends Equatable{}

class ConnectWalletDialogInitial extends ConnectWalletDialogState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Logined extends ConnectWalletDialogState{
  @override
  List<Object?> get props => throw UnimplementedError();
}

class HasNoWallet extends ConnectWalletDialogState {
  final String contentDialog = S.current.create_now;

  final String contentRightButton = S.current.create;

  @override
  List<Object?> get props => [contentDialog, contentRightButton];
}

class NeedLoginToUse extends ConnectWalletDialogState {
  final String contentDialog = S.current.login_now;

  final String contentRightButton = S.current.login;

  @override
  List<Object?> get props => [contentDialog, contentRightButton];
}
