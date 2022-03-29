import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/presentation/pawn/add_more_collateral/bloc/add_more_collateral_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';

class AddMoreCollateralBloc extends BaseCubit<AddMoreCollateralState> {
  AddMoreCollateralBloc() : super(AddMoreCollateralInitial()) {
    showLoading();
    trustWalletChannel.setMethodCallHandler(nativeMethodCallBackTrustWallet);
    getTokens(
      PrefsService.getCurrentWalletCore(),
    );
  }

  BehaviorSubject<bool> chooseExisting = BehaviorSubject.seeded(false);
  late ModelToken item;
  List<ModelToken> listTokenFromWalletCore = [];
  BehaviorSubject<String> errorCollateral = BehaviorSubject.seeded('');
  List<ModelToken> listTokenCollateral = [];
  final List<ModelToken> checkShow = [];
  final Web3Utils client = Web3Utils();

  String getMax(String symbol) {
    double balance = 0;
    for (final element in listTokenFromWalletCore) {
      if (element.nameShortToken.toLowerCase() == symbol.toLowerCase()) {
        balance = element.balanceToken;
      }
    }
    return formatPrice.format(balance);
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

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    emit(AddMoreCollateralLoading());
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
        emit(AddMoreCollateralSuccess(CompleteType.SUCCESS));
        showContent();
        break;
      default:
        break;
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

  Stream<ModelToken> getTokenRealtime(List<ModelToken> listModelToken) async* {
    for (int i = 0; i < listModelToken.length; i++) {
      yield listModelToken[i];
    }
  }

  void checkShowCollateral() {
    for (final item in checkShow) {
      if (item.nameShortToken == DFY || item.nameShortToken == BNB) {
        listTokenCollateral.add(item);
      }
    }
  }
}
