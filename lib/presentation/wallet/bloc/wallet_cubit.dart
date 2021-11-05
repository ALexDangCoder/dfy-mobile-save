import 'package:Dfy/config/base/base_cubit.dart';
import 'package:meta/meta.dart';

part 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  final String addressWallet = '0xe77c14cdF13885E1909149B6D9B65734aefDEAEf';
  String formatAddressWallet = '';

  Future<void> getAddressWallet() async {}

  void formatAddress(String address) {
    final splitAddress = address.split('');
    formatAddressWallet = '${splitAddress[0]}'
        '${splitAddress[1]}${splitAddress[2]}'
        '${splitAddress[3]}${splitAddress[6]}'
        '${splitAddress[5]}...${splitAddress[37]}'
        '${splitAddress[38]}${splitAddress[39]}'
        '${splitAddress[40]}';
  }
}
