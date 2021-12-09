import 'dart:convert';
import 'dart:developer';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/model/collection_nft_info.dart';
import 'package:Dfy/data/web3/model/nft_info_model.dart';
import 'package:Dfy/data/web3/model/token_info_model.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/account_model.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/nft_model.dart';
import 'package:Dfy/domain/model/token.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/domain/repository/token_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;

part 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  //handle validate form
  final BehaviorSubject<bool> isShowValidateText =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<String> warningText =
      BehaviorSubject<String>.seeded('');

  ///web3
  Web3Utils client = Web3Utils();

  Future<void> getTokenInfoByAddress({required String tokenAddress}) async {
    print(tokenAddress);
    final TokenInfoModel? tokenInfoModel =
        await client.getTokenInfo(contractAddress: tokenAddress);
    print('>>>>>>>>>>>>>>>>$tokenInfoModel<<<<<<<<<<<<<<<<<<<<<<<<');
    if (tokenInfoModel != null) {
      print('>>>>>>>>>>>>>>>>$tokenInfoModel<<<<<<<<<<<<<<<<<<<<<<<<');
      tokenSymbol.sink.add(tokenInfoModel.tokenSymbol ?? 'null');
      tokenDecimal.sink.add('${tokenInfoModel.decimal ?? 0} ');
      tokenFullName = tokenInfoModel.name ?? '';
      if (tokenInfoModel.tokenSymbol!.isNotEmpty) {
        //isShowValidateText.sink.add(false);
        isTokenEnterAddress.sink.add(true);
        // if (!isHaveToken.value) {
        //   isTokenEnterAddress.sink.add(true);
        // }
      }
      if (tokenInfoModel.tokenSymbol!.isEmpty) {
        isTokenEnterAddress.sink.add(false);
      }
      print('--------------------------------------${tokenInfoModel.name}');
      print('----------------------------------${tokenInfoModel.tokenSymbol}');
      print('--------------------------------------${tokenInfoModel.decimal}');
      isAddressNotExist.sink.add(false);
      print('---------------------------${isAddressNotExist.value}');
    }
    if (tokenInfoModel == null) {
      isAddressNotExist.sink.add(true);
      print('---------------------------${isAddressNotExist.value}');
    }
  }

  String nftName = '';
  String iconNFT = '';

  // contract: '0x588B1b7C48517D1C8E1e083d4c05389D2E1A5e37',
  // name: 'Name of NFT',
  // blockchain: 'Binance Smart Chain',
  // description:
  // 'In fringilla orci facilisis in sed eget nec sollicitudin nullam',
  // id: '124124',
  // link: 'https://goole.com',
  // standard: 'ERC-721',
  //todo getNftInfoByAddress
  Future<void> getNftInfoByAddress({
    required String nftAddress,
    int? enterId,
  }) async {
    final NftInfo nftInfoModel = await client.getNftInfo(
      contract: '',
      id: 12,
    );
    nftName = nftInfoModel.name ?? '';
    iconNFT = nftInfoModel.link ?? '';
  }

  Future<double> getWalletDetail({required String walletAddress}) async {
    final double balanceOfBnb =
        await client.getBalanceOfBnb(ofAddress: walletAddress);
    return balanceOfBnb;
  }

  void getListWallet({
    required String addressWallet,
  }) async {
    for (final Wallet value in listWallet) {
      final double balanceOfBnb = await getWalletDetail(
        walletAddress: value.address ?? '',
      );
      if (addressWallet == value.address) {
        AccountModel acc = AccountModel(
          isCheck: true,
          addressWallet: value.address,
          amountWallet: balanceOfBnb,
          imported: false,
          nameWallet: value.name,
          url: 'assets/images/Ellipse 39.png',
        );
        listSelectAccBloc.add(acc);
      } else {
        AccountModel acc = AccountModel(
          isCheck: false,
          addressWallet: value.address,
          amountWallet: balanceOfBnb,
          imported: false,
          nameWallet: value.name,
          url: 'assets/images/Ellipse 39.png',
        );
        listSelectAccBloc.add(acc);
      }
    }
    getListAcc();
  }

  final List<ModelToken> checkShow = [];
  String tokenFullName = '';
  String iconToken =
      'https://assets.coingecko.com/coins/images/825/thumb/binance-coin-logo.png?1547034615';
  bool checkLogin = false;
  List<TokenModel> listStart = [];
  List<Wallet> listWallet = [];
  List<ModelToken> listTokenFromWalletCore = [];
  List<ModelToken> listTokenImport = [];
  List<NftModel> listNftFromWalletCore = [];
  BehaviorSubject<List<ModelToken>> listTokenStream =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<NftModel>> listNFTStream = BehaviorSubject.seeded([]);
  BehaviorSubject<String> tokenAddressText = BehaviorSubject.seeded('');
  BehaviorSubject<String> nftEnterID = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenAddressTextNft = BehaviorSubject.seeded('');
  BehaviorSubject<String> tokenSymbolText = BehaviorSubject();
  BehaviorSubject<String> tokenDecimalText = BehaviorSubject();
  BehaviorSubject<String> tokenSymbol = BehaviorSubject();
  BehaviorSubject<String> tokenDecimal = BehaviorSubject();
  BehaviorSubject<bool> isTokenAddressText = BehaviorSubject.seeded(true);
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');

  BehaviorSubject<bool> isTokenEnterAddress = BehaviorSubject();
  BehaviorSubject<bool> isAddressNotExist = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isHaveToken = BehaviorSubject.seeded(true);
  BehaviorSubject<bool> isTextTokenEnterAddress = BehaviorSubject.seeded(false);

  BehaviorSubject<bool> isImportNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isImportNftFail = BehaviorSubject.seeded(true);
  BehaviorSubject<bool> isNFT = BehaviorSubject.seeded(true);
  BehaviorSubject<List<ModelToken>> getListTokenModel =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<AccountModel>> list = BehaviorSubject.seeded([]);
  BehaviorSubject<String> addressWallet = BehaviorSubject();
  BehaviorSubject<String> walletName = BehaviorSubject.seeded('Account 1');
  BehaviorSubject<bool> isWalletName = BehaviorSubject.seeded(true);
  BehaviorSubject<double> totalBalance = BehaviorSubject();

  List<HistoryNFT> listHistory = [];

  Future<void> getTransactionNFTHistory() async {
    listHistory = await client.getNFTHistory();
  }

  String addressWalletCore = '';
  String nameWallet = '';
  List<AccountModel> listSelectAccBloc = [];

  String formatAddress(String address) {
    if (address.isEmpty) return address;
    final String formatAddressWallet =
        '${address.substring(0, 5)}...${address.substring(
      address.length - 4,
      address.length,
    )}';
    return formatAddressWallet;
  }

  double total(List<ModelToken> list) {
    double total = 0;
    for (int i = 0; i < list.length; i++) {
      total = total + list[i].exchangeRate * list[i].balanceToken;
    }
    totalBalance.add(total);
    return total;
  }

  void getListAcc() {
    list.sink.add(listSelectAccBloc);
  }

  void resetImportToken() {
    tokenSymbol.sink.add(S.current.token_symbol);
    tokenDecimal.sink.add(S.current.token_decimal);
    emit(NavigatorReset());
  }

  void click(int index) {
    for (final AccountModel value in listSelectAccBloc) {
      value.isCheck = false;
    }
    listSelectAccBloc[index].isCheck = true;
    list.sink.add(listSelectAccBloc);
  }

  String formatNumber(double amount) {
    return '${amount.toStringAsExponential(5).substring(0, 5)}'
        ',${amount.toStringAsExponential(5).substring(5, 7)}';
  }

  void checkAddressNullNFT() {
    if (tokenAddressTextNft.value.isEmpty) {
      isNFT.sink.add(false);
    } else {
      isNFT.sink.add(true);
    }
  }

  void checkAddressNull() {
    if (tokenAddressText.value == '') {
      isTokenAddressText.sink.add(false);
    } else {
      isTokenAddressText.sink.add(true);
    }
  }

