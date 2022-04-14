import 'dart:async';
import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/market_place/evaluator_detail.dart';
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
import 'package:Dfy/utils/extensions/string_extension.dart';
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
  bool isBiding = false;

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
  final BehaviorSubject<EvaluatorsDetailModel> evaluatorStream = BehaviorSubject();


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

  /// Import wallet
  Future<void> emitJsonNftToWalletCore({
    required String contract,
    int? id,
    required String address,
  }) async {
    Map<String, dynamic> result = {};
    if (id != null) {
      result = await Web3Utils()
          .getCollectionInfo(contract: contract, address: address, id: id);
      await importNftIntoWalletCore(
        jsonNft: json.encode(result),
        address: address,
      );
    } else {
      result = await Web3Utils()
          .getCollectionInfo(contract: contract, address: address);
      // result.putIfAbsent('walletAddress', () => address);
      await importNftIntoWalletCore(
        jsonNft: json.encode(result),
        address: address,
      );
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
    } on PlatformException {}
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
        getEvaluator(res.evaluator?.id ?? '');
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
  Future<void> getEvaluator(String evaluationId) async {
    final Result<EvaluatorsDetailModel> result =
    await _nftRepo.getEvaluator(evaluationId);
    result.when(
      success: (res) {
        if(res.conditionDetail !=''){
          List<String> des;
          final buffer = StringBuffer();
          des = res.conditionDetail!.split('<p>') ;
          for(final element in des){
            buffer.write('$element\n\n');
          }

          res.conditionDetail = buffer.toString().parseHtml();
        }
        evaluatorStream.add(res);
        showContent();
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
      final Result<NftMarket> result2;
      if (typeNFT == TypeNFT.SOFT_NFT) {
        result = await _nftRepo.getDetailNftMyAccNotOnMarket(nftId, '0');
        result2 = await _nftRepo.getDetailNft2(nftId);
      } else {
        result = await _nftRepo.getDetailHardNftOnSale(
          nftId,
        );
        result2 = await _nftRepo.getDetailNft2(nftId);
      }
      result.when(
        success: (res) {
          if (typeNFT == TypeNFT.SOFT_NFT) {
            result2.when(
              success: (res2) {
                res.collectionName = res2.collectionName;
                res.description = res2.description;
              },
              error: (error2) {},
            );
          }
          final String wallet = PrefsService.getCurrentBEWallet();
          if (res.walletAddress?.toLowerCase() == wallet.toLowerCase() ||
              res.owner?.toLowerCase() == wallet.toLowerCase()) {
            res.isOwner = true;
          } else {
            res.isOwner = false;
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
        },
        error: (error) {
          if (error.code == CODE_ERROR_NOT_FOUND) {
            showEmpty();
          } else {
            showError();
          }
        },
      );
    }
    if (type == MarketType.SALE) {
      showLoading();
      final Result<NftMarket> result;
      result = await _nftRepo.getDetailNftOnSale(marketId).then((value) async {
        if (typeNFT == TypeNFT.HARD_NFT) {
          final Result<NftMarket> result2 =
              await _nftRepo.getDetailHardNftOnSale(nftId);
          result2.when(
            success: (res) {
              getEvaluation(res.evaluationId ?? '');
            },
            error: (error) {
              showError();
            },
          );
          return value;
        } else {
          return value;
        }
      });
      result.when(
        success: (res) {
          final tokenBuyOut =
              res.tokenBuyOut == '' ? res.tokenBuyOut : res.token;
          for (final value in listTokenSupport) {
            if (tokenBuyOut?.toLowerCase() == value.address?.toLowerCase() ||
                tokenBuyOut?.toLowerCase() == value.symbol?.toLowerCase()) {
              res.urlToken = value.iconUrl;
              res.symbolToken = value.symbol;
              res.usdExchange = value.usdExchange;
              break;
            }
          }
          showContent();
          emit(NftOnSaleSuccess(res));
          getHistory(
            collectionAddress: res.collectionAddress ?? '',
            nftTokenId: res.nftTokenId ?? '',
          );
          getOwner(res.collectionAddress ?? '', res.nftTokenId ?? '');
        },
        error: (error) {
          if (error.code == CODE_ERROR_NOT_FOUND) {
            showEmpty();
          } else {
            showError();
          }
        },
      );
    }
    if (type == MarketType.AUCTION) {
      showLoading();
      final Result<NFTOnAuction> result;
      result = await _nftRepo.getDetailNFTAuction(marketId).then(
        (value) async {
          if (value is Success) {
            if (typeNFT == TypeNFT.HARD_NFT) {
              final Result<NFTOnAuction> result2 =
                  await _nftRepo.getDetailHardNftOnAuction(nftId);
              result2.when(
                success: (res) {
                  getEvaluation(res.evaluationId ?? '');
                },
                error: (error) {
                  showError();
                },
              );
              return value;
            } else {
              return value;
            }
          } else {
            return value;
          }
        },
      );
      result.when(
        success: (res) {
          showContent();
          final tokenBuyOut = res.token ?? '';
          for (final value in listTokenSupport) {
            if (tokenBuyOut.toLowerCase() == value.address?.toLowerCase() ||
                tokenBuyOut.toLowerCase() == value.symbol?.toLowerCase()) {
              res.urlToken = value.iconUrl;
              res.tokenSymbol = value.symbol;
              res.usdExchange = value.usdExchange;
              symbolToken = value.symbol ?? '';
            }
          }
          nftOnAuction = res;
          emit(NftOnAuctionSuccess(res));
          getHistory(
            collectionAddress: res.collectionAddress ?? '',
            nftTokenId: res.nftTokenId ?? '',
          );
          getOwner(res.collectionAddress ?? '', res.nftTokenId ?? '');
          getBidding(res.id.toString());
        },
        error: (error) {
          if (error.code == CODE_ERROR_NOT_FOUND) {
            showEmpty();
          } else {
            showError();
          }
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
          for (final value in listTokenSupport) {
            final tokenBuyOut = res.expectedCollateralSymbol ?? '';
            final symbol = value.symbol ?? '';
            if (tokenBuyOut.toLowerCase() == symbol.toLowerCase()) {
              res.urlToken = value.iconUrl;
              res.usdExchange = value.usdExchange;
              res.repaymentAsset = value.address;
            }
          }
          getOffer(pawnId.toString());
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
          if (error.code == CODE_ERROR_NOT_FOUND) {
            showEmpty();
          } else {
            showError();
          }
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
          if (wallets.first.address?.toLowerCase() == owner.toLowerCase()) {
            pairSink.add(false);
          } else {
            pairSink.add(true);
          }
        }
        return walletAddress;
      case 'importNftCallback':
        final int code = await methodCall.arguments['code'];
        break;
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
        contractAddress: Get.find<AppConstants>().nftSalesAddress,
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
        contractAddress: Get.find<AppConstants>().nftAuction,
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
      error: (err) {
        if (err.code == CODE_ERROR_AUTH) {
          confirmCancelSaleWithBE(
            txnHash: txnHash,
            marketId: marketId,
          );
        }
      },
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
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          confirmCancelAuctionWithBE(marketId: marketId, txnHash: txnHash);
        }
      },
    );
  }

  Future<void> confirmCancelPawnWithBE({
    required int id,
  }) async {
    final result = await _nftRepo.cancelPawn(id);
    result.when(
      success: (res) {},
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          confirmCancelPawnWithBE(id: id);
        }
      },
    );
  }
}
