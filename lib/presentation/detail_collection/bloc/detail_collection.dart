import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/response/collection_detail/collection_detail_res.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/activity_collection_model.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';
import 'package:Dfy/domain/repository/market_place/nft_market_repo.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'detail_collection_state.dart';

class DetailCollectionBloc extends BaseCubit<CollectionDetailState> {
// fillter nft
  static const int PUT_ON_MARKET = 0;
  static const int TRANSFER_ACTIVITY = 1;
  static const int BURN = 2;
  static const int CANCEL = 3;
  static const int LIKE = 4;
  static const int REPORT = 5;
  static const int BUY = 6;
  static const int BID_BUY_OUT = 7;
  static const int RECEIVE_OFFER = 8;
  static const int SIGN_CONTRACT = 9;
  static const int SUCCESS = 1;
  static const int FAILD = 3;
  static const int ERORR = 2;
  static const int LOADING = 0;
  static const int NOT_ON_MARKET = 0;
  static const int SALE = 1;
  static const int AUCTION = 2;
  static const int PAWN = 3;
  static const int TYPE721 = 0;
  static const String FACEBOOK = 'facebook';
  static const String INSTAGRAM = 'instagram';
  static const String TELEGRAM = 'telegram';
  static const String TWITTER = 'twitter';

//

  BehaviorSubject<bool> isHardNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSoftNft = BehaviorSubject.seeded(false);

  BehaviorSubject<bool> isOnSale = BehaviorSubject.seeded(false); //1
  BehaviorSubject<bool> isOnPawn = BehaviorSubject.seeded(false); //3
  BehaviorSubject<bool> isOnAuction = BehaviorSubject.seeded(false); //2
  BehaviorSubject<bool> isNotOnMarket = BehaviorSubject.seeded(false); //0

  List<int> listFilter = [
    NOT_ON_MARKET,
    SALE,
    AUCTION,
    PAWN,
  ];

  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isShowMoreStream = BehaviorSubject.seeded(false);

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

  BehaviorSubject<List<NftMarket>> listNft = BehaviorSubject.seeded([]);
  BehaviorSubject<int> statusNft = BehaviorSubject.seeded(LOADING);
  BehaviorSubject<int> statusActivity = BehaviorSubject.seeded(LOADING);
  BehaviorSubject<List<ActivityCollectionModel>> listActivity =
      BehaviorSubject.seeded([]);
  BehaviorSubject<CollectionDetailModel> collectionDetailModel =
      BehaviorSubject.seeded(CollectionDetailModel());

  DetailCollectionBloc() : super(CollectionDetailState());

  NftMarketRepository get _nftRepo => Get.find();

  CollectionDetailRepository get _collectionDetailRepository => Get.find();

  CollectionDetailModel arg = CollectionDetailModel();
  List<ActivityCollectionModel> argActivity = [];

  String linkUrlFacebook = '';
  String linkUrlTwitter = '';
  String linkUrlTelegram = '';
  String linkUrlInstagram = '';
  String collectionId = '';
  String collectionAddress = '';
  String typeActivity = '';

  void funFilterNft() {
    if (isOnSale.value) {
      listFilter.add(SALE);
    }
    if (isOnPawn.value) {
      listFilter.add(PAWN);
    }
    if (isOnAuction.value) {
      listFilter.add(AUCTION);
    }
    if (isNotOnMarket.value) {
      listFilter.add(NOT_ON_MARKET);
    }
    if (listFilter.isNotEmpty) {
      listFilter.clear();
      if (isOnSale.value) {
        listFilter.add(SALE);
      }
      if (isOnPawn.value) {
        listFilter.add(PAWN);
      }
      if (isOnAuction.value) {
        listFilter.add(AUCTION);
      }
      if (isNotOnMarket.value) {
        listFilter.add(NOT_ON_MARKET);
      }
      getListNft(
        collectionId: collectionId,
        listMarketType: listFilter,
        name: textSearch.value,
      );
    } else {
      getListNft(
        collectionId: collectionId,
        name: textSearch.value,
      );
    }
  }

  String funGetMarket(int marketStatus) {
    String market = '';
    if (marketStatus == SALE) {
      market = S.current.sale;
    } else if (marketStatus == AUCTION) {
      market = S.current.auction;
    } else if (marketStatus == PAWN) {
      market = S.current.pawn;
    } else {
      market = S.current.not_on_market;
    }
    return market;
  }

  String funCheckAddressSend({
    required String addressMyWallet,
    required String addressWallet,
  }) {
    String myAddressSend = '';
    if (addressMyWallet == addressWallet) {
      myAddressSend = S.current.activity_you;
    } else {
      if (addressWallet.length < 12) {
        myAddressSend = addressWallet;
      } else {
        myAddressSend = addressWallet.formatAddressActivityFire();
      }
    }
    return myAddressSend;
  }

  String funCheckAddressTo({
    required String addressMyWallet,
    required String addressWalletSend,
  }) {
    String myAddressTo = '';
    if (addressMyWallet == addressWalletSend) {
      myAddressTo = S.current.activity_you;
    } else {
      if (addressWalletSend.length < 12) {
        myAddressTo = addressWalletSend;
      } else {
        myAddressTo = addressWalletSend.formatAddressActivityFire();
      }
    }
    return myAddressTo;
  }

