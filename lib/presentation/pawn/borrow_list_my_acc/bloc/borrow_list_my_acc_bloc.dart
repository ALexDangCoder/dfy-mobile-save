import 'dart:ui';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/home_pawn/crypto_pawn_model.dart';
import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/domain/repository/market_place/wallet_address_respository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'borrow_list_my_acc_state.dart';

class BorrowListMyAccBloc extends BaseCubit<BorrowListMyAccState> {
  BorrowListMyAccBloc() : super(BorrowListMyAccInitial()) {
    getListWallet();
  }

  BorrowRepository get _pawnService => Get.find();
  static const String CRYPTO_TYPE = '0';
  static const String NFT_TYPE = '1';
  bool checkWalletAddress = false;
  BehaviorSubject<bool> isChooseAcc = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAll = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isActive = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCompleted = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isDefault = BehaviorSubject.seeded(false);

  String mess = '';
  String estimate = '';
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;
  List<CryptoPawnModel> list = [];
  List<CryptoPawnModel> listNFT = [];
  BehaviorSubject<String> textAddressFilter = BehaviorSubject.seeded('all');

  bool get canLoadMore => canLoadMoreMy;

  bool get isRefresh => _isRefresh;

  WalletAddressRepository get _walletAddressRepository => Get.find();
  String type = CRYPTO_TYPE;

  //history
  static const int ACTIVE = 1;
  static const int COMPLETED = 2;
  static const int DEFAULT = 3;

//statusWallet
  String? statusWallet;
  String? statusWalletNFT;
  List<String> listAcc = [
    S.current.all,
  ];
  String? checkStatus;
  String textAddress = 'all';
  String textAddressNFT = 'all';
  bool statusAllFilter = false;
  bool statusCompletedFilter = false;
  bool statusDefaultFilter = false;
  bool statusActiveFilter = false;
  String? status;
  bool statusAllFilterNFT = false;
  bool statusCompletedFilterNFT = false;
  bool statusDefaultFilterNFT = false;
  bool statusActiveFilterNFT = false;
  String? statusNFT;

  void funFilter() {
    if (type == CRYPTO_TYPE) {
      statusAllFilter = isAll.value;
      statusCompletedFilter = isCompleted.value;
      statusDefaultFilter = isDefault.value;
      statusActiveFilter = isActive.value;
      statusWallet = textAddressFilter.value;
      status = '';
    } else {
      statusAllFilterNFT = isAll.value;
      statusCompletedFilterNFT = isCompleted.value;
      statusDefaultFilterNFT = isDefault.value;
      statusActiveFilterNFT = isActive.value;
      statusWalletNFT = textAddressFilter.value;
      statusNFT = '';
    }

    if (isCompleted.value) {
      status = COMPLETED.toString();
      statusNFT = COMPLETED.toString();
    } else if (isDefault.value) {
      status = DEFAULT.toString();
      statusNFT = DEFAULT.toString();
    } else if (isActive.value) {
      status = ACTIVE.toString();
      statusNFT = ACTIVE.toString();
    } else if (isAll.value) {
      status = null;
      statusNFT = null;
    } else {
      status = null;
      statusNFT = null;
    }

    if (textAddressFilter.value == S.current.all) {
      textAddress = 'all';
      textAddressNFT = 'all';
    } else {
      textAddress = textAddressFilter.value.toLowerCase();
      textAddressNFT = textAddressFilter.value.toLowerCase();
    }
    getBorrowContract(
      type: type,
    );
  }

  void statusFilterFirst() {
    if (checkStatus == null) {
      checkStatus = 'have';
    } else {
      if (type == CRYPTO_TYPE) {
        textAddressFilter.add(statusWallet ?? '');
        isAll.add(statusAllFilter);
        isDefault.add(statusDefaultFilter);
        isCompleted.add(statusCompletedFilter);
        isActive.add(statusActiveFilter);
      } else {
        textAddressFilter.add(statusWalletNFT ?? '');
        isAll.add(statusAllFilterNFT);
        isDefault.add(statusDefaultFilterNFT);
        isCompleted.add(statusCompletedFilterNFT);
        isActive.add(statusActiveFilterNFT);
      }
    }
  }

  void funReset() {
    if (listAcc.length > 2) {
      textAddressFilter.add(S.current.all);
    }
    isActive.add(false);
    isCompleted.add(false);
    isDefault.add(false);
    isAll.add(false);
  }