//todo sort list
  void sortList(List<ModelToken> listSort) {
    final List<ModelToken> list = [];
    for (final ModelToken value in listSort) {
      if (value.isShow) {
        list.add(value);
      }
    }
    final Comparator<ModelToken> amountTokenComparator =
        (b, a) => (a.balanceToken).compareTo(b.balanceToken);
    list.sort(amountTokenComparator);
    final List<ModelToken> list1 = [];
    for (final ModelToken value in listSort) {
      if (value.isShow) {
      } else {
        if ((value.balanceToken) > 0) {
          list1.add(value);
        }
      }
    }
    list1.sort(amountTokenComparator);
    list.addAll(list1);
    for (final ModelToken value in listSort) {
      if (value.isShow) {
      } else {
        if ((value.balanceToken) > 0) {
        } else {
          list.add(value);
        }
      }
    }
    getListTokenModel.sink.add(list);
  }

//todo search
  void search() {
    final List<ModelToken> result = [];
    for (final ModelToken value in checkShow) {
      if (value.nameShortToken.toLowerCase().contains(
            textSearch.value.toLowerCase(),
          )) {
        result.add(value);
      }
    }

    if (textSearch.value.isEmpty) {
      sortList(checkShow);
    }
    if (textSearch.value.isNotEmpty) {
      getListTokenModel.sink.add(result);
    }
  }

  void getIsWalletName(String value) {
    if (Validator.validateNotNull(value)) {
      isWalletName.sink.add(true);
    } else {
      isWalletName.sink.add(false);
    }
  }

  ///Logic Token

  TokenRepository get _tokenRepository => Get.find();

  Future<void> getListCategory() async {
    final Result<List<TokenInf>> result = await _tokenRepository.getListToken();
    result.when(
      success: (res) {
        getTokenInfoByAddressList(res: res);
      },
      error: (error) {
        updateStateError();
      },
    );
  }

  List<ModelToken> getListModelToken = [];

  Stream<TokenInf> getListTokenRealtime(List<TokenInf> listTokenInf) async* {
    for (int i = 0; i < listTokenInf.length; i++) {
      yield listTokenInf[i];
    }
  }

  Stream<ModelToken> getTokenRealtime(List<ModelToken> listModelToken) async* {
    for (int i = 0; i < listModelToken.length; i++) {
      yield listModelToken[i];
    }
  }

  Future<void> getTokenInfoByAddressList({
    required List<TokenInf> res,
  }) async {
    final List<ModelToken> listJson = [];
    await for (final value in getListTokenRealtime(res)) {
      getListModelToken.add(
        ModelToken(
          tokenAddress: value.address ?? '',
          iconToken: value.iconUrl ?? '',
          nameShortToken: value.symbol ?? '',
          nameToken: value.name ?? '',
          exchangeRate: value.usdExchange ?? 0,
          walletAddress: addressWalletCore,
          decimal: 18.0,
        ),
      );
      listJson.add(
        ModelToken(
          tokenAddress: value.address ?? '',
          iconToken: value.iconUrl ?? '',
          nameShortToken: value.symbol ?? '',
          nameToken: value.name ?? '',
          exchangeRate: value.usdExchange ?? 0,
          walletAddress: addressWalletCore,
          decimal: 18.0,
        ),
      );
    }
    final json = jsonEncode(listJson.map((e) => e.toJson()).toList());
    await importListToken(json);
  }

  Future<void> getExchangeRate(
    List<ModelToken> listShow,
    List<ModelToken> listCheck,
  ) async {
    await for (final valueShow in getTokenRealtime(listShow)) {
      await for (final valueCheck in getTokenRealtime(listCheck)) {
        if (valueShow.nameShortToken == valueCheck.nameShortToken) {
          valueShow.exchangeRate = valueCheck.exchangeRate;
        }
      }
    }
  }

  Future<void> getBalanceOFToken(List<ModelToken> list) async {
    for (int i = 0; i < list.length; i++) {
      list[i].balanceToken = await client.getBalanceOfToken(
        ofAddress: addressWalletCore,
        tokenAddress: '0x1Fa4a73a3F0133f0025378af00236f3aBDEE5D63',
      );
    }
  }

  ///Wallet Core

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'importTokenCallback':
        final bool isSuccess = await methodCall.arguments['isSuccess'];
        print(isSuccess);
        if (isSuccess) {
          emit(NavigatorSuccessfully());
        }
        break;
      case 'importListTokenCallback':
        final bool isSuccess = await methodCall.arguments['isSuccess'];
        if (isSuccess) {
          await getTokens(
            addressWalletCore,
          );
          await getNFT(
            addressWalletCore,
          );
        }
        break;
      case 'earseWalletCallback':
        bool isSuccess = await methodCall.arguments['isSuccess'];
        break;
      case 'getListSupportedTokenCallback':
        //final a = await methodCall.arguments['TokenObject'];
        break;
      case 'setShowedTokenCallback':
        // isSetShowedToken = await methodCall.arguments['isSuccess'];
        break;
      case 'importNftCallback':
        final bool isSuccess = await methodCall.arguments['isSuccess'];
        if (isSuccess) {
          emit(ImportNftSuccess());
          isImportNft.sink.add(isSuccess);
        }
        if (!isSuccess) {
          isImportNftFail.sink.add(isSuccess);
        }
        break;
      case 'setShowedNftCallback':
        final bool isSetShowedNft = await methodCall.arguments['isSuccess'];
        break;
      case 'checkTokenCallback':
        final bool isExist = await methodCall.arguments['isExist'];
        isHaveToken.sink.add(isExist);
        break;
      case 'getTokensCallback':
        final List<dynamic> data = methodCall.arguments;
        for (final element in data) {
          checkShow.add(ModelToken.fromWalletCore(element));
        }
        for (final element in checkShow) {
          if (element.isShow) {
            print(element.nameShortToken);
            listTokenFromWalletCore.add(element);
          }
        }
        print('>>>>>' + listTokenFromWalletCore.length.toString());
        print(checkShow.length);
        getListTokenModel.add(checkShow);
        totalBalance.add(total(listTokenFromWalletCore));
        listTokenStream.add(listTokenFromWalletCore);
        break;

      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        for (final element in data) {
          listWallet.add(Wallet.fromJson(element));
          addressWalletCore = listWallet.first.address!;
          nameWallet = listWallet.first.name!;
          walletName.add(nameWallet);
          addressWallet.add(addressWalletCore);
        }
        break;
      case 'importListNftCallback':
        break;
      default:
        break;
    }
  }

  Future<void> earseWallet({required String walletAddress}) async {
    try {
      final data = {
        'walletAddress': walletAddress,
      };
      await trustWalletChannel.invokeMethod('earseWallet', data);
    } on PlatformException {}
  }

  Future<void> getAddressWallet() async {}

  Future<void> getListWallets(String password) async {
    try {
      final data = {
        'password': password,
      };
      await trustWalletChannel.invokeMethod('getListWallets', data);
    } on PlatformException {}
  }

  Future<void> getTokens(String walletAddress) async {
    try {
      final data = {
        'walletAddress': walletAddress,
      };
      await trustWalletChannel.invokeMethod('getTokens', data);
    } on PlatformException {}
  }

