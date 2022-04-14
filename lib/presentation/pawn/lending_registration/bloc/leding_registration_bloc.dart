import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';
import 'package:Dfy/domain/repository/market_place/wallet_address_respository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'leding_registration_state.dart';

class LendingRegistrationBloc extends BaseCubit<LendingRegistrationState>{
  BehaviorSubject<String> validateTextSubject = BehaviorSubject.seeded('');
  bool checkWalletAddress = false;
  BehaviorSubject<bool> isChooseAcc = BehaviorSubject.seeded(false);
  BehaviorSubject<String> textAddress =
      BehaviorSubject.seeded(PrefsService.getCurrentWalletCore());
  List<String> listAcc = [];
  BehaviorSubject<bool> isBtn = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckBox = BehaviorSubject.seeded(false);

  LendingRegistrationBloc() : super(LendingRegistrationInitial());

  WalletAddressRepository get _walletAddressRepository => Get.find();

  String checkAddress(String address) {
    String data = '';
    if (address.length > 20) {
      data = address.formatAddressWalletConfirm();
    }
    return data;
  }

  Future<void> getListWallet() async {
    final Result<List<WalletAddressModel>> result =
        await _walletAddressRepository.getListWalletAddress();
    result.when(
      success: (res) {
        if (res.isEmpty) {
          checkWalletAddress = false;
        } else {
          if (res.length < 2) {
            checkWalletAddress = false;
          } else {
            checkWalletAddress = true;
          }
          for (final element in res) {
            if (element.walletAddress?.isNotEmpty ?? false) {
              listAcc.add(element.walletAddress ?? '');
            }
          }
          textAddress.add(listAcc.first);
        }
      },
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          getListWallet();
        }
      },
    );
  }

  void chooseAddressFilter(String address) {
    textAddress.sink.add(
      address,
    );
    isChooseAcc.sink.add(false);
  }

  void checkValidate(String email) {
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    if (!emailValid) {
      validateTextSubject.sink.add(S.current.email_invalid);
    }
    if (email.length > 50) {
      validateTextSubject.sink.add(S.current.email_too_long);
    }
    validateTextSubject.sink.add('');
  }
}
