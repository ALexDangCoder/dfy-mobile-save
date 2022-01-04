import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/nft_on_sale/ui/nft_list_on_sale/ui/components/ckc_filter.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'list_nft_state.dart';

class ListNftCubit extends BaseCubit<ListNftState> {
  ListNftCubit() : super(ListNftInitial());

  final BehaviorSubject<bool> isVisible = BehaviorSubject<bool>();
  final BehaviorSubject<bool> isVisibleAll = BehaviorSubject.seeded(true);
  final BehaviorSubject<List<CheckBoxFilter>> listCheckBox =
      BehaviorSubject<List<CheckBoxFilter>>();

  void show() {
    isVisible.sink.add(true);
    isVisibleAll.sink.add(false);
  }

  void hide() {
    isVisible.sink.add(false);
    isVisibleAll.sink.add(true);
    listCheckBox.add(listCollectionCheck);
  }

  String getTitle(MarketType type) {
    if (type == MarketType.SALE) {
      return S.current.nft_on_sale;
    } else if (type == MarketType.AUCTION) {
      return S.current.on_auction;
    } else {
      return S.current.on_pawn;
    }
  }

  void searchCollection(String nameCollection) {
    final List<CheckBoxFilter> search = [];
    for (final element in listCollectionCheck) {
      if (element.nameCkcFilter
          .toLowerCase()
          .contains(nameCollection.toLowerCase())) {
        search.add(element);
      }
    }
    if (nameCollection.isEmpty) {
      listCheckBox.add(listCollectionCheck);
      isVisibleAll.add(true);
    } else {
      listCheckBox.add(search);
    }
  }

  void getListNFT(MarketType type) {}

  List<CheckBoxFilter> listCollectionCheck = [
    const CheckBoxFilter(
      nameCkcFilter: 'Artwork',
      typeCkc: TYPE_CKC_FILTER.HAVE_IMG,
      urlCover: ImageAssets.img_art,
    ),
    const CheckBoxFilter(
      nameCkcFilter: 'Animals',
      typeCkc: TYPE_CKC_FILTER.HAVE_IMG,
      urlCover: ImageAssets.img_art,
    ),
    const CheckBoxFilter(
      nameCkcFilter: 'Painting',
      typeCkc: TYPE_CKC_FILTER.HAVE_IMG,
      urlCover: ImageAssets.img_art,
    ),
    const CheckBoxFilter(
      nameCkcFilter: 'Artwork',
      typeCkc: TYPE_CKC_FILTER.HAVE_IMG,
      urlCover: ImageAssets.img_art,
    ),
  ];

  List<NftMarket> listData = [
    NftMarket(
      nftId: '',
      collectionId: 'e48845cc-d9a6-4461-b358-c46da9278c3c',
      // backGround: '',
      tokenBuyOut: '',
      name: 'Tôi cầm IP 13++++',
      image:
          'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.SALE,
      typeNFT: TypeNFT.HARD_NFT,
      typeImage: TypeImage.IMAGE,
    ),
    NftMarket(
      nftId: '',
      collectionId: 'e48845cc-d9a6-4461-b358-c46da9278c3c',
      // backGround: '',
      tokenBuyOut: '',
      name: 'Tôi cầm IP 13++++',
      image:
          'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.PAWN,
      typeNFT: TypeNFT.SOFT_NFT,
      typeImage: TypeImage.IMAGE,
    ),
    NftMarket(
      nftId: '',
      collectionId: 'e48845cc-d9a6-4461-b358-c46da9278c3c',
      // backGround: '',
      tokenBuyOut: '',
      name: 'Tôi cầm IP 13++++',
      image:
          'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.AUCTION,
      typeNFT: TypeNFT.HARD_NFT,
      typeImage: TypeImage.VIDEO,
    ),
    NftMarket(
      nftId: '',
      collectionId: 'e48845cc-d9a6-4461-b358-c46da9278c3c',
      // backGround: '',
      tokenBuyOut: '',
      name: 'Tôi cầm IP 13++++',
      image:
          'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.PAWN,
      typeNFT: TypeNFT.SOFT_NFT,
      typeImage: TypeImage.IMAGE,
    ),
    NftMarket(
      nftId: '',
      collectionId: 'e48845cc-d9a6-4461-b358-c46da9278c3c',
      // backGround: '',
      tokenBuyOut: '',
      name: 'Tôi cầm IP 13++++',
      image:
          'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.SALE,
      typeNFT: TypeNFT.SOFT_NFT,
      typeImage: TypeImage.IMAGE,
    ),
    NftMarket(
      nftId: '',
      collectionId: 'e48845cc-d9a6-4461-b358-c46da9278c3c',
      // backGround: '',
      tokenBuyOut: '',
      name: 'Tôi cầm IP 13++++',
      image:
          'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.AUCTION,
      typeNFT: TypeNFT.HARD_NFT,
      typeImage: TypeImage.VIDEO,
    ),
    NftMarket(
      nftId: '',
      collectionId: 'e48845cc-d9a6-4461-b358-c46da9278c3c',
      // backGround: '',
      tokenBuyOut: '',
      name: 'Tôi cầm IP 13++++',
      image:
          'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.PAWN,
      typeNFT: TypeNFT.HARD_NFT,
      typeImage: TypeImage.IMAGE,
    ),
  ];
}
