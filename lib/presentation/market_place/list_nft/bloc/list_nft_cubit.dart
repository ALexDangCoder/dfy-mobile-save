import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/collection_filter.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/repository/market_place/collection_filter_repo.dart';
import 'package:Dfy/domain/repository/market_place/nft_market_repo.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/nft_on_sale/ui/nft_list_on_sale/ui/components/ckc_filter.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'list_nft_state.dart';

class ListNftCubit extends BaseCubit<ListNftState> {
  ListNftCubit() : super(ListNftInitial());

  final BehaviorSubject<bool> isVisible = BehaviorSubject<bool>();
  final BehaviorSubject<bool> isVisibleAll = BehaviorSubject.seeded(true);
  final BehaviorSubject<List<CheckBoxFilter>> listCheckBox =
      BehaviorSubject<List<CheckBoxFilter>>();

  CollectionFilterRepository get _collectionRepo => Get.find();

  NftMarketRepository get _nftRepo => Get.find();

  Future<void> getCollectionFilter() async {
    final Result<List<CollectionFilter>> result =
        await _collectionRepo.getListCollection();
    result.when(
      success: (res) {
        addCollectionFilter(list: res);
      },
      error: (error) {
        updateStateError();
      },
    );
  }


  String status(MarketType type) {
    if(type == MarketType.AUCTION){
      return '2';
    }
    else if(type == MarketType.PAWN){
      return '3';
    }
    else {
      return '1';
    }
  }
   String typeNft(TypeNFT type) {
    if(type == TypeNFT.HARD_NFT){
      return '1';
    }
    else {
      return '0';
    }
   }

  Future<void> getListNft({
    String? status,
    String? nftType,
    String? name,
    String? collectionId,
  }) async {
    emit(ListNftLoading());
    final Result<List<NftMarket>> result = await _nftRepo.getListNft();
    result.when(
      success: (res) {
        listData = res;
        emit(ListNftSuccess());
      },
      error: (error) {
        updateStateError();
      },
    );
  }

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

  void addCollectionFilter({required List<CollectionFilter> list}) {
    for (final value in list) {
      listCollectionCheck.add(
        CheckBoxFilter(
          nameCkcFilter: value.name ?? '',
          typeCkc: TYPE_CKC_FILTER.HAVE_IMG,
          urlCover: value.avatarCid,
        ),
      );
    }
  }

  List<CheckBoxFilter> listCollectionCheck = [];

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

  List<NftMarket> listData = [];
}
