import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'setting_wallet_state.dart';

class SettingWalletCubit extends Cubit<SettingWalletState> {
  SettingWalletCubit() : super(SettingWalletInitial());
}