  void check(String title) {
    if (title == S.current.all) {
      isDefault.add(false);
      isCompleted.add(false);
      isActive.add(false);
      isAll.add(true);
    } else if (title == S.current.active) {
      isDefault.add(false);
      isCompleted.add(false);
      isActive.add(true);
      isAll.add(false);
    } else if (title == S.current.completed) {
      isDefault.add(false);
      isCompleted.add(true);
      isActive.add(false);
      isAll.add(false);
    } else if (title == S.current.defaults) {
      isDefault.add(true);
      isCompleted.add(false);
      isActive.add(false);
      isAll.add(false);
    }
  }

  String checkAddress(String address) {
    String data = '';
    if (address == S.current.all) {
      data = S.current.all;
    } else {
      if (address.length > 20) {
        data = address.formatAddressWalletConfirm();
      }
    }
    return data;
  }

  void chooseAddressFilter(String address) {
    textAddressFilter.sink.add(
      address,
    );
    isChooseAcc.sink.add(false);
  }

  String checkNullAddressWallet(String address) {
    String addressWallet = '';
    if (address.length < 20) {
      addressWallet = address;
    } else {
      addressWallet = address.formatAddressWalletConfirm();
    }
    return addressWallet;
  }

  Future<void> getListWallet() async {
    final Result<List<WalletAddressModel>> result =
        await _walletAddressRepository.getListWalletAddress();
    result.when(
      success: (res) {
        if (res.isEmpty) {
          checkWalletAddress = false;
        } else {
          statusWallet = PrefsService.getCurrentWalletCore();
          if (res.length < 2) {
            for (final element in res) {
              if (element.walletAddress?.isNotEmpty ?? false) {
                listAcc.add(element.walletAddress ?? '');
              }
            }
            textAddress = PrefsService.getCurrentWalletCore();
            checkWalletAddress = false;
            textAddressFilter.add(PrefsService.getCurrentWalletCore());
          } else {
            for (final element in res) {
              if (element.walletAddress?.isNotEmpty ?? false) {
                listAcc.add(element.walletAddress ?? '');
              }
            }
            textAddress = 'all';
            checkWalletAddress = true;
            textAddressFilter.add(S.current.all);
          }
        }
      },
      error: (error) {
        textAddress = PrefsService.getCurrentWalletCore();
        textAddressFilter.add(PrefsService.getCurrentWalletCore());
        if (error.code == CODE_ERROR_AUTH) {
          getListWallet();
        }
      },
    );
  }

  String getStatus(int type) {
    switch (type) {
      case ACTIVE:
        return S.current.active;
      case COMPLETED:
        return S.current.completed;
      case DEFAULT:
        return S.current.defaults;
      default:
        return '';
    }
  }

  Color getColor(int type) {
    switch (type) {
      case ACTIVE:
        return AppTheme.getInstance().greenMarketColors();
      case COMPLETED:
        return AppTheme.getInstance().blueMarketColors();
      case DEFAULT:
        return AppTheme.getInstance().redColor();
      default:
        return AppTheme.getInstance().redColor();
    }
  }

  Future<void> refreshPosts({
    required String type,
  }) async {
    if (!_isLoading) {
      page = 0;
      _isRefresh = true;
      _isLoading = true;
      await getBorrowContract(
        type: type,
      );
    }
  }

  void loadMorePosts({
    required String type,
  }) {
    if (!_isLoading) {
      page += 1;
      _isRefresh = false;
      _isLoading = true;
      getBorrowContract(
        type: type,
      );
    }
  }

  Future<void> getBorrowContract({
    String? type,
    String? borrowerWalletAddress,
  }) async {
    showLoading();
    if (type == NFT_TYPE) {
      emit(BorrowListMyAccLoading());
    } else {
      emit(BorrowListMyAccNFTLoading());
    }
    final Result<List<CryptoPawnModel>> response =
        await _pawnService.getBorrowContract(
      size: ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      page: page.toString(),
      type: type,
      borrowerWalletAddress: textAddress,
      status: status,
    );
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          canLoadMoreMy = true;
        } else {
          canLoadMoreMy = false;
        }
        _isLoading = false;
        if (type == NFT_TYPE) {
          emit(
            BorrowListMyAccNFTSuccess(
              CompleteType.SUCCESS,
              listNFT: response,
            ),
          );
        } else {
          emit(
            BorrowListMyAccSuccess(
              CompleteType.SUCCESS,
              list: response,
            ),
          );
        }
      },
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          getBorrowContract(type: type, borrowerWalletAddress: textAddress);
        }
        if (type == NFT_TYPE) {
          emit(
            BorrowListMyAccNFTSuccess(
              CompleteType.ERROR,
              message: error.message,
            ),
          );
        } else {
          emit(
            BorrowListMyAccSuccess(
              CompleteType.ERROR,
              message: error.message,
            ),
          );
        }
        _isLoading = false;
      },
    );
  }
}
