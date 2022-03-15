import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/home_pawn/asset_filter_model.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'collateral_result_nft_state.dart';

class CollateralResultNFTBloc extends BaseCubit<CollateralResultNFTState> {
  CollateralResultNFTBloc() : super(CollateralResultInitial()) {
    getListCollectionFilter();
    getListAssetFilter();
    getTokenInf();
  }

  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<String> textAmountFrom = BehaviorSubject.seeded('');
  BehaviorSubject<String> textAmountTo = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isHard = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSort = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isMonth = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAmount = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isWeek = BehaviorSubject.seeded(false);
  List<NftMarket> list = [];
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;

  bool get canLoadMore => canLoadMoreMy;

  bool get isRefresh => _isRefresh;

  //search
  String loanSymbols = '';
  String durationTypes = '';
  String assetTypes = '';
  String collectionId = '';
  String durationQuantity = '';
  String loanAmountFrom = '';
  String loanAmountTo = '';
  String maximunLoanAmount = '';
  String types = '';
  String mess = '';

  BorrowRepository get _pawnService => Get.find();
  List<TokenModelPawn> listCollateralTokenFilter = [];
  List<TokenModelPawn> listCollection = [];
  List<TokenModelPawn> listAssetFilter = [];
  final regexAmount = RegExp(r'^\d+((.)|(.\d{0,5})?)$');

  List<TokenInf> listTokenSupport = [];

  //status
  String? checkStatus;
  String? searchStatus;
  String? amountFromStatus;
  String? amountToStatus;
  bool statusHard = false;
  bool statusSort = false;
  List<int> statusListAsset = [];
  List<int> statusListCollateral = [];
  List<int> statusListCollection = [];
  bool statusWeek = false;
  bool statusMonth = false;

  //
  bool checkStatusFirstFilter(int i, List<int> list) {
    for (final int value in list) {
      if (i == value) {
        return true;
      }
    }
    return false;
  }

  void statusFilterFirst() {
    if (checkStatus == null) {
      checkStatus = 'have';
    } else {
      textSearch.sink.add(searchStatus ?? '');
      textAmountTo.sink.add(amountToStatus ?? '');
      textAmountFrom.sink.add(amountFromStatus ?? '');
      for (int i = 0; i < listCollateralTokenFilter.length; i++) {
        if (checkStatusFirstFilter(i, statusListCollateral)) {
          listCollateralTokenFilter[i].isCheck = true;
        } else {
          listCollateralTokenFilter[i].isCheck = false;
        }
      }
      for (int i = 0; i < listCollection.length; i++) {
        if (checkStatusFirstFilter(i, statusListCollection)) {
          listCollection[i].isCheck = true;
        } else {
          listCollection[i].isCheck = false;
        }
      }
      for (int i = 0; i < listAssetFilter.length; i++) {
        if (checkStatusFirstFilter(i, statusListAsset)) {
          listAssetFilter[i].isCheck = true;
        } else {
          listAssetFilter[i].isCheck = false;
        }
      }
      isWeek.add(statusWeek);
      isMonth.add(statusMonth);
      isHard.add(statusHard);
      isSort.add(statusSort);
    }
  }

