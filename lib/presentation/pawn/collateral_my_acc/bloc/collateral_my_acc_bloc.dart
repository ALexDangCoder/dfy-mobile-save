import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/domain/repository/market_place/wallet_address_respository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/bloc/collateral_my_acc_state.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CollateralMyAccBloc extends BaseCubit<CollateralMyAccState> {
  static const int PROCESSING_CREATE = 1;
  static const int FAIL_CREATE = 2;
  static const int OPEN = 3;
  static const int PROCESSING_ACCEPT = 4;
  static const int PROCESSING_WITHDRAW = 5;
  static const int ACCEPTED = 6;
  static const int WITHDRAW = 7;
  static const int FAILED = 8;
  bool checkWalletAddress = false;
  BehaviorSubject<bool> isChooseAcc = BehaviorSubject.seeded(false);
  BehaviorSubject<String> textAddressFilter =
      BehaviorSubject.seeded(S.current.all);

  WalletAddressRepository get _walletAddressRepository => Get.find();

  List<String> listAcc = [
    S.current.all,
  ];

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
          if (res.length < 2) {
            for (final element in res) {
              if (element.walletAddress?.isNotEmpty ?? false) {
                listAcc.add(element.walletAddress ?? '');
              }
            }
            checkWalletAddress = false;
          } else {
            for (final element in res) {
              if (element.walletAddress?.isNotEmpty ?? false) {
                listAcc.add(element.walletAddress ?? '');
              }
            }
            checkWalletAddress = true;
          }
        }
      },
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          getListWallet();
        }
      },
    );
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

  CollateralMyAccBloc() : super(CollateralMyAccInitial());
  String mess = '';
  String walletAddress = PrefsService.getCurrentWalletCore();
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;
  List<CollateralResultModel> list = [];

  bool get canLoadMore => canLoadMoreMy;

  BorrowRepository get _pawnService => Get.find();

  bool get isRefresh => _isRefresh;

  Future<void> refreshPosts() async {
    if (!_isLoading) {
      page = 0;
      _isRefresh = true;
      _isLoading = true;
      await getListCollateral();
    }
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
    emit(CollateralMyAccLoading());
    final Result<List<CollateralResultModel>> response =
        await _pawnService.getListCollateralMyAcc(
      page: page.toString(),
      size: ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      walletAddress: walletAddress,
      sort: 'id,desc',
      collateralCurrencySymbol: '',
      status: '',
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
          CollateralMyAccSuccess(
            CompleteType.SUCCESS,
            listCollateral: response,
          ),
        );
      },
      error: (error) {
        emit(
          CollateralMyAccSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
        _isLoading = false;
      },
    );
  }
}
