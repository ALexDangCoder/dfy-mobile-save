import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/collection.dart';
import 'package:Dfy/domain/model/nft_item.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/ui/maket_place_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'marketplace_state.dart';

class MarketplaceCubit extends BaseCubit<MarketplaceState> {
  MarketplaceCubit() : super(MarketplaceInitial());

  List<String> categories = [S.current.music,
    S.current.sports,
    S.current.nature, S.current.car, S.current.another];
  List<Collection> listCollections = [
    Collection(
      background: ImageAssets.img_art,
      avatar: ImageAssets.img_collection,
      title: 'Artwork collection',
    ),
    Collection(
      background: ImageAssets.img_nature,
      avatar: ImageAssets.img_collection,
      title: 'Nature collection',
    ),
    Collection(
      background: ImageAssets.img_art,
      avatar: ImageAssets.img_collection,
      title: 'Vehicle collection',
    ),
    Collection(
      background: ImageAssets.img_nature,
      avatar: ImageAssets.img_collection,
      title: 'Technology collection',
    ),
  ];

  List<NftItem> listFakeDataHardNFT = [
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.IMAGE,
      typeNFT: TypeNFT.HARD_NFT,
      hotAuction: TypeHotAuction.NO,
      propertiesNFT: TypePropertiesNFT.SALE,
    ),
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.IMAGE,
      hotAuction: TypeHotAuction.YES,
      propertiesNFT: TypePropertiesNFT.AUCTION,
    ),
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.VIDEO,
      typeNFT: TypeNFT.HARD_NFT,
      hotAuction: TypeHotAuction.NO,
      propertiesNFT: TypePropertiesNFT.PAWN,
    ),
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.IMAGE,
      typeNFT: TypeNFT.HARD_NFT,
      hotAuction: TypeHotAuction.YES,
      propertiesNFT: TypePropertiesNFT.SALE,
    ),
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.IMAGE,
      hotAuction: TypeHotAuction.NO,
      propertiesNFT: TypePropertiesNFT.AUCTION,
    ),
  ];
  List<NftItem> listFakeDataCollateral = [
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.IMAGE,
    ),
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.IMAGE,
    ),
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.VIDEO,
    ),
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.IMAGE,
    ),
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.IMAGE,
    ),
  ];

  List<NftItem> listFakeDataHotAuction = [
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.IMAGE,
      typeNFT: TypeNFT.HARD_NFT,
    ),
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.IMAGE,
    ),
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.VIDEO,
      typeNFT: TypeNFT.HARD_NFT,
    ),
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.IMAGE,
      typeNFT: TypeNFT.HARD_NFT,
    ),
    NftItem(
      name: 'Lamborghini Aventador Pink ver 2021',
      image: 'assets/images/lambo.png',
      price: 10000,
      typeImage: TypeImage.IMAGE,
    ),
  ];
}
