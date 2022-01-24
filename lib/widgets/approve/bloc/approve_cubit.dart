import 'dart:convert';
import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/request/bid_nft_request.dart';
import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/domain/repository/market_place/confirm_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/presentation/put_on_market/model/nft_put_on_market_model.dart';
import 'package:Dfy/widgets/approve/bloc/approve_state.dart';
import 'package:Dfy/widgets/approve/extension/call_core_logic_extention.dart';
import 'package:Dfy/widgets/approve/extension/common_extension.dart';
import 'package:Dfy/widgets/approve/extension/get_gas_limit_extension.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

enum TYPE_CONFIRM_BASE {
  SEND_NFT,
  SEND_TOKEN,
  BUY_NFT,
  PUT_ON_SALE,
  PUT_ON_PAWN,
  PUT_ON_AUCTION,
  SEND_OFFER,
  PLACE_BID,
  CANCEL_SALE,
  CREATE_COLLECTION,
}

class ApproveCubit extends BaseCubit<ApproveState> {
  ApproveCubit() : super(ApproveInitState());
  late final NftMarket nftMarket;
  TYPE_CONFIRM_BASE type = TYPE_CONFIRM_BASE.BUY_NFT;

  List<Wallet> listWallet = [];

  /// Name current wallet , after load screen success [nameWallet] have data
  /// when fail [nameWallet] is null
  /// [nameWallet] get in core
  String? nameWallet;

  /// address current wallet ,after load screen success [addressWallet] have data
  /// when fail [addressWallet] is null
  /// [addressWallet] get in core
  String? addressWallet;

  /// balance current wallet , after load screen success [balanceWallet] have data
  /// when fail [balanceWallet] is null
  /// [balanceWallet] get in web3
  double? balanceWallet;

  /// balance current wallet , after load screen success [gasPriceFirst] have data
  /// when fail [gasPriceFirst] is null
  /// this is min value of gas price
  /// [balanceWallet] get in web3
  double? gasPriceFirst;

  late BuildContext context;

  double? gasLimit;

  double? gasLimitFirst;

  double? gasPrice;

  String? rawData;

  String? hexString;

  ConfirmRepository get confirmRepository => Get.find();

  bool needApprove = false;

  String? payValue;

  String? tokenAddress;

  bool checkingApprove = false;

  String? tokenApproveData;

  PutOnMarketModel? putOnMarketModel;

  bool isSoftCollection = false;


  final Web3Utils web3Client = Web3Utils();
  final BehaviorSubject<String> addressWalletCoreSubject =
      BehaviorSubject<String>();
  final BehaviorSubject<String> nameWalletSubject = BehaviorSubject<String>();
  final BehaviorSubject<double> balanceWalletSubject =
      BehaviorSubject<double>();

  /// [gasPriceSubject] contain gas price init, not gas price final
  final BehaviorSubject<double> gasPriceFirstSubject =
      BehaviorSubject<double>();

  final BehaviorSubject<double> gasLimitFirstSubject =
      BehaviorSubject<double>();

  final BehaviorSubject<bool> canActionSubject = BehaviorSubject.seeded(false);

  final BehaviorSubject<bool> isApprovedSubject = BehaviorSubject<bool>();

  Stream<String> get addressWalletCoreStream => addressWalletCoreSubject.stream;

  Stream<String> get nameWalletStream => nameWalletSubject.stream;

  Stream<bool> get isApprovedStream => isApprovedSubject.stream;

  Stream<double> get balanceWalletStream => balanceWalletSubject.stream;

  Stream<bool> get canActionStream => canActionSubject.stream;

  Stream<double> get gasPriceFirstStream => gasPriceFirstSubject.stream;

  Stream<double> get gasLimitFirstStream => gasLimitFirstSubject.stream;

  Future<Map<String, dynamic>> sendRawData(String rawData) async {
    final result = await web3Client.sendRawTransaction(transaction: rawData);
    return result;
  }

  Future<bool> checkApprove({
    required String payValue,
    required String tokenAddress,
  }) async {
    bool response = false;
    try {
      if (payValue !='' && tokenAddress != '' && addressWallet != ''){
      final result = await web3Client.isApproved(
        payValue: payValue,
        tokenAddress: tokenAddress,
        walletAddres: addressWallet ?? '',
        spenderAddress: getSpender(),
      );
      isApprovedSubject.sink.add(result);
      response = result;
      }else{
        AppException('title', S.current.error);
      }
    } on PlatformException {
      isApprovedSubject.sink.add(false);
      showError();
      response = false;
    }
    return response;
  }

  NFTRepository get nftRepo => Get.find();

  Future<void> buyNftRequest(BuyNftRequest buyNftRequest) async {
    showLoading();
    final result = await nftRepo.buyNftRequest(buyNftRequest);
    result.when(
      success: (res) {
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> bidNftRequest(BidNftRequest bidNftRequest) async {
    showLoading();
    final result = await nftRepo.bidNftRequest(bidNftRequest);
    result.when(
      success: (res) {
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> emitJsonNftToWalletCore({
    required String contract,
    required int id,
    required String address,
  }) async {
    final result = await web3Client.getCollectionInfo(
        contract: contract, address: address, id: id);
    await importNftIntoWalletCore(
      jsonNft: json.encode(result),
      address: address,
    );
  }

  Future<void> gesGasLimitFirst(String hexString,{BuildContext? buildContext}) async {
    showLoading();
    try {
      final gasLimitFirstResult =
          await getGasLimitByType( hexString: hexString);
      gasLimitFirst = gasLimitFirstResult;
      gasLimit = gasLimitFirstResult;
      gasLimitFirstSubject.sink.add(gasLimitFirstResult);
      gasPrice = gasPriceFirst;
      showContent();
    } catch (_) {
      showError();
    }
  }

  Future<void> approve() async {
    final nonce =
        await web3Client.getTransactionCount(address: addressWallet ?? '');
    await signTransactionWithData(
      gasLimit: (gasLimit ?? 0).toInt().toString(),
      gasPrice: ((gasPrice ?? 0) / 1e9).toInt().toString(),
      chainId: Get.find<AppConstants>().chaninId,
      contractAddress: tokenAddress ?? '',
      walletAddress: addressWallet ?? '',
      nonce: nonce.count.toString(),
      hexString: tokenApproveData ?? '',
    );
  }


  int randomAvatar() {
    final Random rd = Random();
    return rd.nextInt(10);
  }

  Future<void> getGasPrice() async {
    try {
      final result = await Web3Utils().getGasPrice();
      gasPriceFirstSubject.sink.add(double.parse(result));
      gasPriceFirst = double.parse(result);
      gasPrice = double.parse(result);
    } catch (e) {
      showError();
      AppException('title', e.toString());
    }
  }



  Future<void> importNft({
    required String contract,
    required String address,
    required int id,
  }) async {
    final res = await web3Client.importNFT(
        contract: contract, address: address, id: id);
    if (!res.isSuccess) {
    } else {
      await emitJsonNftToWalletCore(
        contract: contract,
        address: address,
        id: id,
      );
    }
  }

  void dispose() {
    gasPriceFirstSubject.close();
    addressWalletCoreSubject.close();
    balanceWalletSubject.close();
    nameWalletSubject.close();
    isApprovedSubject.close();
  }
}