  void funReset() {
    textSearch.sink.add('');
    textAmountFrom.sink.add('');
    textAmountTo.sink.add('');
    for (final TokenModelPawn value in listAssetFilter) {
      if (value.isCheck) {
        value.isCheck = false;
      }
    }
    for (final TokenModelPawn value in listCollection) {
      if (value.isCheck) {
        value.isCheck = false;
      }
    }
    for (final TokenModelPawn value in listCollateralTokenFilter) {
      if (value.isCheck) {
        value.isCheck = false;
      }
    }
    isMonth.add(false);
    isWeek.add(false);
    isSort.add(false);
    isHard.add(false);
  }

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
    for (final TokenInf value in listTokenSupport) {
      listCollateralTokenFilter.add(
        TokenModelPawn(
          symbol: value.symbol,
          address: value.address,
          id: value.id.toString(),
          url: value.iconUrl,
        ),
      );
    }
  }

  void funFilter() {
    page = 0;
    statusListCollateral = [];
    statusListAsset = [];
    statusListCollection = [];
    loanSymbols = '';
    assetTypes = '';
    collectionId = '';
    for (int i = 0; i < listCollection.length; i++) {
      if (listCollection[i].isCheck) {
        statusListCollection.add(i);
        if (collectionId.isNotEmpty) {
          collectionId = '$collectionId,${listCollection[i].id ?? ''}';
        } else {
          collectionId = listCollection[i].id ?? '';
        }
      }
    }
    for (int i = 0; i < listAssetFilter.length; i++) {
      if (listAssetFilter[i].isCheck) {
        statusListAsset.add(i);
        if (assetTypes.isNotEmpty) {
          assetTypes = '$assetTypes,${listAssetFilter[i].id ?? ''}';
        } else {
          assetTypes = listAssetFilter[i].id ?? '';
        }
      }
    }
    for (int i = 0; i < listCollateralTokenFilter.length; i++) {
      if (listCollateralTokenFilter[i].isCheck) {
        statusListCollateral.add(i);
        if (loanSymbols.isNotEmpty) {
          loanSymbols =
              '$loanSymbols,${listCollateralTokenFilter[i].symbol ?? ''}';
        } else {
          loanSymbols = listCollateralTokenFilter[i].symbol ?? '';
        }
      }
    }
    if (isMonth.value && isWeek.value) {
      durationTypes = '$WEEK,$MONTH';
    } else if (!isMonth.value && isWeek.value) {
      durationTypes = '$WEEK';
    } else {
      durationTypes = '$MONTH';
    }
    if (isSort.value && isHard.value) {
      types =
          '${CollectionBloc.HARD_COLLECTION},${CollectionBloc.SOFT_COLLECTION}';
    } else if (!isSort.value && isHard.value) {
      types = '${CollectionBloc.HARD_COLLECTION}';
    } else {
      types = '${CollectionBloc.SOFT_COLLECTION}';
    }
    loanAmountFrom = textAmountFrom.value;
    loanAmountTo = textAmountTo.value;
    statusMonth = isMonth.value;
    statusWeek = isWeek.value;
    statusHard = isHard.value;
    statusSort = isSort.value;
    searchStatus = textSearch.value;
    amountFromStatus = textAmountFrom.value;
    amountToStatus = textAmountTo.value;
    //maximunLoanAmount= todo
    //durationQuantity
    getListCollateral();
  }

  void funValidateAmount(String value) {
    if (!regexAmount.hasMatch(value)) {
      isAmount.add(true);
    } else {
      isAmount.add(false);
    }
  }

  Future<void> refreshPosts() async {
    if (!_isLoading) {
      page = 0;
      _isRefresh = true;
      _isLoading = true;
      await getListCollateral();
    }
  }

  void funOnSearch(String value) {
    textSearch.sink.add(value);
  }

  void loadMorePosts() {
    if (!_isLoading) {
      page += 1;
      _isRefresh = false;
      _isLoading = true;
      getListCollateral();
    }
  }

  Future<void> getListCollateral() async {
    showLoading();
    emit(CollateralResultLoading());
    final Result<List<NftMarket>> response =
        await _pawnService.getListNFTCollateral(
      loanSymbols: loanSymbols,
      durationTypes: durationTypes,
      assetTypes: assetTypes,
      collectionId: collectionId,
      durationQuantity: durationQuantity,
      loanAmountFrom: loanAmountFrom,
      loanAmountTo: loanAmountTo,
      maximunLoanAmount: maximunLoanAmount,
      types: types,
      page: page.toString(),
      size: ApiConstants.DEFAULT_PAGE_SIZE.toString(),
    );
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          canLoadMoreMy = true;
        } else {
          canLoadMoreMy = false;
        }
        _isLoading = false;
        emit(
          CollateralResultSuccess(
            CompleteType.SUCCESS,
            listCollateral: response,
          ),
        );
      },
      error: (error) {
        emit(
          CollateralResultSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
        _isLoading = false;
      },
    );
  }

  Future<void> getListCollectionFilter() async {
    final Result<List<CollectionMarketModel>> response =
        await _pawnService.getListCollectionFilter();
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          response.map((e) {
            listCollection.add(
              TokenModelPawn(
                symbol: e.name,
                id: e.id,
                url: e.coverCid,
              ),
            );
          }).toList();
        }
      },
      error: (error) {},
    );
  }

  Future<void> getListAssetFilter() async {
    final Result<List<AssetFilterModel>> response =
        await _pawnService.getListAssetFilter();
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          response
              .map(
                (e) => listAssetFilter.add(
                  TokenModelPawn(
                    symbol: e.name,
                    id: e.id.toString(),
                  ),
                ),
              )
              .toList();
        }
      },
      error: (error) {},
    );
  }

  void funOnTapSearch() {
    textSearch.sink.add('');
  }
}
