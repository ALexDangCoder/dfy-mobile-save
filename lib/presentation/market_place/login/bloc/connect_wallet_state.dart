part of 'connect_wallet_cubit.dart';

@immutable
abstract class ConnectWalletState {}

class ConnectWalletInitial extends ConnectWalletState {}

class HasNoWallet extends ConnectWalletState{}

class NeedLoginToUse extends ConnectWalletState{}