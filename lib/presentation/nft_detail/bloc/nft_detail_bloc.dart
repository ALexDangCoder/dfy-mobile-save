import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class NFTDetailBloc extends BaseCubit<NFTDetailState> {
  NFTDetailBloc() : super(NFTDetailInitial()) {
    showLoading();
  }

  final _viewSubject = BehaviorSubject.seeded(true);
  final _pairSubject = BehaviorSubject<bool>();
  final Web3Utils web3Client = Web3Utils();
  late final double balance;

  Stream<bool> get viewStream => _viewSubject.stream;

  Sink<bool> get viewSink => _viewSubject.sink;

  Stream<bool> get pairStream => _pairSubject.stream;

  Sink<bool> get pairSink => _pairSubject.sink;

  Future<double> getBalanceToken(
      {required String ofAddress, required String tokenAddress}) async {
    balance = await web3Client.getBalanceOfToken(
      ofAddress: ofAddress,
      tokenAddress: tokenAddress,
    );
    return balance;
  }

  NFTRepository get _nftRepo => Get.find();
  late final NftMarket nftMarket;
  late final String walletAddress;
  late final String owner;
  List<Wallet> wallets = [];

  Future<void> getHistory(String collectionAddress, String nftTokenId) async {
    final Result<List<HistoryNFT>> result =
        await _nftRepo.getHistory(collectionAddress, nftTokenId);
    result.when(
      success: (res) {},
      error: (error) {
        updateStateError();
      },
    );
  }

  Future<void> getInForNFT(String marketId, MarketType type) async {
    if (type == MarketType.SALE) {
      showLoading();
      final Result<NftMarket> result =
          await _nftRepo.getDetailNftOnSale(marketId);
      result.when(
        success: (res) {
          showContent();
          nftMarket = res;
          owner = res.owner ?? '';
          emit(NftOnSaleSuccess(res));
          getHistory(res.collectionAddress ?? '', res.nftTokenId ?? '');
        },
        error: (error) {
          emit(NftOnSaleFail());
          updateStateError();
        },
      );
    }
    if (type == MarketType.AUCTION) {
      ///call api Detail onAuction
    }
    if (type == MarketType.PAWN) {
      ///call api detail onPawn
    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        if (data.isEmpty) {
          emit(NoWallet(nftMarket));
          pairSink.add(true);
        } else {
          for (final element in data) {
            wallets.add(Wallet.fromJson(element));
          }
          if (wallets.first.address == owner) {
            pairSink.add(false);
          } else {
            pairSink.add(true);
          }
          emit(HaveWallet(nftMarket));
        }
        break;
      default:
        break;
    }
  }

  Future<void> getListWallets() async {
    try {
      await trustWalletChannel.invokeMethod('getListWallets', {});
    } on PlatformException {}
  }

  ///GetOwner

}
