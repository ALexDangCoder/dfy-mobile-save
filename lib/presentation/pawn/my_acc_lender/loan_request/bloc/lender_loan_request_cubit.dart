import 'dart:ui';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/loan_request_crypto_item_model.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/market_place/wallet_address_respository.dart';
import 'package:Dfy/domain/repository/pawn/loan_request/loan_request_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/offer_sent_list_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

part 'lender_loan_request_state.dart';

class LenderLoanRequestCubit extends BaseCubit<LenderLoanRequestState> {
  LenderLoanRequestCubit() : super(LenderLoanRequestInitial());

  ///di
  LoanRequestRepository get _service => Get.find();

  static const String ACTIVE = '1';
  static const String ALL = '';
  static const String COMPLETE = '2';
  static const String DEFAULT = '3';

  static const String FILTER_ALL = '';
  static const String FILTER_OPEN = '1';
  static const String FILTER_REJECT = '5';
  static const String FILTER_ACCEPT = '3';
  static const String FILTER_CANCEL = '7';

  String filterWalletAddress = FILTER_ALL;
  String filterCollateral = FILTER_ALL;
  String filterStatus = FILTER_ALL;
  String nftTypeFilter = '';

  ///Api for tab crypto
  int page = 0;
  bool loadMore = false;
  bool canLoadMoreList = true;
  bool refresh = false;
  int defaultSize = 10;

  List<LoanRequestCryptoModel> crypoList = [];
  List<LoanRequestCryptoModel> nftList = [];

  ///call Api Nft
  Future<void> getListNftApi() async {
    showLoading();
    final Result<List<LoanRequestCryptoModel>> result =
        await _service.getListNftLoanRequest(
      status: filterStatus.isEmpty ? null : filterStatus,
      walletAddress: filterWalletAddress.isEmpty ? null : filterWalletAddress,
      page: page.toString(),
      size: defaultSize.toString(),
      nftType: nftTypeFilter.isEmpty ? null : nftTypeFilter,
    );

    result.when(
      success: (response) {
        emit(
          LoadLoanRequestResult(CompleteType.SUCCESS, list: response),
        );
        showContent();
      },
      error: (error) {
        emit(
          LoadLoanRequestResult(
            CompleteType.ERROR,
          ),
        );
        showContent();
      },
    );
  }

  ///call Api Crypto
  Future<void> getListCryptoApi() async {
    showLoading();
    final Result<List<LoanRequestCryptoModel>> result =
        await _service.getListCryptoLoanRequest(
      status: filterStatus.isEmpty ? null : filterStatus,
      walletAddress: filterWalletAddress.isEmpty ? null : filterWalletAddress,
      size: defaultSize.toString(),
      page: page.toString(),
      collateral: filterCollateral.isEmpty ? null : filterCollateral,
      p2p: 'true',
    );
    result.when(
      success: (success) {
        emit(
          LoadLoanRequestResult(CompleteType.SUCCESS, list: success),
        );
        showContent();
      },
      error: (error) {
        emit(
          LoadLoanRequestResult(
            CompleteType.ERROR,
          ),
        );
        showContent();
      },
    );
  }

  Future<void> loadMoreGetListCrypto() async {
    if (loadMore == false) {
      emit(LoadMoreCrypto());
      page += 1;
      canLoadMoreList = true;
      loadMore = true;
      await getListCryptoApi();
    } else {
      //nothing
    }
  }

  Future<void> refreshGetListNftLoanRequest() async {
    canLoadMoreList = true;
    if (refresh == false) {
      page = 0;
      refresh = true;
      await getListNftApi();
    } else {
      //nothing
    }
  }

  Future<void> refreshGetListOfferSentCrypto() async {
    canLoadMoreList = true;
    if (refresh == false) {
      page = 0;
      refresh = true;
      await getListCryptoApi();
    } else {
      //nothing
    }
  }

  ///because tab NFT & CRYPTO same Api #type
  ///this func refresh var
  void refreshVariableApi() {
    page = 0;
    loadMore = false;
    canLoadMoreList = true;
    refresh = false;
    defaultSize = 10;
  }

