import 'dart:async';
import 'dart:convert';
import 'dart:math' hide log;

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/model/collection_nft_info.dart';
import 'package:Dfy/data/web3/model/nft_info_model.dart';
import 'package:Dfy/data/web3/model/token_info_model.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/account_model.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/token.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/model/token_price_model.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/domain/repository/price_repository.dart';
import 'package:Dfy/domain/repository/token_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

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
  bool isHaveToken = true;

  Future<void> getTokenInfoByAddress({required String tokenAddress}) async {
    final TokenInfoModel? tokenInfoModel =
        await client.getTokenInfo(contractAddress: tokenAddress);
    if (tokenInfoModel != null) {
      tokenSymbol.sink.add(tokenInfoModel.tokenSymbol ?? 'null');
      tokenDecimal.sink.add('${tokenInfoModel.decimal ?? 0} ');
      tokenFullName = tokenInfoModel.name ?? '';
      if (tokenInfoModel.tokenSymbol!.isNotEmpty) {
        isTokenEnterAddress.sink.add(true);
        if (isHaveToken) {
          isTokenEnterAddress.sink.add(false);
        }
      }
      if (tokenInfoModel.tokenSymbol!.isEmpty) {
        isTokenEnterAddress.sink.add(false);
      }
      isAddressNotExist = false;
    }
    if (tokenInfoModel == null) {
      isAddressNotExist = true;
    }
  }

  Future<String> getIcon(String addressToken) async {
    for (final ModelToken value in checkShow) {
      if (addressToken == value.tokenAddress) {
        return value.iconToken;
      }
    }
    return '';
  }

  String nftName = '';
  String iconNFT = '';

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

  Future<void> getListWallet({
    required String addressWallet,
  }) async {
    for (final Wallet value in listWallet) {
      final double balanceOfBnb = await getWalletDetail(
        walletAddress: value.address ?? '',
      );
      if (addressWallet == value.address) {
        final AccountModel acc = AccountModel(
          isCheck: true,
          addressWallet: value.address,
          amountWallet: balanceOfBnb,
          imported: value.isImportWallet,
          nameWallet: value.name,
          url: '${ImageAssets.image_avatar}${randomAvatar()}'
              '.png',
        );
        listSelectAccBloc.add(acc);
      } else {
        final AccountModel acc = AccountModel(
          isCheck: false,
          addressWallet: value.address,
          amountWallet: balanceOfBnb,
          imported: value.isImportWallet,
          nameWallet: value.name,
          url: '${ImageAssets.image_avatar}${randomAvatar()}'
              '.png',
        );
        listSelectAccBloc.add(acc);
      }
    }
    getListAcc();
  }

  int randomAvatar() {
    final Random rd = Random();

    return rd.nextInt(10);
  }

  bool checkWalletExist = false;

  final List<ModelToken> checkShow = [];
  String tokenFullName = '';
  bool checkLogin = false;
  List<TokenModel> listStart = [];
  List<Wallet> listWallet = [];
  List<ModelToken> listTokenFromWalletCore = [];
  List<ModelToken> listTokenImport = [];
  List<CollectionNft> listNftFromWalletCore = [];
  BehaviorSubject<List<ModelToken>> listTokenStream =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<CollectionNft>> listNFTStream =
      BehaviorSubject.seeded([]);
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

  bool isAddressNotExist = false;

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
  double? price = 0.0;

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
    _messSubject.sink.add('');
    isAddressNotExist = false;
    isHaveToken = true;
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

  PriceRepository get _priceRepository => Get.find();
  List<TokenPrice> listTokenExchange = [];

  Future<void> getListPrice(String symbols) async {
    final Result<List<TokenPrice>> result =
        await _priceRepository.getListPriceToken(symbols);
    result.when(
      success: (res) {
        if (res.isEmpty) {
          price = 0;
        } else {
          price = res.first.price ?? 0.0;
          for (final element in res) {
            listTokenExchange.add(element);
          }
        }
      },
      error: (error) {
        updateStateError();
      },
    );
  }

  Future<void> getListCategory() async {
    final Result<List<TokenInf>> result = await _tokenRepository.getListToken();
    result.when(
      success: (res) {
        getTokenInfoByAddressList(res: res);
      },
      error: (error) {
        getTokens(addressWalletCore);
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

  Stream<dynamic> getListDynamic(List<dynamic> listModelToken) async* {
    for (int i = 0; i < listModelToken.length; i++) {
      yield listModelToken[i];
    }
  }

  Future<void> getTokenInfoByAddressList({
    required List<TokenInf> res,
  }) async {
    final List<ModelToken> listJson = [];
    for (final value in res) {
      getListModelToken.add(
        ModelToken(
          tokenAddress: value.address ?? '',
          iconToken: value.iconUrl ?? '',
          nameShortToken: value.symbol ?? '',
          nameToken: value.name ?? '',
          exchangeRate: value.usdExchange ?? 0,
          walletAddress: addressWalletCore,
          decimal: 18,
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
          decimal: 18,
        ),
      );
    }
    final json = jsonEncode(listJson.map((e) => e.toJson()).toList());
    await importListToken(json);
  }

  Future<void> getExchangeRateFromServer(List<ModelToken> list) async {
    final query = StringBuffer();
    for (final value in list) {
      query.write('${value.nameShortToken},');
    }
    await getListPrice(query.toString());
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < listTokenExchange.length; j++) {
        if (list[i].nameShortToken ==
            listTokenExchange[j].tokenSymbol!.toUpperCase()) {
          list[i].exchangeRate = listTokenExchange[j].price ?? 0;
        }
      }
    }
  }

  Future<void> getBalanceOFToken(List<ModelToken> list) async {
    await for (final value in getTokenRealtime(list)) {
      if (value.nameShortToken != 'BNB') {
        value.balanceToken = await client.getBalanceOfToken(
          ofAddress: addressWalletCore,
          tokenAddress: value.tokenAddress,
        );
      } else {
        value.balanceToken = await client.getBalanceOfBnb(
          ofAddress: addressWalletCore,
        );
      }
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
        }
        break;
      case 'earseWalletCallback':
        bool isSuccess = await methodCall.arguments['isSuccess'];
        print('---------------------------------------------$isSuccess');
        break;
      case 'getListSupportedTokenCallback':
        break;
      case 'setShowedTokenCallback':
        // isSetShowedToken = await methodCall.arguments['isSuccess'];
        break;
      case 'importNftCallback':
        final bool isSuccess = await methodCall.arguments['isSuccess'];
        if (isSuccess) {
          emit(ImportNftSuccess());
        } else {
          emit(ImportNftFail());
        }
        break;
      case 'setShowedNftCallback':
        final bool isSetShowedNft = await methodCall.arguments['isSuccess'];
        break;
      case 'checkTokenCallback':
        isHaveToken = await methodCall.arguments['isExist'];
        if (isHaveToken) {
          isTokenEnterAddress.sink.add(false);
          _messSubject.sink.add(S.current.already_exist);
        } else {
          _messSubject.sink.add('');
          isTokenEnterAddress.sink.add(true);
        }
        break;
      case 'changeNameWalletCallBack':
        final bool isSuccess = await methodCall.arguments['isSuccess'];
        print(
            '-------asdf-------------------------------------------------------------$isSuccess');
        break;
      case 'getTokensCallback':
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
        await getExchangeRateFromServer(listTokenFromWalletCore);
        totalBalance.add(total(listTokenFromWalletCore));
        getListTokenModel.add(checkShow);
        listTokenStream.add(listTokenFromWalletCore);
        break;

      case 'getListWalletsCallback':
        listSelectAccBloc.clear();
        final List<dynamic> data = methodCall.arguments;
        for (final element in data) {
          listWallet.add(Wallet.fromJson(element));
        }
        getWalletDetailInfo();
        addressWallet.add(addressWalletCore);
        break;
      case 'getNFTCallback':
        final List<dynamic> data = methodCall.arguments;
        final List<CollectionNft> listCollectionNFT = [];
        for (final element in data) {
          listCollectionNFT.add(CollectionNft.fromJson(element));
        }
        //todo HUY
        break;
      case 'importListNftCallback':
        break;
      case 'getConfigCallback':
        checkWalletExist = methodCall.arguments['isWalletExist'];
        if (checkWalletExist) {
          listTokenFromWalletCore.clear();
          await getTokens(addressWalletCore);
        }
        break;
      default:
        break;
    }
  }

  int indexWallet = 0;

  void getWalletDetailInfo() {
    addressWalletCore = listWallet[indexWallet].address!;
    nameWallet = listWallet[indexWallet].name!;
    walletName.add(nameWallet);
  }

  Future<void> getConfig() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getConfig', data);
    } on PlatformException {}
  }

  Future<void> changeNameWallet({
    required String walletAddress,
    required String walletName,
  }) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'walletName': walletName,
      };
      await trustWalletChannel.invokeMethod('changeNameWallet', data);
    } on PlatformException {}
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

  Future<void> getListWallets() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getListWallets', data);
    } on PlatformException {
      //nothing
    }
  }

  Future<void> getTokens(String walletAddress) async {
    try {
      final data = {
        'walletAddress': walletAddress,
      };
      await trustWalletChannel.invokeMethod('getTokens', data);
    } on PlatformException {
      //nothing
    }
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
    Map<String, dynamic> result = {};
    result = await Web3Utils()
        .getCollectionInfo(contract: contract, address: address);
    // result.putIfAbsent('walletAddress', () => address);
    await importNftIntoWalletCore(
      jsonNft: json.encode(result),
      address: address,
    );
  }

  Future<CollectionNft> fetchCollection() async {
    final response = await http.get(Uri.parse(
        'https://defiforyou.mypinata.cloud/ipfs/QmQj6bT1VbwVZesexd43vvGxbCGqLaPJycdMZQGdsf6t3c'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return CollectionNft.fromJsonMap(jsonDecode(response.body));
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
    required String address,
  }) async {
    try {
      final data = {
        'jsonNft': jsonNft,
        'walletAddress': address,
      };
      await trustWalletChannel.invokeMethod('importNft', data);
    } on PlatformException {
      //todo

    }
  }

  Future<NftInfo> fetchNft({required String url}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return NftInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Nft');
    }
  }

  ///VALIDATE ADDRESS
  final BehaviorSubject<String> _messSubject = BehaviorSubject();

  Stream<String> get messStream => _messSubject.stream;

  final BehaviorSubject<String> _inputSubject = BehaviorSubject();

  Stream<String> get inputStream => _inputSubject.stream;
  Timer? debounceTime;

  void validateAddressFunc(String _st) {
    if (debounceTime != null) {
      if (debounceTime!.isActive) {
        debounceTime!.cancel();
      }
    }
    if (_st != '') {
      trustWalletChannel.setMethodCallHandler(nativeMethodCallBackTrustWallet);
      debounceTime = Timer(
        const Duration(milliseconds: 500),
        () async {
          await getTokenInfoByAddress(tokenAddress: _st);
          if (!isAddressNotExist) {
            await checkToken(
                walletAddress: addressWalletCore, tokenAddress: _st);
          } else {
            isTokenEnterAddress.sink.add(false);
            tokenSymbol.sink.add(S.current.token_symbol);
            tokenDecimal.sink.add(S.current.token_decimal);
            _messSubject.sink.add(S.current.invalid_address);
          }
        },
      );
    } else {
      isTokenEnterAddress.sink.add(false);
      _messSubject.sink.add(S.current.empty_address);
    }
  }
}
