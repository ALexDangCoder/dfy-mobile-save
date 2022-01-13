import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
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
  String nftMarketId = '';

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

  NFTRepository get _nftRepo => Get.find();

  late final NftMarket nftMarket;
  late final NFTOnAuction nftOnAuction;
  late final String owner;
  List<Wallet> wallets = [];

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

  ///GetOffer
  Future<void> getOffer(String collateralId) async {
    final Result<List<OfferDetail>> result =
        await _nftRepo.getOffer(collateralId);
    result.when(
      success: (res) {
        listOfferStream.add(res);
      },
      error: (error) {
        updateStateError();
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
          nftMarket = res;
          owner = res.owner ?? '';
          emit(NftOnSaleSuccess(res));
          getHistory(res.collectionAddress ?? '', res.nftTokenId ?? '');
          getOwner(res.collectionAddress ?? '', res.nftTokenId ?? '');
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
          nftOnAuction = res;
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
      showLoading();
      final Result<NftOnPawn> result =
          await _nftRepo.getDetailNftOnPawn(pawnId.toString());
      result.when(
        success: (res) {
          for (final value in listTokenSupport) {
            final tokenBuyOut = res.expectedCollateralSymbol ?? '';
            final symbol = value.symbol ?? '';
            if (tokenBuyOut.toLowerCase() == symbol.toLowerCase()) {
              res.urlToken = value.iconUrl;
              res.usdExchange = value.usdExchange;
            }
          }
          emit(NftOnPawnSuccess(res));
          getHistory(
            res.nftCollateralDetailDTO?.collectionAddress ?? '',
            res.nftCollateralDetailDTO?.nftTokenId.toString() ?? '',
          );
          getOwner(
            res.nftCollateralDetailDTO?.collectionAddress ?? '',
            res.nftCollateralDetailDTO?.nftTokenId.toString() ?? '',
          );
          getOffer(pawnId.toString());
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

          if (wallets.first.address == owner) {
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

  int getTimeCountDown(NFTOnAuction nftOnAuction) {
    final endDate =
        DateTime.fromMillisecondsSinceEpoch(nftOnAuction.endTime ?? 0);
    final today = DateTime.now().millisecondsSinceEpoch;
    if (endDate.millisecondsSinceEpoch > today) {
      return endDate.millisecondsSinceEpoch - today;
    } else {
      return 0;
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

  Future<String> getBidData({
    required String contractAddress,
    required String auctionId,
    required String bidValue,
    required BuildContext context,
  }) async {
    try {
      hexString = await web3Client.getBidData(
        contractAddress: contractAddress,
        auctionId: auctionId,
        bidValue: bidValue,
        context: context,
      );
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
    return hexString;
  }

  Future<String> getGasLimitByData(
      {required String fromAddress,
      required String toAddress,
      required String hexString}) async {
    try {
      gasLimit = await web3Client.getGasLimitByData(
        from: fromAddress,
        toContractAddress: toAddress,
        dataString: hexString,
      );
      emit(GetGasLimitSuccess(
        nftMarket,
        gasLimit,
      ));
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
    return gasLimit;
  }

  Future<void> callWeb3(BuildContext context, dynamic quantity,
      MarketType type) async {
    showLoading();
    try {
      switch (type) {
        case MarketType.SALE:
          await getBuyNftData(
            contractAddress: nft_sales_address_dev2,
            orderId: nftMarket.orderId.toString(),
            numberOfCopies: quantity.toString(),
            context: context,
          ).then(
            (value) => getGasLimitByData(
              fromAddress: wallets.first.address ?? '',
              toAddress: nft_sales_address_dev2,
              hexString: value,
            ),
          );
          break;
        case MarketType.AUCTION:
          await getBidData(
            contractAddress: nft_auction_dev2,
            auctionId: nftOnAuction.auctionId.toString(),
            bidValue: quantity.toString(),
            context: context,
          ).then(
            (value) => getGasLimitByData(
              fromAddress: wallets.first.address ?? '',
              toAddress: nft_auction_dev2,
              hexString: value,
            ),
          );
      }
      showContent();
    } catch (e) {
      showError();
      throw AppException(S.current.error, e.toString());
    }
  }
}
