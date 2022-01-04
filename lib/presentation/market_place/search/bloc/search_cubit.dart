import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/response/search_market/search_market_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/collection.dart';
import 'package:Dfy/domain/model/nft_item.dart';
import 'package:Dfy/domain/model/search_marketplace/list_search_collection_nft_model.dart';
import 'package:Dfy/domain/model/search_marketplace/search_collection_nft_model.dart';
import 'package:Dfy/domain/repository/search_market/search_market_repository.dart';
import 'package:Dfy/presentation/market_place/ui/market_place_screen.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_state.dart';

class SearchCubit extends BaseCubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  SearchMarketRepository get _searchMarketRepo => Get.find();

  final BehaviorSubject<bool> _isVisible = BehaviorSubject<bool>();

  Stream<bool> get isVisible => _isVisible.stream;

  void show() {
    _isVisible.sink.add(true);
  }

  void hide() {
    _isVisible.sink.add(false);
  }

  Future<void> getCollectionFeatNftBySearch({required String query}) async {
    emit(SearchLoading());
    final Result<List<ListSearchCollectionFtNftModel>> result =
        await _searchMarketRepo.getCollectionFeatNftSearch(name: query);
    result.when(
      success: (res) {
        responseToCollectionFtNftModel(res);
      },
      error: (error) {
        //todo handle error
        emit(SearchError());
      },
    );
  }

  List<SearchCollectionNftModel> collectionsSearch = [];
  List<SearchCollectionNftModel> nftsSearch = [];
  List<Collection> collections = [];
  List<NftItem> listNFT = [];


  void responseToCollectionFtNftModel(
    List<ListSearchCollectionFtNftModel> response,
  ) {
    for (final element in response) {
      if (element.name == 'Collection') {
        collectionsSearch = element.items ?? [];
        for (final element in collectionsSearch) {
          collections.add(
            Collection(
              items: int.parse(element.info ?? '0'),
              title: element.name ?? 'name',
              background:
                  ApiConstants.BASE_URL_IMAGE + (element.coverCid ?? ''),
              avatar: ApiConstants.BASE_URL_IMAGE + (element.imageCid ?? ''),
            ),
          );
        }
      } else {
        nftsSearch = element.items ?? [];
        for (final element in nftsSearch) {
          listNFT.add(
            NftItem(
              price: 0,
              name: element.name ?? 'name',
              image: ApiConstants.BASE_URL_IMAGE + (element.imageCid ?? 'url'),
              marketType: element.marketType == 'Auction'
                  ? MarketType.AUCTION
                  : (element.marketType == 'Sell'
                      ? MarketType.SALE
                      : MarketType.PAWN),
            ),
          );
        }
      }
    }
    if (collectionsSearch.length == 0 && nftsSearch.length == 0) {
      emit(SearchError());
    } else {
      emit(SearchSuccess());
    }
  }

  void clearCollectionsFtNftsAfterSearch() {
    collections.clear();
    listNFT.clear();
  }

  void search(String value) {
    emit(SearchLoading());
    Timer(const Duration(milliseconds: 500), () {
      emit(SearchSuccess());
    });
  }

  final BehaviorSubject<int> _lengthStream = BehaviorSubject<int>.seeded(3);

  Stream<int> get lengthStream => _lengthStream.stream;

  void showAllResult(int items) {
    _lengthStream.sink.add(items);
  }

  void dispose() {
    _lengthStream.close();
  }

  // List<Collection> collections = [
  //   Collection(
  //     background: 'http://placeimg.com/640/480',
  //     avatar: 'https://cdn.fakercloud.com/avatars/aaronalfred_128.jpg',
  //     title: 'Trinidad',
  //     items: 1000,
  //   ),
  //   Collection(
  //     background: 'http://placeimg.com/640/480',
  //     avatar: 'https://cdn.fakercloud.com/avatars/aaronalfred_128.jpg',
  //     title: 'Kyat',
  //     items: 1000,
  //   ),
  //   Collection(
  //     background: 'http://placeimg.com/640/480',
  //     avatar: 'https://cdn.fakercloud.com/avatars/aaronalfred_128.jpg',
  //     title: 'Zambian Kwacha',
  //     items: 1000,
  //   ),
  //   Collection(
  //     background: 'http://placeimg.com/640/480',
  //     avatar: 'https://cdn.fakercloud.com/avatars/bobwassermann_128.jpg',
  //     title: 'Pataca',
  //     items: 1000,
  //   ),
  //   Collection(
  //     background: 'http://placeimg.com/640/480',
  //     avatar: 'https://cdn.fakercloud.com/avatars/picard102_128.jpg',
  //     title: 'Trinidad',
  //     items: 1000,
  //   ),
  //   Collection(
  //     background: 'http://placeimg.com/640/480',
  //     avatar: 'https://cdn.fakercloud.com/avatars/supervova_128.jpg',
  //     title: 'Trinidad',
  //     items: 1000,
  //   ),
  // ];
  // List<NftItem> listNFT = [
  //   NftItem(
  //     name: 'Lamborghi',
  //     image: 'http://placeimg.com/640/480',
  //     price: 0,
  //     marketType: MarketType.AUCTION,
  //   ),
  //   NftItem(
  //     name: 'Lamborghin',
  //     image: 'http://placeimg.com/640/480',
  //     price: 10000,
  //     marketType: MarketType.PAWN,
  //   ),
  //   NftItem(
  //     name: ' Pink 21',
  //     image: 'http://placeimg.com/640/480',
  //     price: 10000,
  //     marketType: MarketType.SALE,
  //   ),
  // ];
}
