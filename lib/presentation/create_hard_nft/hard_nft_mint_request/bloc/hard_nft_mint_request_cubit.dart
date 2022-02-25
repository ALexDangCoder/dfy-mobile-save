import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/hard_nft_mint_request.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/history_tab.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'hard_nft_mint_request_state.dart';

class HardNftMintRequestCubit extends BaseCubit<HardNftMintRequestState> {
  HardNftMintRequestCubit() : super(HardNftMintRequestInitial());

  CreateHardNFTRepository get _createHardNFTRepository => Get.find();
  final BehaviorSubject<bool> isVisible = BehaviorSubject<bool>();

  BehaviorSubject<bool> checkStatusStream = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> checkAssetTypeStream = BehaviorSubject.seeded(false);

  List<TokenInf> listTokenSupport = [];

  void show() {
    isVisible.sink.add(true);
  }

  void hide() {
    isVisible.sink.add(false);
  }

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
  }

  ///Filter

  static const String ALL_ASSET = '';
  static const String JEWELRY = '0';
  static const String CAR = '4';
  static const String HOUSE = '3';
  static const String ARTWORK = '2';
  static const String WATCH = '1';
  static const String OTHERS = '5';
  static const String ALL_STATUS = '';
  static const String EVALUATED = '4';
  static const String UN_VALUATED = '2';
  static const String NFT_CREATED = '6';

  List<bool> listCheckAssetType = [
    false,
    false,
    false,
    false,
    false,
    false,
    true
  ];
  List<bool> cachedAssetType = [false, false, false, false, false, false, true];
  List<bool> listCheckStatus = [true, false, false, false];
  List<bool> cachedStatus = [true, false, false, false];
  bool apply = false;
  List<String> listStatus = [
    S.current.all,
    S.current.evaluated,
    S.current.un_evaluated,
    S.current.nft_created
  ];
  List<String> listAssetType = [
    S.current.jewelry,
    S.current.watch,
    S.current.art_work,
    S.current.house,
    S.current.car,
    S.current.others,
    S.current.all,
  ];

  void resetFilter() {
    listCheckAssetType = cachedAssetType;
    listCheckStatus = cachedStatus;
    checkAssetTypeStream.add(true);
    checkStatusStream.add(true);
  }

  bool checkAssetType(String name) {
    return listCheckAssetType[getIndexAsset(name)];
  }

  void setAsset(String name) {
    listCheckAssetType = List.filled(7, false);
    listCheckAssetType[getIndexAsset(name)] = true;
    checkAssetTypeStream.add(true);
  }

  int getIndexAsset(String name) {
    return listAssetType.indexWhere((element) => element == name);
  }

  bool checkStatus(String name) {
    return listCheckStatus[getIndexStatus(name)];
  }

  void setStatus(String name) {
    listCheckStatus = List.filled(4, false);
    listCheckStatus[getIndexStatus(name)] = true;
    checkStatusStream.add(true);
  }

  int getIndexStatus(String name) {
    return listStatus.indexWhere((element) => element == name);
  }

  int page = 1;
  bool loadMore = false;
  bool canLoadMoreList = true;
  bool refresh = false;
  String query = '';

  void loadMoreMintRequest() {
    if (!loadMore && !refresh) {
      page += 1;
      canLoadMoreList = true;
      loadMore = true;
      getListMintRequest(
        name: query,
        assetTypeId: assetType(getAssetTypeID()),
        status: status(getStatus()),
      );
    }
  }

  void refreshMintRequest() {
    canLoadMoreList = true;
    page = 1;
    if (!refresh) {
      refresh = true;
      getListMintRequest(
        name: query,
        assetTypeId: assetType(getAssetTypeID()),
        status: status(getStatus()),
      );
    }
  }

  void searchName(String query) {
    if (query != '') {
      getListMintRequest(name: query);
    }
  }

  String assetType(int index) {
    switch (index) {
      case 0:
        return JEWELRY;
      case 1:
        return WATCH;
      case 2:
        return ARTWORK;
      case 3:
        return HOUSE;
      case 4:
        return CAR;
      case 5:
        return OTHERS;
      default:
        return ALL_ASSET;
    }
  }

  int getAssetTypeID() {
    int index =0;
    if (apply) {
      for(int i = 0;i<listCheckAssetType.length;i++){
        if(listCheckAssetType[i] == true){
          index = i;
          break;
        }
        else {
          index = 0;
        }
      }
      return index;
    } else {
      for(int i = 0;i<listCheckAssetType.length;i++){
        if(listCheckAssetType[i] == true){
          index = i;
          break;
        }
        else {
          index = 0;
        }
      }
      return index;
    }
  }

  String status(int index){
    switch (index) {
      case 0:
        return ALL_STATUS;
      case 1:
        return EVALUATED;
      case 2:
        return UN_VALUATED;
      default:
        return NFT_CREATED;
    }
  }

  int getStatus() {
    int index = 0;
    if (apply) {
      for(int i = 0;i<listCheckStatus.length;i++){
        if(listCheckStatus[i] == true){
          index = i;
          break;
        }
        else {
          index = 0;
        }
      }
      return index;
    } else {
      for(int i = 0;i<listCheckStatus.length;i++){
        if(listCheckStatus[i] == true){
          index = i;
          break;
        }
        else {
          index = 0;
        }
      }
      return index;
    }
  }

  void filter() {
    apply = true;
    cachedStatus = listCheckStatus;
    cachedAssetType = listCheckAssetType;
    page = 1;
    canLoadMoreList = true;
    final String asset = assetType(getAssetTypeID());
    final String statusParam = status(getStatus());
    getListMintRequest(
      name: query,
      assetTypeId: asset,
      status: statusParam,
    );
  }

  Future<void> getListMintRequest({
    String? name,
    String? assetTypeId,
    String? status,
  }) async {
    showLoading();
    final Result<List<MintRequestModel>> result =
        await _createHardNFTRepository.getListMintRequestHardNFT(
      name ?? '',
      status ?? '',
      assetTypeId ?? '',
      page.toString(),
    );
    result.when(
      success: (res) {
        for (final element in res) {
          for (int i = 0; i < listTokenSupport.length; i++) {
            if (element.expectingPriceSymbol?.toLowerCase() ==
                listTokenSupport[i].symbol?.toLowerCase()) {
              element.urlToken = listTokenSupport[i].iconUrl;
            }
          }
        }
        if (res.isEmpty && loadMore) {
          canLoadMoreList = false;
        }
        if (loadMore) {
          emit(ListMintRequestLoadMoreSuccess(res));
          loadMore = false;
        } else if (refresh) {
          emit(ListMintRequestRefreshSuccess(res));
          refresh = false;
        } else {
          emit(ListMintRequestSuccess(res));
          loadMore = false;
        }
        showContent();
        apply = false;
      },
      error: (error) {
        loadMore = false;
        refresh = false;
        showError();
        apply = false;
      },
    );
  }
}
