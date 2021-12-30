import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/collection.dart';
import 'package:Dfy/domain/model/market_place/explore_category_model.dart';
import 'package:Dfy/domain/model/market_place/list_type_nft_collection_explore_model.dart';
import 'package:Dfy/domain/model/market_place/nft_collection_explore_model.dart';
import 'package:Dfy/domain/model/market_place/nft_model_full.dart';
import 'package:Dfy/domain/model/market_place/outstanding_collection_model.dart';
import 'package:Dfy/domain/model/nft_item.dart';
import 'package:Dfy/domain/repository/market_place/list_type_nft_collection_explore_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'marketplace_state.dart';

class MarketplaceCubit extends BaseCubit<MarketplaceState> {
  MarketplaceCubit() : super(MarketplaceInitial());

  MarketPlaceRepository get _marketPlaceRepo => Get.find();

  List<NftModelFull> nftsHotAution = [];
  List<NftModelFull> nftsSale = [];

  //pawnNft
  List<NftModelFull> nftsCollateral = [];
  List<NftModelFull> nftsHardNft = [];
  List<OutstandingCollection> outstandingCollection = [];
  List<ExploreCategory> exploreCategories = [];

  Future<void> getListNftCollectionExplore() async {
    emit(LoadingDataLoading());
    final Result<List<ListTypeNftCollectionExploreModel>> result =
        await _marketPlaceRepo.getListTypeNftCollectionExplore();
    result.when(
      success: (res) {
        getNftCollectionExplore(res);
        emit(LoadingDataSuccess());
      },
      error: (error) {
        emit(LoadingDataFail());
        //todo handle error
      },
    );
  }

  void getNftCollectionExplore(
    List<ListTypeNftCollectionExploreModel> response,
  ) {
    for (final e in response) {
      if (e.name == 'Buy, sell, and create collectible NFTs') {
      } else if (e.name == 'Featured NFTs') {
        //hard nft chưa có
        e.items?.forEach(
          (e) => nftsHardNft.add(
            NftModelFull(
              id: e.id,
              nftId: e.nftId,
              name: e.name,
              price: e.price,
              startTime: e.startTime,
              endTime: e.endTime,
              type: e.type,
              itemId: e.itemId,
              fileCid: e.fileCid,
              //url
              marketType: e.marketType,
              numberOfCopies: e.numberOfCopies,
              position: e.position,
            ),
          ),
        );
      } else if (e.name == 'Hot auction') {
        e.items?.forEach(
          (e) => nftsHotAution.add(
            NftModelFull(
              id: e.id,
              nftId: e.nftId,
              name: e.name,
              price: e.price,
              startTime: e.startTime,
              endTime: e.endTime,
              type: e.type,
              itemId: e.itemId,
              fileCid: e.fileCid,
              //url
              marketType: e.marketType,
              numberOfCopies: e.numberOfCopies,
              position: e.position,
            ),
          ),
        );
      } else if (e.name == 'Outstanding collection') {
        e.items?.forEach(
          (e) => outstandingCollection.add(
            OutstandingCollection(
              id: e.id,
              name: e.name,
              itemId: e.itemId,
              avatarCid: e.avatarCid,
              coverCid: e.coverCid,
              nftOwnerCount: e.nftOwnerCount,
              totalNft: e.totalNft,
            ),
          ),
        );
      } else if (e.name == 'Sell items') {
        e.items?.forEach(
          (e) => nftsSale.add(
            NftModelFull(
              id: e.id,
              nftId: e.nftId,
              name: e.name,
              price: e.price,
              startTime: e.startTime,
              endTime: e.endTime,
              type: e.type,
              itemId: e.itemId,
              fileCid: e.fileCid,
              //url
              marketType: e.marketType,
              numberOfCopies: e.numberOfCopies,
              position: e.position,
            ),
          ),
        );
      } else if (e.name == 'NFTs collateral') {
        e.items?.forEach(
          (e) => nftsCollateral.add(
            NftModelFull(
              id: e.id,
              nftId: e.nftId,
              name: e.name,
              price: e.price,
              startTime: e.startTime,
              endTime: e.endTime,
              type: e.type,
              itemId: e.itemId,
              fileCid: e.fileCid,
              //url
              marketType: e.marketType,
              numberOfCopies: e.numberOfCopies,
              position: e.position,
            ),
          ),
        );
      } //this else is explore categories
      else {
        e.items?.forEach(
          (e) => exploreCategories.add(
            ExploreCategory(
              itemId: e.itemId,
              id: e.id,
              name: e.name,
              bannerCid: e.bannerCid,
              displayRow: e.displayRow,
              displayCol: e.displayCol,
              position: e.position,
              avatarCid: e.avatarCid,
            ),
          ),
        );
      }
    }
  }

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
