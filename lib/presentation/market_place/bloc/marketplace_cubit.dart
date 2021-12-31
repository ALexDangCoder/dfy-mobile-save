import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/collection.dart';
import 'package:Dfy/domain/model/nft_item.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/ui/market_place_screen.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'marketplace_state.dart';

class MarketplaceCubit extends BaseCubit<MarketplaceState> {
  MarketplaceCubit() : super(MarketplaceInitial());

  List<String> categories = [
    S.current.collectibles,
    S.current.game,
    S.current.art,
    S.current.music,
    S.current.ultilities,
    S.current.car,
    S.current.sports
  ];
  List<Collection> listCollections = [
    Collection(
      background: ImageAssets.img_art,
      avatar: ImageAssets.img_collection,
      title: 'Artwork collection',
      items: 100,
    ),
    Collection(
      background: ImageAssets.img_nature,
      avatar: ImageAssets.img_collection,
      title: 'Nature collection',
      items: 100,
    ),
    Collection(
      background: ImageAssets.img_art,
      avatar: ImageAssets.img_collection,
      title: 'Vehicle collection',
      items: 100,
    ),
    Collection(
      background: ImageAssets.img_nature,
      avatar: ImageAssets.img_collection,
      title: 'Technology collection',
      items: 100,
    ),
  ];

  List<NftMarket> listFake = [
    NftMarket(nftId:'',
        collectionId:'e48845cc-d9a6-4461-b358-c46da9278c3c',
        backGround:'',
        tokenBuyOut:'',
        name:'Tôi cầm IP 13++++',
        image: 'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
        price: 1000,
        marketType: MarketType.SALE,
        typeNFT: TypeNFT.HARD_NFT,
        typeImage: TypeImage.IMAGE,
    ),
    NftMarket(nftId:'',
      collectionId:'e48845cc-d9a6-4461-b358-c46da9278c3c',
      backGround:'',
      tokenBuyOut:'',
      name:'Tôi cầm IP 13++++',
      image: 'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.PAWN,
      typeNFT: TypeNFT.SOFT_NFT,
      typeImage: TypeImage.IMAGE,
    ),
    NftMarket(nftId:'',
      collectionId:'e48845cc-d9a6-4461-b358-c46da9278c3c',
      backGround:'',
      tokenBuyOut:'',
      name:'Tôi cầm IP 13++++',
      image: 'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.AUCTION,
      typeNFT: TypeNFT.HARD_NFT,
      typeImage: TypeImage.VIDEO,
    ),
    NftMarket(nftId:'',
      collectionId:'e48845cc-d9a6-4461-b358-c46da9278c3c',
      backGround:'',
      tokenBuyOut:'',
      name:'Tôi cầm IP 13++++',
      image: 'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.PAWN,
      typeNFT: TypeNFT.SOFT_NFT,
      typeImage: TypeImage.IMAGE,
    ),
    NftMarket(nftId:'',
      collectionId:'e48845cc-d9a6-4461-b358-c46da9278c3c',
      backGround:'',
      tokenBuyOut:'',
      name:'Tôi cầm IP 13++++',
      image: 'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.SALE,
      typeNFT: TypeNFT.SOFT_NFT,
      typeImage: TypeImage.IMAGE,
    ),
    NftMarket(nftId:'',
      collectionId:'e48845cc-d9a6-4461-b358-c46da9278c3c',
      backGround:'',
      tokenBuyOut:'',
      name:'Tôi cầm IP 13++++',
      image: 'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.AUCTION,
      typeNFT: TypeNFT.HARD_NFT,
      typeImage: TypeImage.VIDEO,
    ),
    NftMarket(nftId:'',
      collectionId:'e48845cc-d9a6-4461-b358-c46da9278c3c',
      backGround:'',
      tokenBuyOut:'',
      name:'Tôi cầm IP 13++++',
      image: 'https://img.rarible.com/prod/image/upload/t_big/prod-itemImages/0xd07dc4262bcdbf85190c01c996b4c06a461d2430:556713/2014ad4f',
      price: 1000,
      marketType: MarketType.PAWN,
      typeNFT: TypeNFT.HARD_NFT,
      typeImage: TypeImage.IMAGE,
    ),
  ];
}
