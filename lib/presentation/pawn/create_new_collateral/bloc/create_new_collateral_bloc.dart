import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/pawn/result_create_new_collateral_model.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/create_new_collateral/bloc/create_new_collateral_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';

class CreateNewCollateralBloc extends BaseCubit<CreateNewCollateralState> {
  CreateNewCollateralBloc() : super(CreateNewCollateralInitial()) {
    showLoading();
    trustWalletChannel.setMethodCallHandler(nativeMethodCallBackTrustWallet);
    getTokens(
      PrefsService.getCurrentWalletCore(),
    );
    getTokenInf();
  }

  String? hexString;
  BehaviorSubject<String> textDuration = BehaviorSubject.seeded('');
  BehaviorSubject<String> textMess = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isMess = BehaviorSubject.seeded(false);
  BehaviorSubject<String> isDuration = BehaviorSubject.seeded('');
  BehaviorSubject<String> isLoanToken = BehaviorSubject.seeded('');
  BehaviorSubject<String> textToken = BehaviorSubject.seeded('DFY');
  List<String> listToken = [];
  BehaviorSubject<String> textRecurringInterest =
      BehaviorSubject.seeded(S.current.weeks_pawn);
  BehaviorSubject<String> errorCollateral = BehaviorSubject.seeded('');
  BehaviorSubject<String> amountCollateral = BehaviorSubject.seeded('');
  BehaviorSubject<bool> chooseExisting = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckBox = BehaviorSubject.seeded(false);
  List<ModelToken> listTokenCollateral = [];
  final List<ModelToken> checkShow = [];
  final Web3Utils client = Web3Utils();
  late ModelToken item;
  List<ModelToken> listTokenFromWalletCore = [];
  final regexTime = RegExp(r'^\d+(()|(\d{})?)$');
  BehaviorSubject<bool> isCheckBtn = BehaviorSubject.seeded(false);
  final _web3utils = Web3Utils();

  BorrowRepository get _pawnService => Get.find();

  void validateLoanToken(String value) {
    textToken.add(value);
    if (textToken.value == item.nameShortToken) {
      isLoanToken.add(S.current.invalid_loan_currency);
    } else {
      isLoanToken.add('');
    }
    checkButton();
  }

  Future<void> postCreateNewCollateral({
    String? amount,
    String? collateral,
    String? description,
    String? expectedLoanDurationTime,
    String? expectedLoanDurationType,
    String? status,
    String? supplyCurrency,
    String? txId,
    String? walletAddress,
  }) async {
    final Result<ResultCreateNewModel> response =
        await _pawnService.postCreateNewCollateral(
      txid: txId,
      collateral: collateral,
      supplyCurrency: supplyCurrency,
      amount: amount,
      status: status,
      walletAddress: walletAddress,
      description: description,
      expectedLoanDurationTime: expectedLoanDurationTime,
      expectedLoanDurationType: expectedLoanDurationType,
    );
    response.when(
      success: (response) {},
      error: (error) {},
    );
  }

  String getMax(String symbol) {
    double balance = 0;
    for (final element in listTokenFromWalletCore) {
      if (element.nameShortToken.toLowerCase() == symbol.toLowerCase()) {
        balance = element.balanceToken;
      }
    }
    return formatPrice.format(balance);
  }

  Future<void> getCreateCryptoCollateralData({
    required String collateralAddress,
    required String amount,
    required String expectedDurationQty,
    required String loanAsset,
    required String packageId,
    required int expectedDurationType,
  }) async {
    hexString = await _web3utils.getCreateCryptoCollateralData(
      collateralAddress: collateralAddress,
      amount: amount,
      expectedDurationQty: expectedDurationQty,
      expectedDurationType: expectedDurationType,
      loanAsset: loanAsset,
      packageId: packageId,
    );
  }

  double getMaxBalance(String symbol) {
    double balance = 0;
    for (final element in listTokenFromWalletCore) {
      if (element.nameShortToken.toLowerCase() == symbol.toLowerCase()) {
        balance = element.balanceToken;
      }
    }
    return balance;
  }

