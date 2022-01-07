import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

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

  ///GetInfoNft
  ///
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
            }
          }
          showContent();
          emit(NftOnAuctionSuccess(res));
          getHistory(res.collectionAddress ?? '', res.nftTokenId ?? '');
          getOwner(res.collectionAddress ?? '', res.nftTokenId ?? '');
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
    }
    else{
      return 0;
    }
  }
}
