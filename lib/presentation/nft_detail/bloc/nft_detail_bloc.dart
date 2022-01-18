import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
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
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';

class NFTDetailBloc extends BaseCubit<NFTDetailState> {
  NFTDetailBloc() : super(NFTDetailInitial());

  final _viewSubject = BehaviorSubject.seeded(true);
  final _pairSubject = BehaviorSubject<bool>();
  final Web3Utils web3Client = Web3Utils();
  double balance = 0;
  String hexString = '';
  String gasLimit = '';
  String rawData = '';
  String nftMarketId = '';
  int quantity = 0;
  double totalPayment = 0;
  double bidValue = 0;

  NFTRepository get _nftRepo => Get.find();

  late final NftMarket nftMarket;
  late final NFTOnAuction nftOnAuction;
  late final String owner;
  List<Wallet> wallets = [];

  late final String walletAddress;

  Stream<bool> get viewStream => _viewSubject.stream;

  Sink<bool> get viewSink => _viewSubject.sink;

  final BehaviorSubject<List<HistoryNFT>> listHistoryStream =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<List<OwnerNft>> listOwnerStream =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<List<BiddingNft>> listBiddingStream =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<List<OfferDetail>> listOfferStream =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<Evaluation> evaluationStream = BehaviorSubject();

  String symbolToken = '';

  ///GetHistory
  Stream<bool> get pairStream => _pairSubject.stream;

  Sink<bool> get pairSink => _pairSubject.sink;

  Future<double> getBalanceToken({
    required String ofAddress,
    required String tokenAddress,
  }) async {
    showLoading();
    try {
      balance = await web3Client.getBalanceOfToken(
        ofAddress: ofAddress,
        tokenAddress: tokenAddress,
      );
      showContent();
    } catch (e) {
      showError();
      throw AppException(S.current.error, e.toString());
    }
    return balance;
  }

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
  Future<void> getEvaluation(String evaluationId, String urlIcon) async {
    final Result<Evaluation> result =
        await _nftRepo.getEvaluation(evaluationId);
    result.when(
      success: (res) {
        res.urlToken = urlIcon;
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
  }) async {
    getTokenInf();
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
          nftMarket = res;
          owner = res.owner ?? '';
          emit(NftOnSaleSuccess(res));
          getHistory(res.collectionAddress ?? '', res.nftTokenId ?? '');
          getOwner(res.collectionAddress ?? '', res.nftTokenId ?? '');
          if (typeNFT == TypeNFT.HARD_NFT) {
            getEvaluation(res.evaluationId ?? '', res.urlToken ?? '');
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
          emit(NftOnSaleFail());
          updateStateError();
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
            getEvaluation(res.evaluationId ?? '', res.urlToken ?? '');
          }
          getHistory(res.collectionAddress ?? '', res.nftTokenId ?? '');
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
          updateStateError();
        },
      );
    }
    if (type == MarketType.PAWN) {
      showLoading();
      final Result<NftOnPawn> result =
          await _nftRepo.getDetailNftOnPawn(pawnId.toString());
      result.when(
        success: (res) {
          getOffer(pawnId.toString());
          for (final value in listTokenSupport) {
            final tokenBuyOut = res.expectedCollateralSymbol ?? '';
            final symbol = value.symbol ?? '';
            if (tokenBuyOut.toLowerCase() == symbol.toLowerCase()) {
              res.urlToken = value.iconUrl;
              res.usdExchange = value.usdExchange;
            }
          }
          emit(NftOnPawnSuccess(res));
          if (typeNFT == TypeNFT.HARD_NFT) {
            getEvaluation(res.nftCollateralDetailDTO?.evaluationId ?? '',
                res.urlToken ?? '');
          }
          getHistory(
            res.nftCollateralDetailDTO?.collectionAddress ?? '',
            res.nftCollateralDetailDTO?.nftTokenId.toString() ?? '',
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
    final result = await web3Client.getTransactionCount(address: walletAddress);
    return result.count;
  }

  Future<void> getListWallets() async {
    try {
      await trustWalletChannel.invokeMethod('getListWallets', {});
    } on PlatformException {}
  }

  ///GetOwner
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



  List<DetailItemApproveModel> initListApprove() {
    //todo: Vũ: tạm hardcode
    final List<DetailItemApproveModel> listApprove = [];
    if (nftMarket.nftStandard == 'ERC-721') {
      listApprove.add(
        DetailItemApproveModel(
          title: 'NTF',
          value: nftMarket.name ?? '',
        ),
      );
      listApprove.add(
        DetailItemApproveModel(
          title: S.current.quantity,
          value: '${nftMarket.numberOfCopies}',
        ),
      );
    } else {
      listApprove.add(
        DetailItemApproveModel(
          title: 'NTF',
          value: nftMarket.name ?? '',
        ),
      );
    }
    return listApprove;
  }

  //get limit gas

  //get dataString
  Future<double> getGasLimitForCancel({
    required BuildContext context,
  }) async {
    try {
      showLoading();
      hexString = await web3Client.getCancelListingData(
        contractAddress: nft_sales_address_dev2,
        orderId: nftMarket.orderId.toString(),
        context: context,
      );
      gasLimit = await web3Client.getGasLimitByData(
        from: '0x39ee4c28E09ce6d908643dDdeeAeEF2341138eBB',
        toContractAddress: nft_sales_address_dev2,
        dataString: hexString,
      );

      showContent();
      return double.parse(gasLimit);
    } catch (e) {
      showError();
      throw AppException(S.current.error, e.toString());
    }
  }

  //cancel sale:
  Future<Map<String, dynamic>> cancelSale({required String transaction}) async {
    final Map<String, dynamic> res =
        await web3Client.sendRawTransaction(transaction: transaction);
    return res;
  }
}
