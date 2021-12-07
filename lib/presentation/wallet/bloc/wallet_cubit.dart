import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
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

part 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  WalletCubit() : super(WalletInitial()) {}

  ///web3
  Web3Utils client = Web3Utils();

  Future<void> getTokenInfoByAddress({required String tokenAddress}) async {
    final TokenInfoModel tokenInfoModel =
        await client.getTokenInfo(contractAddress: tokenAddress);
    tokenSymbol.sink.add(tokenInfoModel.tokenSymbol ?? 'null');
    tokenDecimal.sink.add('${tokenInfoModel.decimal ?? 0} ');
    tokenFullName = tokenInfoModel.name ?? '';
    // iconToken = tokenInfoModel.icon ?? '';
    if (tokenInfoModel.tokenSymbol!.isNotEmpty) {
      isTokenEnterAddress.sink.add(true);
    }
    if (tokenInfoModel.tokenSymbol!.isEmpty) {
      isTokenEnterAddress.sink.add(false);
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
  Future<void> getNftInfoByAddress(
      {required String nftAddress, int? enterId}) async {
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

  String tokenFullName = '';
  String iconToken = 'https://assets.coingecko.com/coins/images/825/thumb/binance-coin-logo.png?1547034615';
  bool checkLogin = false;
  List<TokenModel> listStart = [];
  List<Wallet> listWallet = [];
  List<ModelToken> listTokenFromWalletCore = [];
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
  BehaviorSubject<bool> isTokenEnterAddress = BehaviorSubject.seeded(false);

  BehaviorSubject<bool> isImportNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isImportNftFail = BehaviorSubject.seeded(true);
  BehaviorSubject<bool> isNFT = BehaviorSubject.seeded(true);
  BehaviorSubject<List<TokenModel>> getListTokenModel =
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

  void getIsWalletName(String value) {
    if (Validator.validateNotNull(value)) {
      isWalletName.sink.add(true);
    } else {
      isWalletName.sink.add(false);
    }
  }

  //Web3
  TokenRepository get _tokenRepository => Get.find();
  Future<void> getListCategory() async {
    final Result<List<TokenInf>> result = await _tokenRepository.getListToken();
    result.when(
      success: (res) {
        //todo: Import to wallet core
      },
      error: (error) {
        updateStateError();
      },
    );
  }

  Future<void> getExchangeRate(List<ModelToken> list) async {
    ///TODO: function get ExchangeRate
    for (int i = 0; i < list.length; i++) {
      list[i].exchangeRate = 12;
      list[i].balanceToken = await client.getBalanceOfToken(
        ofAddress: addressWalletCore,
        tokenAddress: list[i].tokenAddress,
      );
    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'importTokenCallback':
        final bool isSuccess = await methodCall.arguments['isSuccess'];
        print(isSuccess);
        if (isSuccess) {
          emit(NavigatorSuccessfully());
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
          isImportNft.sink.add(isSuccess);
        }
        if (!isSuccess) {
          isImportNftFail.sink.add(isSuccess);
        }
        break;
      case 'setShowedNftCallback':
        final bool isSetShowedNft = await methodCall.arguments['isSuccess'];
        break;
      case 'getTokensCallback':
        final List<ModelToken> checkShow = [];
        final List<dynamic> data = methodCall.arguments;
        for (final element in data) {
          checkShow.add(ModelToken.fromWalletCore(element));
        }
        for (final element in checkShow) {
          if (element.isShow) {
            listTokenFromWalletCore.add(element);
          }
        }
        await getExchangeRate(listTokenFromWalletCore);
        total(listTokenFromWalletCore);
        listTokenStream.add(listTokenFromWalletCore);
        break;
      case 'getNFTCallback':
        final List<dynamic> data = methodCall.arguments;
        for (final element in data) {
          listNftFromWalletCore.add(NftModel.fromWalletCore(element));
        }
        listNFTStream.sink.add(listNftFromWalletCore);
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
      default:
        break;
    }
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
//"walletAddress*: String
// tokenAddress*: String
// tokenFullName*: String
// iconUrl*: String
// symbol*: String
// decimal*: Int"
  Future<void> importToken({
    required String walletAddress,
    required String tokenAddress,
    required String symbol,
    required int decimal,
    required String tokenFullName,
    required String iconUrl,
  }) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'tokenAddress': tokenAddress,
        'symbol': symbol,
        'decimal': decimal,
        'tokenFullName': tokenFullName,
        'iconUrl': iconUrl,
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
    required String nftName,
    required String iconNFT,
    required int nftID,
  }) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'nftAddress': nftAddress,
        'nftName': nftName,
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
}
