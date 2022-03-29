part of 'setting_my_acc_cubit.dart';

@immutable
abstract class SettingMyAccState extends Equatable {}

class SettingMyAccInitial extends SettingMyAccState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SettingEmail extends SettingMyAccState {

  final EmailSetting settingEmail;
  SettingEmail(this.settingEmail);
  @override
  // TODO: implement props
  List<Object?> get props => [settingEmail];
}

class SettingNotification extends SettingMyAccState {

  final NotiSetting settingNotification;
  SettingNotification(this.settingNotification);
  @override
  // TODO: implement props
  List<Object?> get props => [settingNotification];
}

class SettingWallet extends SettingMyAccState {

  final List<WalletAddressModel> listWallet;

  SettingWallet(this.listWallet);
  @override
  // TODO: implement props
  List<Object?> get props => [listWallet];
}
