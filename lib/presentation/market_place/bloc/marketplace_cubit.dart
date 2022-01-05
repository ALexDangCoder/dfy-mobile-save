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
import 'package:Dfy/domain/model/nft_market_place.dart';
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

  List<NftMarket> nftsHotAution = [];
  List<NftMarket> nftsSale = [];

  //pawnNft
  List<NftMarket> nftsCollateral = [];
  List<NftMarket> nftsHardNft = [];
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
            NftMarket(
              nftId: e.nftId ?? '',
              marketId: e.id ?? '',
              name: e.name ?? '',
              image: e.fileCid ?? '',
              price: e.price ?? 0,
              tokenBuyOut: e.token ?? '',
              reservePrice: e.reservePrice,
              buyOutPrice: e.buyOutPrice,
              numberOfCopies: e.numberOfCopies,
              totalCopies: e.totalCopies,
              marketType: e.marketType == 1
                  ? MarketType.SALE
                  : (e.marketType == 2 ? MarketType.AUCTION : MarketType.PAWN),
              typeImage: TypeImage.IMAGE,
              typeNFT: e.type == 0 ? TypeNFT.SOFT_NFT : TypeNFT.HARD_NFT,
            ),
          ),
        );
      } else if (e.name == 'Hot auction') {
        e.items?.forEach(
          (e) => nftsHotAution.add(
            NftMarket(
              nftId: e.nftId ?? '',
              marketId: e.id ?? '',
              name: e.name ?? '',
              image: e.fileCid ?? '',
              price: e.price ?? 0,
              tokenBuyOut: e.token ?? '',
              reservePrice: e.reservePrice,
              buyOutPrice: e.buyOutPrice,
              numberOfCopies: e.numberOfCopies,
              totalCopies: e.totalCopies,
              marketType: MarketType.AUCTION,
              typeImage: TypeImage.IMAGE,
              typeNFT: e.type == 0 ? TypeNFT.SOFT_NFT : TypeNFT.HARD_NFT,
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
            NftMarket(
              nftId: e.nftId ?? '',
              marketId: e.id ?? '',
              name: e.name ?? '',
              image: e.fileCid ?? '',
              price: e.price ?? 0,
              tokenBuyOut: e.token ?? '',
              reservePrice: e.reservePrice,
              buyOutPrice: e.buyOutPrice,
              numberOfCopies: e.numberOfCopies,
              totalCopies: e.totalCopies,
              marketType: MarketType.SALE,
              typeImage: TypeImage.IMAGE,
              typeNFT: e.type == 0 ? TypeNFT.SOFT_NFT : TypeNFT.HARD_NFT,
            ),
          ),
        );
      } else if (e.name == 'NFTs collateral') {
        e.items?.forEach(
          (e) => nftsCollateral.add(
              NftMarket(
                nftId: e.nftId ?? '',
                marketId: e.id ?? '',
                name: e.name ?? '',
                image: e.fileCid ?? '',
                price: e.price ?? 0,
                tokenBuyOut: e.token ?? '',
                reservePrice: e.reservePrice,
                buyOutPrice: e.buyOutPrice,
                numberOfCopies: e.numberOfCopies,
                totalCopies: e.totalCopies,
                marketType:  MarketType.PAWN,
                typeImage: TypeImage.IMAGE,
                typeNFT: e.type == 0 ? TypeNFT.SOFT_NFT : TypeNFT.HARD_NFT,
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
}
