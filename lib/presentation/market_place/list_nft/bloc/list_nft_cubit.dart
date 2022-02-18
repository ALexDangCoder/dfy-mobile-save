import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/collection_filter.dart';
import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/market_place/collection_filter_repo.dart';
import 'package:Dfy/domain/repository/market_place/nft_market_repo.dart';
import 'package:Dfy/domain/repository/market_place/wallet_address_respository.dart';
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
  final BehaviorSubject<String> addressStream = BehaviorSubject.seeded('');
  final BehaviorSubject<bool> isShowDropDownStream =
      BehaviorSubject.seeded(false);

  CollectionFilterRepository get _collectionRepo => Get.find();

  WalletAddressRepository get _walletAddressRepository => Get.find();

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

  void setTitle() {
    if (selectStatus.isEmpty || selectStatus.length > 1) {
      title.add('All NFT');
    } else {
      title.add(getTitleStream(selectStatus.first));
    }
  }

  String getTitleStream(int num) {
    if (num == 2) {
      selectStatus.add(2);
      return S.current.nft_on_auction;
    } else if (num == 3) {
      selectStatus.add(3);
      return S.current.nft_on_pawn;
    } else if (num == 1) {
      selectStatus.add(1);
      return S.current.nft_on_sell;
    } else {
      selectStatus.add(0);
      return S.current.not_on_market;
    }
  }

  String status(MarketType? type) {
    if (type == MarketType.AUCTION) {
      checkFilterArr.add(S.current.on_auction);
      selectStatus.add(2);
      return '2';
    } else if (type == MarketType.PAWN) {
      checkFilterArr.add(S.current.on_pawn);
      selectStatus.add(3);
      return '3';
    } else if (type == MarketType.SALE) {
      checkFilterArr.add(S.current.on_sell);
      selectStatus.add(1);
      return '1';
    } else if (type == MarketType.NOT_ON_MARKET) {
      checkFilterArr.add(S.current.not_on_market);
      selectStatus.add(0);
      return '0';
    } else {
      return '';
    }
  }

  String typeNft(TypeNFT type) {
    if (type == TypeNFT.HARD_NFT) {
      return '1';
    } else {
      return '0';
    }
  }

  void searchNft(
    String? name,
    String? status,
    PageRouter pageRouter,
  ) {
    page = 1;
    if (pageRouter == PageRouter.MARKET) {
      if (status!.isEmpty) {
        getListNft(
          name: name,
          pageRouter: PageRouter.MARKET,
        );
      } else if (name?.isNotEmpty ?? true && status.isNotEmpty) {
        getListNft(
          name: name,
          status: status,
          pageRouter: PageRouter.MARKET,
        );
      } else {
        getListNft(
          status: status,
          pageRouter: PageRouter.MARKET,
        );
      }
    } else {
      if (status!.isEmpty) {
        getListNft(
          name: name,
          walletAddress: walletAddress,
          pageRouter: PageRouter.MY_ACC,
        );
      } else if (name?.isNotEmpty ?? true && status.isNotEmpty) {
        getListNft(
          name: name,
          status: status,
          walletAddress: walletAddress,
          pageRouter: PageRouter.MY_ACC,
        );
      } else {
        getListNft(
          status: status,
          walletAddress: walletAddress,
          pageRouter: PageRouter.MY_ACC,
        );
      }
    }
  }

  int page = 1;
  bool loadMore = false;
  bool canLoadMoreListNft = true;
  bool refresh = false;

  void loadMorePosts(PageRouter pageRouter, String name) {
    checkStatus();
    if (pageRouter == PageRouter.MARKET) {
      if (!loadMore) {
        page += 1;
        canLoadMoreListNft = true;
        loadMore = true;
        getListNft(
          name: name,
          status: getParam(selectStatus),
          nftType: getParam(selectTypeNft),
          collectionId: getParam(selectCollection),
          pageRouter: PageRouter.MARKET,
        );
      }
    } else {
      if (!loadMore) {
        page += 1;
        canLoadMoreListNft = true;
        loadMore = true;
        getListNft(
          name: name,
          status: getParam(selectStatus),
          nftType: getParam(selectTypeNft),
          collectionId: getParam(selectCollection),
          walletAddress: walletAddress,
          pageRouter: PageRouter.MY_ACC,
        );
      }
    }
  }

  void refreshPosts(PageRouter pageRouter) {
    emit(ListNftLoading());
    checkStatus();
    canLoadMoreListNft = true;
    page = 1;
    if (pageRouter == PageRouter.MARKET) {
      if (!refresh) {
        refresh = true;
        getListNft(
          status: getParam(selectStatus),
          nftType: getParam(selectTypeNft),
          collectionId: getParam(selectCollection),
          pageRouter: PageRouter.MARKET,
        );
      }
    } else {
      if (!refresh) {
        refresh = true;
        getListNft(
          status: getParam(selectStatus),
          nftType: getParam(selectTypeNft),
          collectionId: getParam(selectCollection),
          walletAddress: walletAddress,
          pageRouter: PageRouter.MY_ACC,
        );
      }
    }
  }

  ///My account

  List<String> walletAddressFilter = [S.current.all];
  String walletAddress = '';
  bool showDropdownAddress = true;

  Future<void> getListWallet() async {
    final Result<List<WalletAddressModel>> result =
        await _walletAddressRepository.getListWalletAddress();
    result.when(
      success: (res) {
        if (res.isEmpty) {
        } else {
          res = res.where((element) => element.walletAddress != null).toList();
          if (res.length < 2) {
            for (final element in res) {
              walletAddressFilter.add(element.walletAddress ?? '');
            }
            showDropdownAddress = false;
          } else {
            for (final element in res) {
              walletAddressFilter.add(element.walletAddress ?? '');
            }
            showDropdownAddress = true;
          }
        }
      },
      error: (error) {},
    );
  }

  Future<void> getListNft({
    String? status,
    String? nftType,
    String? name,
    String? collectionId,
    String? walletAddress,
    required PageRouter pageRouter,
  }) async {
    if (loadMore) {
      emit(ListNftLoadMore());
    } else if (refresh) {
      emit(ListNftRefresh());
    } else {
      emit(ListNftLoading());
    }
    final Result<List<NftMarket>> result;
    if (pageRouter == PageRouter.MARKET) {
      result = await _nftRepo.getListNft(
        status: status,
        name: name,
        nftType: nftType,
        collectionId: collectionId,
        page: page.toString(),
      );
    } else {
      result = await _nftRepo.getListNftMyAcc(
        status: status![0],
        name: name,
        nftType: (nftType?.length == 4 || (nftType?.isEmpty ?? true))
            ? ''
            : nftType?[0],
        walletAddress: walletAddress == 'All'
            ? getParam(walletAddressFilter)
            : walletAddress,
        collectionId: '',
        page: page.toString(),
      );
    }
    result.when(
      success: (res) {
        for (final item in res) {
          final tokenBuyOut = item.tokenBuyOut ?? '';
          for (final value in listTokenSupport) {
            final address = value.address ?? '';
            final symbol = value.address ?? '';
            if (tokenBuyOut.toLowerCase() == address.toLowerCase() ||
                tokenBuyOut.toLowerCase() == symbol.toLowerCase()) {
              item.urlToken = value.iconUrl;
              item.symbolToken = value.symbol;
              item.usdExchange = value.usdExchange;
            }
          }
        }
        if (res.isEmpty && loadMore) {
          canLoadMoreListNft = false;
        }
        if (loadMore) {
          listData = listData + res;
          loadMore = false;
        } else {
          listData = res;
          refresh = false;
        }
        emit(ListNftSuccess());
      },
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          getListNft(
              status: status,
              nftType: nftType,
              name: name,
              collectionId: collectionId,
              walletAddress: walletAddress,
              pageRouter: pageRouter);
        } else {
          updateStateError();
          emit(ListNftError());
          loadMore = false;
          refresh = false;
        }
      },
    );
  }

  ///getListTokenSupport

  List<TokenInf> listTokenSupport = [];

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
  }

  ///Param Filter
  final List<int> selectTypeNft = [];

  void setCheck(
    List<int>? selectTypeNft,
    List<int>? selectStatus,
    List<String?> selectCollection,
  ) {
    for (final value in selectTypeNft ?? []) {
      if (value == 1) {
        checkFilterArr.add(S.current.hard_NFT);
      }
      if (value == 0) {
        checkFilterArr.add(S.current.soft_nft);
      }
    }
    for (final value in selectStatus ?? []) {
      if (value == 1) {
        checkFilterArr.add(S.current.on_sell);
      }
      if (value == 2) {
        checkFilterArr.add(S.current.on_auction);
      }
      if (value == 3) {
        checkFilterArr.add(S.current.on_pawn);
      }
      if (value == 0) {
        checkFilterArr.add(S.current.not_on_market);
      }
    }
    for (final value in selectCollection) {
      for (final address in listCollectionCheck) {
        if (value == address.collectionId) {
          checkFilterArr.add(address.nameCkcFilter);
        }
      }
    }
  }

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
    }
    if (type == S.current.soft_nft) {
      selectTypeNft.add(0);
    }
  }

  void moveParamTypeNft(String type) {
    if (type == S.current.hard_NFT) {
      selectTypeNft.remove(1);
    }
    if (type == S.current.soft_nft) {
      selectTypeNft.remove(0);
    }
  }

  final List<int> selectStatus = [];

  void checkStatus() {
    if (selectCollection.length > 1) {
      for (int i = 0; i < selectCollection.length - 1; i++) {
        for (int j = i + 1; j < selectCollection.length; j++) {
          if (selectCollection[i] == selectCollection[j]) {
            selectCollection.removeAt(j);
          }
        }
      }
    }

    if (selectStatus.length > 1) {
      for (int i = 0; i < selectStatus.length - 1; i++) {
        for (int j = i + 1; j < selectStatus.length; j++) {
          if (selectStatus[i] == selectStatus[j]) {
            selectStatus.removeAt(j);
          }
        }
      }
    }
    if (selectTypeNft.length > 1) {
      for (int i = 0; i < selectTypeNft.length - 1; i++) {
        for (int j = i + 1; j < selectTypeNft.length; j++) {
          if (selectTypeNft[i] == selectTypeNft[j]) {
            selectTypeNft.removeAt(j);
          }
        }
      }
    }
  }

  void selectParamStatus(String type) {
    if (type == S.current.on_sell) {
      selectStatus.add(1);
    }
    if (type == S.current.on_pawn) {
      selectStatus.add(3);
    }
    if (type == S.current.on_auction) {
      selectStatus.add(2);
    }
    if (type == S.current.not_on_market) {
      selectStatus.add(0);
    }
  }

  void moveParamStatus(String type) {
    if (type == S.current.on_sell) {
      selectStatus.remove(1);
    }
    if (type == S.current.on_pawn) {
      selectStatus.remove(3);
    }
    if (type == S.current.on_auction) {
      selectStatus.remove(2);
    }
    if (type == S.current.not_on_market) {
      selectStatus.remove(0);
    }
  }

  final List<String?> selectCollection = [];

  void selectParamCollection(String type) {
    for (final value in listCollectionCheck) {
      if (type == value.nameCkcFilter) {
        selectCollection.add(value.collectionId);
      }
    }
  }

  void moveParamCollection(String type) {
    for (final value in listCollectionCheck) {
      if (type == value.nameCkcFilter) {
        selectCollection.remove(value.collectionId);
      }
    }
  }

  List<String> checkFilterArr = [];

  bool checkFilter(String key) {
    if (checkFilterArr.isNotEmpty) {
      if (checkFilterArr.contains(key)) {
        return true;
      } else {
        return false;
      }
    } else {
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
    if (type == null) {
      return '${S.current.all} NFT';
    } else if (type == MarketType.SALE) {
      return S.current.nft_on_sell;
    } else if (type == MarketType.AUCTION) {
      return S.current.nft_on_auction;
    } else if (type == MarketType.NOT_ON_MARKET) {
      return S.current.not_on_market;
    } else {
      return S.current.nft_on_pawn;
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
