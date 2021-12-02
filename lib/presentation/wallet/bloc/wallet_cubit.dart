import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/account_model.dart';
import 'package:Dfy/domain/model/token.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

part 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  WalletCubit() : super(WalletInitial()) {
    listTokenDetailScreen = listTokenInitial;
    getListSort();
    getList();
    getListTokenItem();
    getListNFTItem();
  }

  bool checkLogin = false;
  List<TokenModel> listStart = [];
  List<Wallet> listWallet = [];
  BehaviorSubject<List<TokenModel>> listTokenStream =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<TokenModel>> listNFTStream = BehaviorSubject.seeded([]);
  BehaviorSubject<String> tokenAddressText = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenDecimal = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenSymbol = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenAddressTextNft = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenSymbolText = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenDecimalText = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isTokenAddressText = BehaviorSubject.seeded(true);
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isTokenEnterAddress = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isImportToken = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isImportNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isNFT = BehaviorSubject.seeded(true);
  BehaviorSubject<List<TokenModel>> getListTokenModel =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<AccountModel>> list = BehaviorSubject.seeded([]);
  BehaviorSubject<String> addressWallet =
      BehaviorSubject.seeded('0xe77c14cdF13885E1909149B6D9B65734aefDEAEf');
  BehaviorSubject<String> walletName = BehaviorSubject.seeded('Account 1');
  BehaviorSubject<bool> isWalletName = BehaviorSubject.seeded(true);
  BehaviorSubject<double> totalBalance = BehaviorSubject();

  String addressWalletCore = '';
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
  List<TokenModel> listTokenDetailScreen = [];
  List<TokenModel> listTokenInitial = [
    TokenModel(
      price: 342.423,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0,
    ),
    TokenModel(
      price: 3421.2223,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0,
    ),
    TokenModel(
      price: 34213423,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 1,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'Bitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0.2134,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: true,
      nameToken: 'ABitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0.324,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'CBitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 2.21321434,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: true,
      nameToken: 'DBitcoin',
      nameTokenSymbol: 'BTC',
      amountToken: 0,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: true,
      nameToken: 'WBitcoin',
      nameTokenSymbol: 'BTC3',
      amountToken: 021342344,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'QBitcoin',
      nameTokenSymbol: 'BT3C',
      amountToken: 0,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: true,
      nameToken: 'UBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0.213434,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0.413423,
    ),
    TokenModel(
      price: 121,
      tokenId: 21,
      iconToken: 'assets/images/Ellipse 39.png',
      isShow: false,
      nameToken: 'TBitcoin',
      nameTokenSymbol: 'B3TC',
      amountToken: 0,
    ),
  ];

  Future<void> getAddressWallet() async {}

  Future<void> getListWallets(String password) async {
    try {
      final data = {
        'password': password,
      };
      await trustWalletChannel.invokeMethod('getListWallets', data);
    } on PlatformException {}
  }

  String formatAddress(String address) {
    if (address.isEmpty) return address;
    final String formatAddressWallet =
        '${address.substring(0, 5)}...${address.substring(
      address.length - 4,
      address.length,
    )}';
    return formatAddressWallet;
  }

  void getListTokenItem() {
    final List<TokenModel> listToken = [];
    for (final TokenModel value in getListTokenModel.value) {
      if (value.isShow ?? false) {
        listToken.add(value);
      }
    }
    listTokenDetailScreen.clear();
    listTokenDetailScreen.addAll(listToken);
    listTokenStream.sink.add(listTokenDetailScreen);
  }

  void addToken(TokenModel tokenModel) {
    final List<TokenModel> listToken = getListTokenModel.value;
    listToken.add(tokenModel);
    getListTokenModel.sink.add(listToken);
    sortList(getListTokenModel.value);
  }

  double total(List<TokenModel> list) {
    double total = 0;
    for (int i = 0; i < list.length; i++) {
      total = total + list[i].price!;
    }
    return total;
  }

  void getListTokenItemRemove() {
    listTokenStream.sink.add(listTokenDetailScreen);
  }

  void getList() {
    list.sink.add(listSelectAccBloc);
  }

  void click(int index) {
    for (final AccountModel value in listSelectAccBloc) {
      value.isCheck = false;
    }
    listSelectAccBloc[index].isCheck = true;
    list.sink.add(listSelectAccBloc);
  }

  void getListNFTItem() {
    listNFTStream.sink.add(listNFT);
  }

  String formatNumber(double amount) {
    return '${amount.toStringAsExponential(5).toString().substring(0, 5)}'
        ',${amount.toStringAsExponential(5).toString().substring(5, 7)}';
  }

  void checkAddressNullNFT() {
    if (tokenAddressTextNft.value.isEmpty) {
      isNFT.sink.add(false);
    } else {
      isNFT.sink.add(true);
    }
  }

  void getListSort() {
    final List<TokenModel> list = [];
    for (final TokenModel value in listTokenInitial) {
      if (value.isShow ?? false) {
        list.add(value);
      }
    }
    final Comparator<TokenModel> amountTokenComparator =
        (b, a) => (a.amountToken ?? 0).compareTo(b.amountToken ?? 0);
    list.sort(amountTokenComparator);
    final List<TokenModel> list1 = [];
    for (final TokenModel value in listTokenInitial) {
      if (value.isShow ?? false) {
      } else {
        if ((value.amountToken ?? 0) > 0) {
          list1.add(value);
        }
      }
    }
    list1.sort(amountTokenComparator);
    list.addAll(list1);
    for (final TokenModel value in listTokenInitial) {
      if (value.isShow ?? false) {
      } else {
        if ((value.amountToken ?? 0) > 0) {
        } else {
          list.add(value);
        }
      }
    }
    listStart.addAll(list);
    getListTokenModel.sink.add(list);
  }

  void sortList(List<TokenModel> listSort) {
    final List<TokenModel> list = [];
    for (final TokenModel value in listSort) {
      if (value.isShow ?? false) {
        list.add(value);
      }
    }
    final Comparator<TokenModel> amountTokenComparator =
        (b, a) => (a.amountToken ?? 0).compareTo(b.amountToken ?? 0);
    list.sort(amountTokenComparator);
    final List<TokenModel> list1 = [];
    for (final TokenModel value in listSort) {
      if (value.isShow ?? false) {
      } else {
        if ((value.amountToken ?? 0) > 0) {
          list1.add(value);
        }
      }
    }
    list1.sort(amountTokenComparator);
    list.addAll(list1);
    for (final TokenModel value in listSort) {
      if (value.isShow ?? false) {
      } else {
        if ((value.amountToken ?? 0) > 0) {
        } else {
          list.add(value);
        }
      }
    }
    getListTokenModel.sink.add(list);
  }

  void search() {
    final List<TokenModel> result = [];
    // listTokenShow1=listToken;
    for (final TokenModel value in listTokenInitial) {
      if (value.nameToken!.toLowerCase().contains(
            textSearch.value.toLowerCase(),
          )) {
        result.add(value);
      }
    }
    if (textSearch.value.isEmpty) {
      getListTokenModel.sink.add(listStart);
    }
    if (textSearch.value.isNotEmpty) {
      getListTokenModel.sink.add(result);
    }
  }

  void checkAddressNull() {
    if (tokenAddressText.value == '') {
      isTokenAddressText.sink.add(false);
    } else {
      isTokenAddressText.sink.add(true);
    }
  }

  void getIsWalletName(String value) {
    if (Validator.validateNotNull(value)) {
      isWalletName.sink.add(true);
    } else {
      isWalletName.sink.add(false);
    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    final bool isSetShowedToken;
    final bool isSetShowedNft;
    switch (methodCall.method) {
      case 'importTokenCallback':
        final bool isSuccess = await methodCall.arguments['isSuccess'];
        isImportToken.sink.add(isSuccess);
        break;
      case 'getListSupportedTokenCallback':
        final a = await methodCall.arguments['TokenObject'];
        break;
      case 'setShowedTokenCallback':
        isSetShowedToken = await methodCall.arguments['isSuccess'];
        break;
      case 'importNftCallback':
        final bool isSuccess = await methodCall.arguments['isSuccess'];
        isImportNft.sink.add(isSuccess);

        break;
      case 'setShowedNftCallback':
        isSetShowedNft = await methodCall.arguments['isSuccess'];

        break;

      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        for (final element in data) {
          listWallet.add(Wallet.fromJson(element));
        }

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
    } on PlatformException {}
  }

// list
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
    } on PlatformException {}
  }

  Future<void> importToken({
    String password = '',
    required String walletAddress,
    required String tokenAddress,
    required String symbol,
    required int decimal,
  }) async {
    try {
      final data = {
        'password': password,
        'walletAddress': walletAddress,
        'tokenAddress': tokenAddress,
        'symbol': symbol,
        'decimal': decimal,
      };
      await trustWalletChannel.invokeMethod('importToken', data);
    } on PlatformException {
      //todo

    }
  }

  Future<void> getListSupportedToken({
    String password = '',
    required String walletAddress,
  }) async {
    try {
      final data = {
        'password': password,
        'walletAddress': walletAddress,
      };
      await trustWalletChannel.invokeMethod('getListSupportedToken', data);
    } on PlatformException {
      //todo

    }
  }

  Future<void> setShowedToken({
    String password = '',
    required String walletAddress,
    required String tokenAddress,
    required bool isShow,
  }) async {
    try {
      final data = {
        'password': password,
        'walletAddress': walletAddress,
        'tokenAddress': tokenAddress,
        'isShow': isShow,
      };
      await trustWalletChannel.invokeMethod('setShowedToken', data);
    } on PlatformException {
      //todo

    }
  }

  Future<void> importNft({
    String password = '',
    required String walletAddress,
    required String nftAddress,
    required int nftID,
  }) async {
    try {
      final data = {
        'password': password,
        'walletAddress': walletAddress,
        'nftAddress': nftAddress,
        'nftID': nftID,
      };
      await trustWalletChannel.invokeMethod('importNft', data);
    } on PlatformException {
      //todo

    }
  }

  Future<void> setShowedNft({
    String password = '',
    required String walletAddress,
    required String nftAddress,
    required bool isShow,
  }) async {
    try {
      final data = {
        'password': password,
        'walletAddress': walletAddress,
        'isShow': isShow,
        'nftAddress': nftAddress,
      };
      await trustWalletChannel.invokeMethod('setShowedNft', data);
    } on PlatformException {
      //todo

    }
  }
}
