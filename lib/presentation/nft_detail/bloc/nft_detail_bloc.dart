import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/nft_on_pawn.dart';
import 'package:Dfy/domain/model/offer_nft.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class NFTDetailBloc extends BaseCubit<NFTDetailState> {
  NFTDetailBloc() : super(NFTDetailInitial());

  final _viewSubject = BehaviorSubject.seeded(true);
  final _pairSubject = BehaviorSubject<bool>();
  final Web3Utils web3Client = Web3Utils();
  double balance = 0;
  String hexString = '';
  String gasLimit = '';
  String rawData = '';
  int quantity = 0;
  double totalPayment = 0;
  double bidValue = 0;

  NFTRepository get _nftRepo => Get.find();

  late NftMarket nftMarket;
  late NFTOnAuction nftOnAuction;
  late final String owner;
  List<Wallet> wallets = [];

  late final String walletAddress;

  Stream<bool> get viewStream => _viewSubject.stream;

  Sink<bool> get viewSink => _viewSubject.sink;

  final BehaviorSubject<List<HistoryNFT>> listHistoryStream = BehaviorSubject();
  final BehaviorSubject<List<OwnerNft>> listOwnerStream = BehaviorSubject();
  final BehaviorSubject<List<BiddingNft>> listBiddingStream = BehaviorSubject();
  final BehaviorSubject<List<OfferDetail>> listOfferStream = BehaviorSubject();
  final BehaviorSubject<Evaluation> evaluationStream = BehaviorSubject();

  String symbolToken = '';

  ///GetHistory
  Stream<bool> get pairStream => _pairSubject.stream;

  Sink<bool> get pairSink => _pairSubject.sink;

  Future<void> getHistory({
    required String collectionAddress,
    required String nftTokenId,
  }) async {
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
        showContent();
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
        showContent();
      },
    );
  }

  ///GetOffer
  Future<void> getOffer(String collateralId) async {
    final Result<List<OfferDetail>> result =
        await _nftRepo.getOffer(collateralId);
    result.when(
      success: (res) {
        listOfferStream.add(res);
      },
      error: (error) {
        showContent();
      },
    );
  }

  ///GetEvaluation
  Future<void> getEvaluation(String evaluationId) async {
    final Result<Evaluation> result =
        await _nftRepo.getEvaluation(evaluationId);
    result.when(
      success: (res) {
        for (int i = 0; i < listTokenSupport.length; i++) {
          if (res.evaluatedSymbol == listTokenSupport[i].symbol) {
            res.urlToken = listTokenSupport[i].iconUrl;
          }
        }
        evaluationStream.add(res);
      },
      error: (error) {
        showContent();
      },
    );
  }

  ///GetInfoNft

  Future<void> getInForNFT({
    required String marketId,
    required MarketType type,
    required TypeNFT typeNFT,
    required String nftId,
    required int pawnId,
    required String collectionAddress,
    required String nftTokenId,
  }) async {
    getTokenInf();
    if (type == MarketType.NOT_ON_MARKET) {
      showLoading();
      final Result<NftMarket> result;
      if (typeNFT == TypeNFT.SOFT_NFT) {
        result = await _nftRepo.getDetailNftMyAccNotOnMarket(nftId, '0');
      } else {
        result = await _nftRepo.getDetailHardNftNotOnMarket(
          collectionAddress,
          nftTokenId,
        );
      }
      result.when(
        success: (res) {
          final String wallet = PrefsService.getCurrentBEWallet();
          if (res.walletAddress?.toLowerCase() == wallet.toLowerCase()) {
            res.isOwner = true;
          } else {
            res.isOwner = false;
          }
          showContent();
          emit(NftNotOnMarketSuccess(res));
          getHistory(
            collectionAddress: res.collectionAddress ?? '',
            nftTokenId: res.nftTokenId ?? '',
          );
          getOwner(res.collectionAddress ?? '', res.nftTokenId ?? '');
          if (typeNFT == TypeNFT.HARD_NFT) {
            getEvaluation(res.evaluationId ?? '');
          }
          for (final value in listTokenSupport) {
            final symbolToken = res.symbolToken ?? '';
            final symbol = value.symbol ?? '';
            if (symbolToken.toLowerCase() == symbol.toLowerCase()) {
              res.urlToken = value.iconUrl;
              res.symbolToken = value.symbol;
              res.usdExchange = value.usdExchange;
            }
          }
        },
        error: (error) {
          showError();
        },
      );
    }
    if (type == MarketType.SALE) {
      showLoading();
      final Result<NftMarket> result;
      if (typeNFT == TypeNFT.SOFT_NFT) {
        result = await _nftRepo.getDetailNftOnSale(marketId);
      } else {
        result = await _nftRepo.getDetailHardNftOnSale(nftId);
      }
      result.when(
        success: (res) {
          showContent();
          emit(NftOnSaleSuccess(res));
          getHistory(
            collectionAddress: res.collectionAddress ?? '',
            nftTokenId: res.nftTokenId ?? '',
          );
          getOwner(res.collectionAddress ?? '', res.nftTokenId ?? '');
          if (typeNFT == TypeNFT.HARD_NFT) {
            getEvaluation(res.evaluationId ?? '');
          }
          for (final value in listTokenSupport) {
            final tokenBuyOut = res.tokenBuyOut ?? '';
            final address = value.address ?? '';
            if (tokenBuyOut.toLowerCase() == address.toLowerCase()) {
              res.urlToken = value.iconUrl;
              res.symbolToken = value.symbol;
              res.usdExchange = value.usdExchange;
            }
          }
        },
        error: (error) {
          showError();
        },
      );
    }
    if (type == MarketType.AUCTION) {
      showLoading();
      final Result<NFTOnAuction> result;
      if (typeNFT == TypeNFT.SOFT_NFT) {
        result = await _nftRepo.getDetailNFTAuction(marketId);
      } else {
        result = await _nftRepo.getDetailHardNftOnAuction(nftId);
      }
      result.when(
        success: (res) {
          showContent();
          nftOnAuction = res;
          emit(NftOnAuctionSuccess(res));
          if (typeNFT == TypeNFT.HARD_NFT) {
            getEvaluation(res.evaluationId ?? '');
          }
          getHistory(
            collectionAddress: res.collectionAddress ?? '',
            nftTokenId: res.nftTokenId ?? '',
          );
          getOwner(res.collectionAddress ?? '', res.nftTokenId ?? '');
          getBidding(res.id.toString());
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
        },
        error: (error) {
          showError();
        },
      );
    }
    if (type == MarketType.PAWN) {
      showLoading();
      final Result<NftOnPawn> result =
          await _nftRepo.getDetailNftOnPawn(pawnId.toString());
      result.when(
        success: (res) {
          final String wallet = PrefsService.getCurrentBEWallet();
          if (res.walletAddress?.toLowerCase() == wallet.toLowerCase()) {
            res.isYou = true;
          } else {
            res.isYou = false;
          }
          getOffer(pawnId.toString());
          for (final value in listTokenSupport) {
            final tokenBuyOut = res.expectedCollateralSymbol ?? '';
            final symbol = value.symbol ?? '';
            if (tokenBuyOut.toLowerCase() == symbol.toLowerCase()) {
              res.urlToken = value.iconUrl;
              res.usdExchange = value.usdExchange;
              res.repaymentAsset = value.address;
            }
          }
          emit(NftOnPawnSuccess(res));
          if (typeNFT == TypeNFT.HARD_NFT) {
            getEvaluation(
              res.nftCollateralDetailDTO?.evaluationId ?? '',
            );
          }
          getHistory(
            collectionAddress:
                res.nftCollateralDetailDTO?.collectionAddress ?? '',
            nftTokenId: res.nftCollateralDetailDTO?.nftTokenId.toString() ?? '',
          );
          getOwner(
            res.nftCollateralDetailDTO?.collectionAddress ?? '',
            res.nftCollateralDetailDTO?.nftTokenId.toString() ?? '',
          );
          showContent();
        },
        error: (error) {
          showError();
        },
      );
    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        if (data.isEmpty) {
          pairSink.add(true);
        } else {
          for (final element in data) {
            wallets.add(Wallet.fromJson(element));
          }
          walletAddress = wallets.first.address ?? '';
          //todo: sau khi có login cần sửa
          if (wallets.first.address?.toLowerCase() == owner.toLowerCase()) {
            pairSink.add(false);
          } else {
            pairSink.add(true);
          }
        }
        return walletAddress;
      default:
        break;
    }
  }

  Future<int> getNonceWeb3() async {
    final String walletAddress = PrefsService.getCurrentBEWallet();
    final result = await web3Client.getTransactionCount(address: walletAddress);
    return result.count;
  }

  Future<void> getListWallets() async {
    try {
      await trustWalletChannel.invokeMethod('getListWallets', {});
    } on PlatformException {
      showError();
    }
  }

  ///getListTokenSupport

  List<TokenInf> listTokenSupport = [];

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
  }

  int dayOfMonth(int month, int year) {
    switch (month) {
      case 2:
        if (year % 4 == 0) {
          return 29;
        } else {
          return 28;
        }
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      default:
        return 31;
    }
  }

  int getTimeCountDown(int time) {
    int secondEnd = 0;
    int day = 0;
    int hour = 0;
    int minute = 0;
    int second = 0;
    final endDate = DateTime.fromMillisecondsSinceEpoch(time);
    final today = DateTime.now();

    if (endDate.year > today.year) {
      day = 31 - today.day + endDate.day;
      hour = day * 24 + endDate.hour - today.hour;
      minute = hour * 60 + endDate.minute - today.minute;
      second = minute * 60 + endDate.second - today.second;
      secondEnd = second;
    } else if (endDate.year == today.year) {
      if (endDate.month > today.month) {
        day = dayOfMonth(endDate.month, endDate.year) - today.day + endDate.day;
        hour = day * 24 + endDate.hour - today.hour;
        minute = hour * 60 + endDate.minute - today.minute;
        second = minute * 60 + endDate.second - today.second;
        secondEnd = second;
      } else if (endDate.month == today.month) {
        if (endDate.day >= endDate.day) {
          day = endDate.day - today.day;
          hour = day * 24 + endDate.hour - today.hour;
          minute = hour * 60 + endDate.minute - today.minute;
          second = minute * 60 + endDate.second - today.second;
          secondEnd = second;
        } else {
          secondEnd = 0;
        }
      } else {
        secondEnd = 0;
      }
    } else {
      secondEnd = 0;
    }
    if (secondEnd > 0) {
      return secondEnd;
    } else {
      return 0;
    }
  }

  bool isStartAuction(int startTime) {
    final int check = getTimeCountDown(startTime);
    if (check > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getBuyNftData({
    required String contractAddress,
    required String orderId,
    required String numberOfCopies,
    required BuildContext context,
  }) async {
    try {
      hexString = await web3Client.getBuyNftData(
        contractAddress: contractAddress,
        orderId: orderId,
        numberOfCopies: numberOfCopies,
        context: context,
      );
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
    return hexString;
  }

  //get dataString
  Future<String> getDataStringForCancel({
    required BuildContext context,
    required String orderId,
  }) async {
    try {
      showLoading();
      hexString = await web3Client.getCancelListingData(
        contractAddress: nft_sales_address_dev2,
        orderId: orderId,
        context: context,
      );
      showContent();
      return hexString;
    } catch (e) {
      showError();
      throw AppException(S.current.error, e.toString());
    }
  }

  Future<String> getDataStringForCancelAuction({
    required BuildContext context,
    required String auctionId,
  }) async {
    try {
      showLoading();
      hexString = await web3Client.getCancelAuctionData(
        contractAddress: nft_auction_dev2,
        context: context,
        auctionId: auctionId,
      );
      showContent();
      return hexString;
    } catch (e) {
      showError();
      throw AppException(S.current.error, e.toString());
    }
  }

  Future<String> getDataStringForCancelPawn({
    required String pawnId,
  }) async {
    try {
      showLoading();
      hexString = await web3Client.getWithdrawCollateralData(
        nftCollateralId: pawnId,
      );
      showContent();
      return hexString;
    } catch (e) {
      showError();
      throw AppException(S.current.error, e.toString());
    }
  }

  Future<void> confirmCancelSaleWithBE({
    required String txnHash,
    required String marketId,
  }) async {
    final result = await _nftRepo.cancelSale(
      id: marketId,
      txnHash: txnHash,
    );
    result.when(
      success: (res) {},
      error: (err) {},
    );
  }

  Future<void> confirmCancelAuctionWithBE({
    required String txnHash,
    required String marketId,
  }) async {
    final result = await _nftRepo.cancelAuction(
      id: marketId,
      txnHash: txnHash,
    );
    result.when(
      success: (res) {},
      error: (err) {},
    );
  }

  Future<void> confirmCancelPawnWithBE({
    required int id,
  }) async {
    await _nftRepo.cancelPawn(id);
  }
}