  void validateAmount(String value) {
    if (value == '') {
      errorCollateral.add(S.current.amount_required);
      amountCollateral.add('');
    } else {
      if (double.parse(value) > getMaxBalance(item.nameShortToken)) {
        errorCollateral.add(S.current.invalid_balance);
        amountCollateral.add('');
      } else if (double.parse(value) == 0) {
        errorCollateral.add(S.current.invalid_balance);
        amountCollateral.add('');
      } else {
        errorCollateral.add('');
        amountCollateral.add(value);
      }
    }
    validateLoanToken(textToken.value);
  }

  void checkButton() {
    if (amountCollateral.value.isNotEmpty &&
        textMess.value.isNotEmpty &&
        textDuration.value.isNotEmpty &&
        !isLoanToken.value.isNotEmpty) {
      isCheckBtn.add(true);
    } else {
      isCheckBtn.add(false);
    }
  }

  void enableButtonRequest(String value) {
    if (value.isNotEmpty) {
      if (regexTime.hasMatch(value)) {
        if (textRecurringInterest.value == S.current.weeks_pawn) {
          if (int.parse(value) > 5200) {
            textDuration.add('');
            isDuration.add(S.current.invalid_duration_week);
          } else {
            textDuration.add(value);
            isDuration.add('');
          }
        } else {
          if (int.parse(value) > 1200) {
            textDuration.add('');
            isDuration.add(S.current.invalid_duration_month);
          } else {
            textDuration.add(value);
            isDuration.add('');
          }
        }
      } else {
        textDuration.add('');
        isDuration.add(S.current.duration_is_integer);
      }
    } else {
      textDuration.add('');
      isDuration.add(S.current.invalid_duration);
    }
  }

  void getTokenInf() {
    final String list = PrefsService.getListTokenSupport();
    final List<TokenInf> listTokenInf = TokenInf.decode(list);
    for (final TokenInf value in listTokenInf) {
      listToken.add(value.symbol ?? '');
    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    emit(CreateNewCollateralLoading());
    switch (methodCall.method) {
      case 'getTokensCallback':
        listTokenFromWalletCore.clear();
        final List<dynamic> data = methodCall.arguments;
        for (final element in data) {
          checkShow.add(ModelToken.fromWalletCore(element));
        }
        for (final element in checkShow) {
          if (element.isShow) {
            listTokenFromWalletCore.add(element);
          }
        }
        await getBalanceOFToken(listTokenFromWalletCore);
        checkShowCollateral();
        item = listTokenFromWalletCore.first;
        emit(CreateNewCollateralSuccess(CompleteType.SUCCESS));
        showContent();
        break;
      default:
        break;
    }
  }

  void getTokens(String walletAddress) {
    try {
      final data = {
        'walletAddress': walletAddress,
      };
      trustWalletChannel.invokeMethod('getTokens', data);
    } on PlatformException {
      //nothing
    }
  }

  void checkShowCollateral() {
    for (final item in checkShow) {
      listTokenCollateral.add(item);
    }
  }

  void funCheckMess(String value) {
    if (value.isNotEmpty) {
      textMess.add(value);
      isMess.add(false);
    } else {
      textMess.add('');
      isMess.add(true);
    }
  }

  Stream<ModelToken> getTokenRealtime(List<ModelToken> listModelToken) async* {
    for (int i = 0; i < listModelToken.length; i++) {
      yield listModelToken[i];
    }
  }

  Future<void> getBalanceOFToken(List<ModelToken> list) async {
    await for (final value in getTokenRealtime(list)) {
      if (value.nameShortToken != 'BNB') {
        value.balanceToken = await client.getBalanceOfToken(
          ofAddress: PrefsService.getCurrentWalletCore(),
          tokenAddress: value.tokenAddress,
        );
      } else {
        value.balanceToken = await client.getBalanceOfBnb(
          ofAddress: PrefsService.getCurrentWalletCore(),
        );
      }
    }
  }
}
