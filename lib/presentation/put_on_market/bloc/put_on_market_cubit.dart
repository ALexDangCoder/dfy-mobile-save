import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/web3/abi/token.g.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_state.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

enum DurationType { MONTH, WEEK }

class PutOnMarketCubit extends BaseCubit<PutOnMarketState> {
  PutOnMarketCubit() : super(PutOnMarketInitState());

  List<Wallet> listWallet = [];
  String? addressWalletCore;
  String? gnameWallet;
  double? balanceWallet;

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    print ("alo");
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        if (data.isEmpty) {
          // emit(NavigatorFirst());
          // await PrefsService.saveFirstAppConfig('true');
        } else {
          for (final element in data) {
            listWallet.add(Wallet.fromJson(element));
          }
          addressWalletCore = listWallet.first.address!;
          gnameWallet = listWallet.first.name!;
          balanceWallet = await Web3Utils()
              .getBalanceOfBnb(ofAddress: addressWalletCore ?? '');

          // addressWallet.add(addressWalletCore);
          // walletName.add(nameWallet);
          // getNFT(addressWalletCore);
          // await getListCategory();
        }
        print(addressWalletCore);
        print(gnameWallet);
        print(balanceWallet);
        break;
    }
  }

  // tab sale

  Token? tokenSale;
  double? valueTokenInputSale;
  int quantitySale = 1;

  final BehaviorSubject<bool> _canContinueSale = BehaviorSubject<bool>();

  Stream<bool> get canContinueSaleStream => _canContinueSale.stream;

  // tab pawn

  Token? tokenPawn;
  double? valueTokenInputPawn;
  DurationType? typeDuration;
  int? valueDuration;
  int quantityPawn = 1;

  final BehaviorSubject<bool> _canContinuePawn = BehaviorSubject<bool>();

  Stream<bool> get canContinuePawnStream => _canContinuePawn.stream;

  // tab auction

  Token? tokenAuction;
  double? valueTokenInputAuction;

  // function sale
  void changeTokenSale({Token? token, double? value}) {
    tokenSale = token;
    valueTokenInputSale = value;
    updateStreamContinueSale();
  }

  void changeQuantitySale({required int value}) {
    quantitySale = value;
    updateStreamContinueSale();
  }

  void updateStreamContinueSale() {
    if (valueTokenInputSale != null && quantitySale > 0) {
      _canContinueSale.sink.add(true);
    } else {
      _canContinueSale.sink.add(false);
    }
  }

  // function pawn
  void changeTokenPawn({Token? token, double? value}) {
    tokenPawn = token;
    valueTokenInputPawn = value;
    print(valueTokenInputPawn);

    updateStreamContinuePawn();
  }

  void changeDurationPawn({DurationType? type, int? value}) {
    typeDuration = type;
    valueDuration = value;
    print(valueDuration);
    updateStreamContinuePawn();
  }

  void changeQuantityPawn({required int value}) {
    quantityPawn = value;
    print(quantityPawn);
    updateStreamContinuePawn();
  }

  void updateStreamContinuePawn() {
    if (valueTokenInputPawn != null &&
        valueDuration != null &&
        quantityPawn > 0) {
      _canContinuePawn.sink.add(true);
    } else {
      _canContinuePawn.sink.add(false);
    }
  }

  void dispose() {
    _canContinuePawn.close();
    _canContinueSale.close();
  }
}