  String funCheckCopy({
    required int nftType,
    required String copy,
  }) {
    String myCopy = '';
    if (nftType == TYPE721) {
      myCopy = '';
    } else {
      myCopy = copy;
    }
    return myCopy;
  }

  String funCheckEach({
    required int nftType,
  }) {
    String each = '';
    if (nftType == TYPE721) {
      each = '';
    } else {
      each = S.current.activity_each;
    }
    return each;
  }

  void funFilterActivity() {
    if (isTransfer.value) {
      typeActivity = '$typeActivity,$TRANSFER_ACTIVITY';
    }
    if (isPutOnMarket.value) {
      typeActivity = '$typeActivity,$PUT_ON_MARKET';
    }
    if (isCancelMarket.value) {
      typeActivity = '$typeActivity,$CANCEL';
    }
    if (isBurn.value) {
      typeActivity = '$typeActivity,$BURN';
    }
    if (isLike.value) {
      typeActivity = '$typeActivity,$LIKE';
    }
    if (isReport.value) {
      typeActivity = '$typeActivity,$REPORT';
    }
    if (isBuy.value) {
      typeActivity = '$typeActivity,$BUY';
    }
    if (isBid.value) {
      typeActivity = '$typeActivity,$BID_BUY_OUT';
    }
    if (isReceiveOffer.value) {
      typeActivity = '$typeActivity,$RECEIVE_OFFER';
    }
    if (isSignContract.value) {
      typeActivity = '$typeActivity,$SIGN_CONTRACT';
    }

    if (typeActivity.isNotEmpty) {
      getListActivityCollection(
        collectionAddress: collectionAddress,
        type: typeActivity.substring(
          1,
          typeActivity.length,
        ),
      );
    } else {
      getListActivityCollection(
        collectionAddress: collectionAddress,
      );
    }
    typeActivity = '';
  }

  Timer? debounceTime;

  void search(String value) {
    if (debounceTime != null) {
      if (debounceTime!.isActive) {
        debounceTime!.cancel();
      }
    }
    debounceTime = Timer(
      const Duration(milliseconds: 800),
      () {
        if (listFilter.isNotEmpty) {
          getListNft(
            name: value,
            collectionId: collectionId,
            listMarketType: listFilter,
          );
        } else {
          getListNft(
            name: value,
            collectionId: collectionId,
            listMarketType: [
              NOT_ON_MARKET,
              SALE,
              AUCTION,
              PAWN,
            ],
          );
        }
      },
    );
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
  }

  void reset() {
    isHardNft.sink.add(false);
    isOnSale.sink.add(false);
    isSoftNft.sink.add(false);
    isOnPawn.sink.add(false);
    isOnAuction.sink.add(false);
    isNotOnMarket.sink.add(false);
    listFilter.clear();
  }

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
          collectionId = arg.id ?? '';
          collectionAddress = arg.collectionAddress ?? '';
          getListNft(
            collectionId: arg.id ?? '',
          );
          getListActivityCollection(
            collectionAddress: arg.collectionAddress ?? '',
          );
        }
      },
      error: (error) {
        emit(LoadingDataFail());
      },
    );
  }

  Future<void> getListNft({
    List<int>? listMarketType,
    String? name,
    required String collectionId,
  }) async {
    statusNft.add(LOADING);
    final Result<List<NftMarket>> result = await _nftRepo.getListNftCollection(
      collectionId: collectionId,
      nameNft: name,
      listMarketType: listMarketType,
    );
    result.when(
      success: (res) {
        if (res.isBlank ?? false) {
          statusNft.add(ERORR);
        } else {
          listNft.add(res);
          statusNft.add(SUCCESS);
        }
      },
      error: (error) {
        statusNft.add(FAILD);
      },
    );
  }

  Future<void> getListActivityCollection({
    String? collectionAddress = '',
    String? type = '',
  }) async {
    statusActivity.sink.add(LOADING);
    final Result<List<ActivityCollectionModel>> result =
        await _collectionDetailRepository.getCollectionListActivity(
      collectionAddress ?? '',
      type ?? '',
    );
    result.when(
      success: (res) {
        if (res.isBlank ?? false) {
          listActivity.add([]);
          statusActivity.add(ERORR);
        } else {
          argActivity.addAll(res);
          listActivity.add(res);
          statusActivity.add(SUCCESS);
        }
      },
      error: (error) {
        statusActivity.add(FAILD);
      },
    );
  }

  void funGetUrl(List<SocialLink> link) {
    for (final SocialLink value in link) {
      switch (value.type?.toLowerCase()) {
        case FACEBOOK:
          linkUrlFacebook = value.url ?? '';
          break;
        case INSTAGRAM:
          linkUrlInstagram = value.url ?? '';
          break;
        case TELEGRAM:
          linkUrlTelegram = value.url ?? '';
          break;
        case TWITTER:
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
