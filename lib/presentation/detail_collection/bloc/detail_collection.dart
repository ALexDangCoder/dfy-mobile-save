import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/response/collection_detail/collection_detail_res.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/activity_collection_model.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'detail_collection_state.dart';

class DetailCollectionBloc extends BaseCubit<CollectionDetailState> {
// fillter nft
  BehaviorSubject<bool> isHardNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSoftNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOnSale = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOnPawn = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOnAuction = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isNotOnMarket = BehaviorSubject.seeded(false);
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isShowMoreStream = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAll = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAllStatus = BehaviorSubject.seeded(false);

  //filter activity
  BehaviorSubject<bool> isTransfer = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isPutOnMarket = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCancelMarket = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isBurn = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isLike = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isReport = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isBuy = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isBid = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isReceiveOffer = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSignContract = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAllActivity = BehaviorSubject.seeded(false);
  BehaviorSubject<List<ActivityCollectionModel>> listActivity =
      BehaviorSubject.seeded([]);
  BehaviorSubject<CollectionDetailModel> collectionDetailModel =
      BehaviorSubject.seeded(CollectionDetailModel());

  DetailCollectionBloc() : super(CollectionDetailState());

  CollectionDetailRepository get _collectionDetailRepository => Get.find();
  CollectionDetailModel arg = CollectionDetailModel();
  List<ActivityCollectionModel> argActivity = [];

  String linkUrlFacebook = '';
  String linkUrlTwitter = '';
  String linkUrlTelegram = '';
  String linkUrlInstagram = '';

  Future<void> getCollection({String? id = ''}) async {
    emit(LoadingData());
    final Result<CollectionDetailModel> result =
        await _collectionDetailRepository.getCollectionDetail(id ?? '');
    result.when(
      success: (res) {
        if (res.isBlank ?? false) {
          emit(LoadingDataErorr());
        } else {
          emit(LoadingDataSuccess());
          arg = res;
          collectionDetailModel.sink.add(arg);
          // getListActivityCollection(
          //     collectionAddress: arg.collectionAddress ?? '');
          getListActivityCollection(
              collectionAddress: '0x045709660ab325b35cf1baf1981cf357f98b4235');
        }
      },
      error: (error) {
        emit(LoadingDataFail());
      },
    );
  }

  Future<void> getListActivityCollection(
      {String? collectionAddress = '', String? status = ''}) async {
    // emit(LoadingData());
    final Result<List<ActivityCollectionModel>> result =
        await _collectionDetailRepository.getCollectionListActivity(
            collectionAddress ?? '', status ?? '');
    result.when(
      success: (res) {
        if (res.isBlank ?? false) {
          //emit(LoadingDataErorr());
          listActivity.add([]);
        } else {
          //emit(LoadingDataSuccess());
          argActivity.addAll(res);
          listActivity.add(argActivity);
        }
      },
      error: (error) {
        // emit(LoadingDataFail());
      },
    );
  }

  void funGetUrl(List<SocialLink> link) {
    for (final SocialLink value in link) {
      switch (value.type?.toLowerCase()) {
        case 'facebook':
          linkUrlFacebook = value.url ?? '';
          break;
        case 'instagram':
          linkUrlInstagram = value.url ?? '';
          break;
        case 'telegram':
          linkUrlTelegram = value.url ?? '';
          break;
        case 'twitter':
          linkUrlTwitter = value.url ?? '';
          break;
        default:
          break;
      }
    }
  }

