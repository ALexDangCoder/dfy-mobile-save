import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';

class NFTDetailBloc extends BaseCubit<NFTDetailState> {
  NFTDetailBloc() : super(NFTDetailInitial()) {
    showLoading();
  }

  final _viewSubject = BehaviorSubject.seeded(true);

  Stream<bool> get viewStream => _viewSubject.stream;

  Sink<bool> get viewSink => _viewSubject.sink;

  final BehaviorSubject<List<HistoryNFT>> listHistoryStream =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<List<OwnerNft>> listOwnerStream =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<List<BiddingNft>> listBiddingStream =
      BehaviorSubject.seeded([]);

  String symbolToken = '';

  ///GetHistory
  NFTRepository get _nftRepo => Get.find();

  Future<void> getHistory(String collectionAddress, String nftTokenId) async {
    final Result<List<HistoryNFT>> result =
        await _nftRepo.getHistory(collectionAddress, nftTokenId);
    result.when(
      success: (res) {
        listHistoryStream.add(res);
      },
      error: (error) {
        updateStateError();
      },
    );
  }

  ///GetOwner
  Future<void> getOwner(String collectionAddress, String nftTokenId) async {
    final Result<List<OwnerNft>> result =
        await _nftRepo.getOwner(collectionAddress, nftTokenId);
    result.when(
      success: (res) {
        listOwnerStream.add(res);
      },
      error: (error) {
        updateStateError();
      },
    );
  }

  ///GetBiding
  Future<void> getBidding(String auctionId) async {
    final Result<List<BiddingNft>> result =
        await _nftRepo.getBidding(auctionId);
    result.when(
      success: (res) {
        listBiddingStream.add(res);
      },
      error: (error) {
        updateStateError();
      },
    );
  }

  ///GetInfoNft

  Future<void> getInForNFT(String marketId, MarketType type) async {
    showLoading();
    getTokenInf();
    if (type == MarketType.SALE) {
      showLoading();
      final Result<NftMarket> result =
          await _nftRepo.getDetailNftOnSale(marketId);
      result.when(
        success: (res) {
          for (final value in listTokenSupport) {
            final tokenBuyOut = res.tokenBuyOut ?? '';
            final address = value.address ?? '';
            if (tokenBuyOut.toLowerCase() == address.toLowerCase()) {
              res.urlToken = value.iconUrl;
              res.symbolToken = value.symbol;
              res.usdExchange = value.usdExchange;
            }
          }
          showContent();
          emit(NftOnSaleSuccess(res));
          getHistory(res.collectionAddress ?? '', res.nftTokenId ?? '');
          getOwner(res.collectionAddress ?? '', res.nftTokenId ?? '');
        },
        error: (error) {
          updateStateError();
        },
      );
    }
    if (type == MarketType.AUCTION) {
      showLoading();
      final Result<NFTOnAuction> result =
          await _nftRepo.getDetailNFTAuction(marketId);
      result.when(
        success: (res) {
          for (final value in listTokenSupport) {
            final tokenBuyOut = res.token ?? '';
            final address = value.address ?? '';
            if (tokenBuyOut.toLowerCase() == address.toLowerCase()) {
              res.urlToken = value.iconUrl;
              res.tokenSymbol = value.symbol;
              res.usdExchange = value.usdExchange;
              symbolToken = value.symbol ?? '';
            }
          }
          showContent();
          emit(NftOnAuctionSuccess(res));
          getHistory(res.collectionAddress ?? '', res.nftTokenId ?? '');
          getOwner(res.collectionAddress ?? '', res.nftTokenId ?? '');
          getBidding(res.auctionId.toString());
        },
        error: (error) {
          updateStateError();
        },
      );
    }
    if (type == MarketType.PAWN) {
      ///call api detail onPawn
    }
  }

  ///getListTokenSupport

  List<TokenInf> listTokenSupport = [];

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
  }

  int getTimeCountDown(NFTOnAuction nftOnAuction) {
    final endDate =
        DateTime.fromMillisecondsSinceEpoch(nftOnAuction.endTime ?? 0);
    final today = DateTime.now().millisecondsSinceEpoch;
    if (endDate.millisecondsSinceEpoch > today) {
      return endDate.microsecondsSinceEpoch - today;
    } else {
      return 0;
    }
  }

  //////////////////////
  ///CANCEL SALE

  String dataString = '';
  String walletAddress = '';
  double gasLimit = 0;

  List<DetailItemApproveModel> initListApprove() {
    List<DetailItemApproveModel> listApprove = [
      DetailItemApproveModel(title: 'NTF', value: 'Ối dồi ôi'),
      DetailItemApproveModel(title: S.current.quantity, value: '10')
    ];
    return listApprove;
  }

  //get limit gas
  final Web3Utils web3utils = Web3Utils();

  //get dataString
  Future<void> getDataString({
    required BuildContext context,
    required String orderId,
    required String walletAddress,
  }) async {
    try {
      dataString = await web3utils.getCancelListingData(
        contractAddress: nft_sales_address_dev2,
        orderId: orderId,
        context: context,
      );
    } catch (e) {
      throw e;
    }
  }

  //get gas limit by  data
  Future<void> getGasLimit({
    required String walletAddress,
  }) async {
    try {
      gasLimit = double.parse(
        await web3utils.getGasLimitByData(
          from: walletAddress,
          toContractAddress: nft_sales_address_dev2,
          dataString: dataString,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  //ký giao dịch qua core

  //handle core callback:
  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'signTransactionWithDataCallback':
        bool isSuccess = await methodCall.arguments['isSuccess'];
        break;
      default:
        break;
    }
  }

  AppConstants get appConstant => Get.find();

  //call tới core
  Future<void> signTransactionWithData({
    required String walletAddress,
    required String gasPrice,
    required String gasLimit,
    required String withData,
  }) async {
    try {
      final TransactionCountResponse transaction =
          await web3utils.getTransactionCount(address: walletAddress);
      if (!transaction.isSuccess) {
        return;
      }
      final data = {
        'walletAddress': walletAddress,
        'contractAddress': nft_sales_address_dev2,
        'nonce': transaction.count.toString(),
        'chainId': appConstant.chaninId,
        'gasPrice': gasPrice,
        'gasLimit': gasLimit,
        'withData': withData,
      };

      await trustWalletChannel.invokeMethod('signTransactionWithData', data);
    } on PlatformException catch (e) {
      //
      throw e;
    }
  }

  //cancel sale:
  Future<Map<String, dynamic>> cancelSale({required String transaction}) async {
    final Map<String, dynamic> res =
        await web3utils.sendRawTransaction(transaction: transaction);
    return res;
  }
}