  String categoryOneOrMany({
    required int durationQty,
    required int durationType,
  }) {
    //0 is week
    //1 month
    if (durationType == 0) {
      if (durationQty > 1) {
        return '$durationQty ${S.current.week_many}';
      } else {
        return '$durationQty ${S.current.week_1}';
      }
    } else {
      if (durationQty > 1) {
        return '$durationQty ${S.current.month_many}';
      } else {
        return '$durationQty ${S.current.month_1}';
      }
    }
  }

  static const int PROCESSING_OPEN = 0;
  static const int OPEN = 1;
  static const int PROCESSING_ACCEPT = 2;
  static const int ACCEPT = 3;
  static const int PROCESSING_REJECT = 4;
  static const int REJECT = 5;
  static const int PROCESSING_WITHDRAW = 6;
  static const int CANCEL = 7;
  static const int PROCESSING_CONTRACTED = 8;
  static const int CONTRACTED = 9;
  static const int END_CONTRACT = 10;

  String getStatus(String type) {
    switch (int.parse(type)) {
      case OPEN:
        return S.current.open;
      case ACCEPT:
        return S.current.accepted;
      case REJECT:
        return S.current.rejected;
      case CANCEL:
        return S.current.canceled;
      default:
        return '';
    }
  }

  Color getColor(String type) {
    switch (int.parse(type)) {
      case OPEN:
        return AppTheme.getInstance().blueColor();
      case ACCEPT:
        return AppTheme.getInstance().successTransactionColors();
      case REJECT:
        return AppTheme.getInstance().redMarketColors();
      case CANCEL:
        return AppTheme.getInstance().failTransactionColors();
      default:
        return orangeColor;
    }
  }

  List<Map<String, dynamic>> durationList = [
    {
      'value': 'month',
      'label': 'month',
    },
    {
      'value': 'week',
      'label': 'week',
    }
  ];

  ///FILTER

  BehaviorSubject<List<Map<String, dynamic>>> listWalletBHVSJ =
      BehaviorSubject();

  final List<Map<String, dynamic>> walletAddressDropDown = [
    {'value': '', 'label': 'All'}
  ];

  Map<String, dynamic> tempWalletFilter = {'value': '', 'label': 'null'};

  WalletAddressRepository get _walletAddressRepository => Get.find();
  bool isGotWallet = false;

  Future<void> getListWallet() async {
    if (isGotWallet) {
    } else {
      final Result<List<WalletAddressModel>> result =
          await _walletAddressRepository.getListWalletAddress();
      result.when(
        success: (res) {
          for (final element in res) {
            if ((element.walletAddress ?? '') ==
                    PrefsService.getCurrentBEWallet() ||
                (element.walletAddress ?? '').isEmpty) {
            } else {
              walletAddressDropDown.add(
                {
                  'value': element.walletAddress ?? '',
                  'label': (element.walletAddress ?? '').formatAddressWallet(),
                },
              );
            }
          }
          listWalletBHVSJ.sink.add(walletAddressDropDown);
        },
        error: (error) {
          walletAddressDropDown.add(
            {
              'value': PrefsService.getCurrentBEWallet(),
              'label': PrefsService.getCurrentBEWallet().formatAddressWallet(),
            },
          );
          listWalletBHVSJ.sink.add(walletAddressDropDown);
        },
      );
      isGotWallet = true;
    }
  }

  ///for tab crypto
  List<TokenInf> listTokenSupport = [];

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
    // for (final element in listTokenSupport) {
    //   if (element.symbol == USDT ||
    //       element.symbol == BNB ||
    //       element.symbol == DFY) {
    //     tokensMap.add(
    //       {
    //         'value': element.id,
    //         'label': element.symbol,
    //         'symbol': element.symbol ?? DFY,
    //         'icon': SizedBox(
    //           width: 20.w,
    //           height: 20.h,
    //           child: Image.network(
    //             ImageAssets.getSymbolAsset(
    //               element.symbol ?? DFY,
    //             ),
    //           ),
    //         ),
    //       },
    //     );
    //   }
    //   if (tokensMap.isEmpty) {
    //     tokensMap.add(
    //       {
    //         'label': DFY,
    //         'icon': SizedBox(
    //           width: 20.w,
    //           height: 20.h,
    //           child: Image.network(
    //             ImageAssets.getSymbolAsset(
    //               element.symbol ?? DFY,
    //             ),
    //           ),
    //         ),
    //       },
    //     );
    //   }
    // }
  }
}