  String funGetSymbolUrl(String link) {
    switch (link.toUpperCase()) {
      case 'ADA':
        return ImageAssets.imgTokenADA;
      case 'ATOM':
        return ImageAssets.imgTokenATOM;
      case 'BAND':
        return ImageAssets.imgTokenBAND;
      case 'BAT':
        return ImageAssets.imgTokenBAT;
      case 'BCH':
        return ImageAssets.imgTokenBCH;
      case 'BEL':
        return ImageAssets.imgTokenBEL;
      case 'BNB':
        return ImageAssets.imgTokenBNB;
      case 'BTCB':
        return ImageAssets.imgTokenBTCB;
      case 'BTC':
        return ImageAssets.imgTokenBTC;
      case 'BUSD':
        return ImageAssets.imgTokenBUSD;
      case 'BUSD T':
        return ImageAssets.imgTokenBUSD_T;
      case 'COMP':
        return ImageAssets.imgTokenCOMP;
      case 'DAI':
        return ImageAssets.imgTokenDAI;
      case 'DefiIcon':
        return ImageAssets.imgTokenDefiIcon;
      case 'DFY':
        return ImageAssets.imgTokenDFY;
      case 'DOGE':
        return ImageAssets.imgTokenDOGE;
      case 'DOT':
        return ImageAssets.imgTokenDOT;
      case 'ELF':
        return ImageAssets.imgTokenELF;
      case 'EOS':
        return ImageAssets.imgTokenEOS;
      case 'ETC':
        return ImageAssets.imgTokenETC;
      case 'ETH':
        return ImageAssets.imgTokenETH;
      case 'FIL':
        return ImageAssets.imgTokenFIL;
      case 'INJ':
        return ImageAssets.imgTokenINJ;
      case 'INTT':
        return ImageAssets.imgTokenINTT;
      case 'IOTX':
        return ImageAssets.imgTokenIOTX;
      case 'LINK':
        return ImageAssets.imgTokenLINK;
      case 'LTC':
        return ImageAssets.imgTokenLTC;
      case 'MKR':
        return ImageAssets.imgTokenMKR;
      case 'NEAR':
        return ImageAssets.imgTokenNEAR;
      case 'ONT':
        return ImageAssets.imgTokenONT;
      case 'PAX':
        return ImageAssets.imgTokenPAX;
      case 'SNX':
        return ImageAssets.imgTokenSNX;
      case 'SXP':
        return ImageAssets.imgTokenSXP;
      case 'TCT':
        return ImageAssets.imgTokenTCT;
      case 'UNI':
        return ImageAssets.imgTokenUNI;
      case 'USDC':
        return ImageAssets.imgTokenUSDC;
      case 'WBNB':
        return ImageAssets.imgTokenWBNB;
      case 'XRP':
        return ImageAssets.imgTokenXRP;
      case 'XTZ':
        return ImageAssets.imgTokenXTZ;
      case 'YFI':
        return ImageAssets.imgTokenYFI;
      case 'YFII':
        return ImageAssets.imgTokenYFII;
      case 'ZEC':
        return ImageAssets.imgTokenZEC;
      default:
        return '';
    }
  }

  void resetFilterActivity(bool value) {
    isTransfer.sink.add(value);
    isPutOnMarket.sink.add(value);
    isCancelMarket.sink.add(value);
    isBurn.sink.add(value);
    isLike.sink.add(value);
    isReport.sink.add(value);
    isBuy.sink.add(value);
    isBid.sink.add(value);
    isReceiveOffer.sink.add(value);
    isSignContract.sink.add(value);
    isAllActivity.sink.add(value);
  }

  void allTypeNft(bool value) {
    isHardNft.sink.add(value);
    isSoftNft.sink.add(value);
  }

  void allStatusNft(bool value) {
    isNotOnMarket.sink.add(value);
    isOnAuction.sink.add(value);
    isOnSale.sink.add(value);
    isOnPawn.sink.add(value);
  }

//Transfer
// Put on market
// Cancel market
// Burn
// Like
// Report
// Buy
// Bid
// Receive offer
// Sign contract
  void reset() {
    isAll.sink.add(false);
    isHardNft.sink.add(false);
    isOnSale.sink.add(false);
    isSoftNft.sink.add(false);
    isOnPawn.sink.add(false);
    isOnAuction.sink.add(false);
    isNotOnMarket.sink.add(false);
    isAllStatus.sink.add(false);
  }

  void search() {
    textSearch.stream
        .debounceTime(
      const Duration(
        seconds: 1,
      ),
    )
        .listen((event) {
      if (event.length == '') {}
    });
  }

  void dispone() {
    isHardNft.close();
    isSoftNft.close();
    isOnSale.close();
    isOnPawn.close();
    isOnAuction.close();
    isNotOnMarket.close();
    textSearch.close();
  }
}