// list
  Future<void> getNFT(
    String walletAddress,
  ) async {
    try {
      final data = {
        'walletAddress': walletAddress,
      };
      await trustWalletChannel.invokeMethod('getNFT', data);
    } on PlatformException {}
  }

  Future<void> checkToken({
    required String walletAddress,
    required String tokenAddress,
  }) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'tokenAddress': tokenAddress,
      };
      await trustWalletChannel.invokeMethod('checkToken', data);
    } on PlatformException {}
  }

  Future<void> importListToken(
    String jsonTokens,
  ) async {
    try {
      final data = {
        'jsonTokens': jsonTokens,
      };
      await trustWalletChannel.invokeMethod('importListToken', data);
    } on PlatformException {}
  }

//"jsonTokens*: String
// arrayOf(
// walletAddress*: String
// tokenAddress*: String
// tokenFullName*: String
// iconUrl*: String
// symbol*: String
// decimal*: Int
// exchangeRate*: double
// )"
  Future<void> importToken({
    required String walletAddress,
    required String tokenAddress,
    required String symbol,
    required int decimal,
    required String tokenFullName,
    required String iconToken,
    required double exchangeRate,
  }) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'tokenAddress': tokenAddress,
        'symbol': symbol,
        'decimal': decimal,
        'tokenFullName': tokenFullName,
        'iconToken': iconToken,
        'exchangeRate': exchangeRate,
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
    required String walletAddress,
    required String tokenAddress,
    required bool isShow,
  }) async {
    try {
      final data = {
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
    required String walletAddress,
    required String nftAddress,
    required String collectionAddress,
    required String nftName,
    required String iconNFT,
    required int nftID,
  }) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'nftAddress': nftAddress,
        'nftName': nftName,
        'collectionAddress': collectionAddress,
        'iconNFT': iconNFT,
        'nftID': nftID,
      };
      await trustWalletChannel.invokeMethod('importNft', data);
    } on PlatformException {
      //todo

    }
  }

  Future<void> setShowedNft({
    required String walletAddress,
    required String nftAddress,
    required bool isShow,
  }) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'isShow': isShow,
        'nftAddress': nftAddress,
      };
      await trustWalletChannel.invokeMethod('setShowedNft', data);
    } on PlatformException {
      //todo

    }
  }

  ///import nft test
  ///get collection

  // Future<void> importAllNFT({
  //   required String walletAddress,
  //   required String contract,
  // }) async {
  //   final List<NftInfo> list = await getNFTFromWeb3(
  //     address: walletAddress,
  //     contract: contract,
  //   );
  //
  //   final jsonNFT = jsonEncode(
  //     list.map((e) => e.saveToJson(walletAddress: walletAddress)).toList(),
  //   );
  //   await importListNft(jsonNft: jsonNFT);
  // }

  Future<void> emitJsonNftToWalletCore({
    required String contract,
    int? id,
    required String address,
  }) async {
    Map<String, dynamic> result;
    result = await Web3Utils()
        .getCollectionInfo(contract: contract, address: address);
    await importNftIntoWalletCore(jsonNft: result.toString());
  }

  Future<CollectionNft> fetchCollection() async {
    final response = await http.get(Uri.parse(
        'https://defiforyou.mypinata.cloud/ipfs/QmQj6bT1VbwVZesexd43vvGxbCGqLaPJycdMZQGdsf6t3c'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return CollectionNft.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Collection');
    }
  }

  //get Nft
  Future<void> getInfoCollection(String smartContract, String? id) async {}



  //importAllNFT
  //todo emit json to wallet core
  // Future<void> importNFTFtAllNft({
  //   required String walletAddress,
  //   int? id,
  //   required String contract,
  // }) async {
  //   final List<CollectionNft> list = await getNFTFromWeb3(
  //     address: walletAddress,
  //     contract: contract,
  //   );
  //
  //   final jsonNFT = jsonEncode(
  //     list.map((e) => e.saveToJson(walletAddress: walletAddress)).toList(),
  //   );
  //   await importNftIntoWalletCore(jsonNft: jsonNFT);
  // }

  Future<void> isImportNftSuccess({
    required String contractAddress,
    required int id,
  }) async {
    if (await Web3Utils().importNFT(
      contract: contractAddress,
      id: id,
    )) {
      // emit(ImportNftSuccess());
    }
  }

  Future<void> importNftIntoWalletCore({
    required String jsonNft,
  }) async {
    try {
      final data = {
        'jsonNft': jsonNft,
      };
      await trustWalletChannel.invokeMethod('importListNft', data);
    } on PlatformException {
      //todo

    }
  }

  ///VALIDATE ADDRESS
  final BehaviorSubject<String> _messSubject = BehaviorSubject();

  Stream<String> get messStream => _messSubject.stream;

  void validateAddressFunc() {
    final bool isEmpty = isTextTokenEnterAddress.value;
    if (isEmpty) {
      final bool isValidate = isAddressNotExist.value;
      if (!isValidate) {
        final bool isImported = isHaveToken.value;
        if (isImported) {
          isTokenEnterAddress.sink.add(false);
          _messSubject.sink.add('The token had been imported');
        } else {
          _messSubject.sink.add('');
          isTokenEnterAddress.sink.add(true);
        }
      } else {
        isTokenEnterAddress.sink.add(false);

        _messSubject.sink.add('The address not available');
      }
    } else {
      isTokenEnterAddress.sink.add(false);
      _messSubject.sink.add('The address must be enter');
    }
  }
}
