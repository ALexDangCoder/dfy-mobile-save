import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/account_model.dart';
import 'package:Dfy/domain/model/token.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../../main.dart';

part 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  WalletCubit() : super(WalletInitial()) {
    getList();
    getListTokenItem();
    getListNFTItem();
  }

  BehaviorSubject<String> addressWallet =
      BehaviorSubject.seeded('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
  BehaviorSubject<String> walletName =
      BehaviorSubject.seeded('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
  BehaviorSubject<bool> isWalletName = BehaviorSubject.seeded(true);

  void getIsWalletName(String value) {
    if (Validator.validateNotNull(value)) {
      isWalletName.sink.add(true);
    } else {
      isWalletName.sink.add(false);
    }
  }

  bool checkLogin = false;

  Future<void> getAddressWallet() async {}

  String formatAddress(String address) {
    String formatAddressWallet =
        '${address.substring(0, 5)}...${address.substring(
      address.length - 4,
      address.length,
    )}';
    return formatAddressWallet;
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    Object objToken = {};
    Object objNFT = {};
    switch (methodCall.method) {
      case 'getListShowedTokenCallback':
        objToken = methodCall.arguments['TokenObject'];
        break;
      case 'getListShowedNftCallback':
        objNFT = methodCall.arguments;
        break;
      default:
        break;
    }
  }

  Future<void> getListToken(String walletAddress, String password) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'password': password,
      };
      await trustWalletChannel.invokeMethod('getListShowedToken', data);
    } on PlatformException {
      log(e);
    }
  }

  Future<void> getListNFT(
    String walletAddress, {
    required String password,
  }) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'password': password,
      };
      await trustWalletChannel.invokeMethod('getListShowedNft', data);
    } on PlatformException {
      log(e);
    }
  }

  BehaviorSubject<List<TokenModel>> listTokenStream =
      BehaviorSubject.seeded([]);

  void getListTokenItem() {
    listTokenStream.sink.add(listToken);
  }

  List<TokenModel> listToken = [
    TokenModel(
      price: 34213423,
      nameTokenSymbol: 'DFY',
      iconToken: 'assets/images/Ellipse 39.png',
      amountToken: 3344,
    ),
    TokenModel(
      price: 34213423,
      nameTokenSymbol: 'DFY',
      iconToken: 'assets/images/Ellipse 39.png',
      amountToken: 3344,
    ),
    TokenModel(
      price: 34213423,
      nameTokenSymbol: 'DF2Y',
      iconToken: 'assets/images/Ellipse 39.png',
      amountToken: 3344,
    ),
    TokenModel(
      price: 34213423,
      nameTokenSymbol: 'DFY1',
      iconToken: 'assets/images/Ellipse 39.png',
      amountToken: 3344,
    ),
    TokenModel(
      price: 34213423,
      nameTokenSymbol: 'DF3Y',
      iconToken: 'assets/images/Ellipse 39.png',
      amountToken: 3344,
    ),
    TokenModel(
      price: 34213423,
      nameTokenSymbol: 'D4FY',
      iconToken: 'assets/images/Ellipse 39.png',
      amountToken: 3344,
    ),
    TokenModel(
      price: 34213423,
      nameTokenSymbol: 'D5FY',
      iconToken: 'assets/images/Ellipse 39.png',
      amountToken: 3344,
    ),
    TokenModel(
      price: 34213423,
      nameTokenSymbol: 'DFY',
      iconToken: 'assets/images/Ellipse 39.png',
      amountToken: 3344,
    ),
  ];

  BehaviorSubject<List<AccountModel>> list = BehaviorSubject.seeded([]);

  void getList() {
    list.sink.add(listSelectAccBloc);
  }

  List<AccountModel> listSelectAccBloc = [
    AccountModel(
      isCheck: true,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: false,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: false,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: false,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: false,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: false,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
    AccountModel(
      isCheck: false,
      addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      amountWallet: 21342314,
      imported: true,
      nameWallet: 'Account 1',
      url: 'assets/images/Ellipse 39.png',
    ),
  ];

  String formatAddress1(String address) {
    final String a = '${address.substring(0, 5)}...${address.substring(
      address.length - 4,
      address.length,
    )}';
    return a;
  }

  void click(int index) {
    for (final AccountModel value in listSelectAccBloc) {
      value.isCheck = false;
    }
    listSelectAccBloc[index].isCheck = true;
    list.sink.add(listSelectAccBloc);
  }

  BehaviorSubject<List<TokenModel>> listNFTStream = BehaviorSubject.seeded([]);

  void getListNFTItem() {
    listNFTStream.sink.add(listNFT);
  }

  List<TokenModel> listNFT = [
    TokenModel(
      nameToken: 'DEFI FOR YOU2',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR 3YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR 3YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR 3YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR 3YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR2 YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR 34YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR453 YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR23452345 YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
    TokenModel(
      nameToken: 'DEFI FOR YOU',
      iconToken: 'assets/images/Ellipse 39.png',
    ),
  ];
}
