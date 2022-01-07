import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/collection_filter.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/repository/market_place/collection_filter_repo.dart';
import 'package:Dfy/domain/repository/market_place/nft_market_repo.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/nft_detail/ui/component/ckc_filter.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'list_nft_state.dart';

class ListNftCubit extends BaseCubit<ListNftState> {
  ListNftCubit() : super(ListNftInitial());

  final BehaviorSubject<bool> isVisible = BehaviorSubject<bool>();
  final BehaviorSubject<String> title = BehaviorSubject.seeded('');
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
        selectCollection.clear();
        selectTypeNft.clear();
        selectStatus.clear();
      },
      error: (error) {
        updateStateError();
      },
    );
  }

  void setTitle(){
    if(selectStatus.isEmpty || selectStatus.length >1){
      title.add('All NFT');
    }
    else{
      title.add(getTitleStream(selectStatus.first));
    }
  }
  String getTitleStream(int num){
    if (num  == 2) {
      return S.current.nft_on_auction;
    } else if (num == 3) {
      return S.current.nft_on_pawn;
    } else {
      return S.current.nft_on_sale;
    }
  }

  String status(MarketType type) {
    if (type == MarketType.AUCTION) {
      return '2';
    } else if (type == MarketType.PAWN) {
      return '3';
    } else {
      return '1';
    }
  }

  String typeNft(TypeNFT type) {
    if (type == TypeNFT.HARD_NFT) {
      return '1';
    } else {
      return '0';
    }
  }

  void searchNft(String? name, String? status) {
    if (name?.isNotEmpty ?? true) {
      getListNft(name: name, status: status);
    } else {
      getListNft(status: status);
    }
  }

  Future<void> getListNft({
    String? status,
    String? nftType,
    String? name,
    String? collectionId,
  }) async {
    emit(ListNftLoading());
    final Result<List<NftMarket>> result = await _nftRepo.getListNft(
      status: status,
      name: name,
      nftType: nftType,
      collectionId: collectionId,
    );
    result.when(
      success: (res) {
        listData = res;
        emit(ListNftSuccess());
      },
      error: (error) {
        updateStateError();
        emit(ListNftError());
      },
    );
  }

  ///Param Filter
  final List<int> selectTypeNft = [];

  String getParam(List<dynamic> list) {
    final query = StringBuffer();
    for (final value in list) {
      query.write('$value,');
    }
    return query.toString();
  }

  void selectParamTypeNft(String type) {
    if (type == S.current.hard_NFT) {
      selectTypeNft.add(1);
      checkFilterArr.add(type);
    }
    if (type == S.current.soft_nft) {
      selectTypeNft.add(0);
      checkFilterArr.add(type);
    }
  }

  void moveParamTypeNft(String type) {
    if (type == S.current.hard_NFT) {
      selectTypeNft.remove(1);
      checkFilterArr.remove(type);
    }
    if (type == S.current.soft_nft) {
      selectTypeNft.remove(0);
      checkFilterArr.remove(type);
    }
  }

  final List<int> selectStatus = [];

  void selectParamStatus(String type) {
    if (type == S.current.on_sale) {
      selectStatus.add(1);
      checkFilterArr.add(type);
    }
    if (type == S.current.on_pawn) {
      selectStatus.add(3);
      checkFilterArr.add(type);
    }
    if (type == S.current.on_auction) {
      selectStatus.add(2);
      checkFilterArr.add(type);
    }
  }

  void moveParamStatus(String type) {
    if (type == S.current.on_sale) {
      selectStatus.remove(1);
      checkFilterArr.remove(type);
    }
    if (type == S.current.on_pawn) {
      selectStatus.remove(3);
      checkFilterArr.remove(type);
    }
    if (type == S.current.on_auction) {
      selectStatus.remove(2);
      checkFilterArr.remove(type);
    }
  }

  final List<String?> selectCollection = [];

  void selectParamCollection(String type) {
    for(final value in listCollectionCheck) {
      if(type == value.nameCkcFilter){
        selectCollection.add(value.collectionId);
        checkFilterArr.add(type);
      }
    }
  }

  void moveParamCollection(String type) {
    for(final value in listCollectionCheck) {
      if(type == value.nameCkcFilter){
        selectCollection.remove(value.collectionId);
        checkFilterArr.remove(type);
      }
    }
  }

  List<String> checkFilterArr = [];


  bool checkFilter(String key) {
    if(checkFilterArr.isNotEmpty){
      if(checkFilterArr.contains(key)){
        return true;
      } else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  ///

  void show() {
    isVisible.sink.add(true);
  }

  void hide() {
    isVisible.sink.add(false);
    listCheckBox.add(listCollectionCheck);
  }

  String getTitle(MarketType? type) {
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
          filterType: '',
          collectionId: value.id,
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
    } else {
      listCheckBox.add(search);
    }
  }

  List<NftMarket> listData = [];
}
