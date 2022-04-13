import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_crypto_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_detail_crypto_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_detail_cryptp_collateral_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/user_infor_model.dart';
import 'package:Dfy/domain/repository/market_place/wallet_address_respository.dart';
import 'package:Dfy/domain/repository/pawn/offer_sent/offer_sent_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import 'package:Dfy/utils/extensions/string_extension.dart';

part 'offer_sent_list_state.dart';

class OfferSentListCubit extends BaseCubit<OfferSentListState> {
  OfferSentListCubit() : super(OfferSentListInitial()) {}

  ///DI
  OfferSentRepository get _offerSentService => Get.find();

  static const String PROCESSING_CREATE = '1';
  static const String ALL = '';
  static const String FAILED_CREATE = '2';
  static const String OPEN = '3';
  static const String PROCESSING_ACCEPT = '4';
  static const String PROCESSING_REJECT = '5';
  static const String PROCESSING_CANCEL = '6';
  static const String ACCEPTED = '7';
  static const String REJECTED = '8';
  static const String CANCELED = '9';

  ///need for call api
  ///0.Api get UserID
  String getEmailWallet() {
    late String currentEmail = '';
    final account = PrefsService.getWalletLogin();
    final Map<String, dynamic> mapLoginState = jsonDecode(account);
    if (mapLoginState.stringValueOrEmpty('accessToken') != '') {
      final userInfo = PrefsService.getUserProfile();
      final String wallet = PrefsService.getCurrentBEWallet();
      final Map<String, dynamic> mapProfileUser = jsonDecode(userInfo);
      if (mapProfileUser.stringValueOrEmpty('email') != '') {
        currentEmail = mapProfileUser.stringValueOrEmpty('email');
      } else {
        currentEmail = '';
      }
    }
    return currentEmail;
  }

  String userID = '';

  Future<String> getUserId() async {
    final Result<UserInfoModel> result = await _offerSentService.getUserId(
      email: getEmailWallet(),
      type: 1.toString(),
      walletAddress: PrefsService.getCurrentBEWallet(),
    );
    result.when(
      success: (success) {
        userID = success.userId.toString();
      },
      error: (error) {
        userID = '';
      },
    );
    return userID;
  }

  ///1.Api tab Crypto feat NFT
  String message = '';
  int page = 0;
  bool loadMore = false;
  bool canLoadMoreList = true;
  bool refresh = false;
  int defaultSize = 10;

  ///because tab NFT & CRYPTO same Api #type
  ///this func refresh var
  void refreshVariableApi() {
    message = '';
    page = 0;
    loadMore = false;
    canLoadMoreList = true;
    refresh = false;
    defaultSize = 10;
  }

  List<OfferSentCryptoModel> listOfferSentCrypto = [];
  List<OfferSentCryptoModel> listOfferSentNFT = [];

  Future<void> getListOfferSentCrypto({
    String? type,
    String? size,
    String? status,
    String? userId,
    String? sort,
    String? walletAddress,
  }) async {
    showLoading();
    final Result<List<OfferSentCryptoModel>> result =
        await _offerSentService.getListOfferSentCrypto(
      status: status,
      size: size ?? defaultSize.toString(),
      page: page.toString(),
      walletAddress: walletAddressFilter,
      type: type,
      userId: await getUserId(),
      sort: sort,
    );
    result.when(
      success: (success) {
        emit(
          LoadCryptoResult(
            CompleteType.SUCCESS,
            list: success,
          ),
        );
        showContent();
      },
      error: (error) {
        emit(
          LoadCryptoResult(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
        showContent();
      },
    );
  }

  Future<void> loadMoreGetListCrypto({
    String? type = '0',
    String? size,
    String? status,
    String? userId,
    String? sort,
    String? walletAddress,
  }) async {
    if (loadMore == false) {
      emit(LoadMoreCrypto());
      page += 1;
      canLoadMoreList = true;
      loadMore = true;
      await getListOfferSentCrypto(
        type: type,
        sort: sort,
        userId: userId,
        walletAddress: walletAddress,
        size: size,
        status: status,
      );
    } else {
      //nothing
    }
  }

  Future<void> refreshGetListOfferSentCrypto({String? type = '0'}) async {
    canLoadMoreList = true;
    if (refresh == false) {
      page = 0;
      refresh = true;
      await getListOfferSentCrypto(type: type);
    } else {
      //nothing
    }
  }

  bool refreshDetailCrypto = false;
  String messageDetailCrypto = '';

  ///api detail crypto
  ///START
  OfferSentDetailCryptoModel offerSentDetailCrypto =
      OfferSentDetailCryptoModel();
  OfferSentDetailCryptoCollateralModel offerSentDetailCryptoCollateral =
      OfferSentDetailCryptoCollateralModel();

  Future<void> callApiDetailCrypto({required String id}) async {
    await getOfferSentDetailCrypto(id: id);
    await getOfferSentDetailCryptoCollateral();
  }

  Future<void> getOfferSentDetailCrypto({String? id}) async {
    showLoading();
    final Result<OfferSentDetailCryptoModel> result =
        await _offerSentService.getOfferSentDetailCrypto(id: id);
    result.when(
      success: (response) {
        offerSentDetailCrypto = response;
      },
      error: (err) {
        GetApiDetalOfferSentCrypto(
          CompleteType.ERROR,
          message: err.message,
        );
      },
    );
  }

  Future<void> getOfferSentDetailCryptoCollateral({String? id}) async {
    final Result<OfferSentDetailCryptoCollateralModel> result =
        await _offerSentService.getOfferSentDetailCryptoCollateral(
      id: offerSentDetailCrypto.collateralId.toString(),
    );
    result.when(
      success: (response) {
        offerSentDetailCryptoCollateral = response;
        emit(
          GetApiDetalOfferSentCrypto(
            CompleteType.SUCCESS,
            detailCrypto: offerSentDetailCrypto,
            detailCryptoCollateral: offerSentDetailCryptoCollateral,
          ),
        );
      },
      error: (error) {
        GetApiDetalOfferSentCrypto(
          CompleteType.ERROR,
          message: error.message,
        );
      },
    );
  }

  ///end
  ///For Filter OfferSent
  ///start
  final List<Map<String, dynamic>> filterOriginalList = [
    {'isSelected': true, 'status': ALL},
    {'isSelected': false, 'status': PROCESSING_CREATE},
    {'isSelected': false, 'status': FAILED_CREATE},
    {'isSelected': false, 'status': OPEN},
    {'isSelected': false, 'status': PROCESSING_ACCEPT},
    {'isSelected': false, 'status': PROCESSING_REJECT},
    {'isSelected': false, 'status': PROCESSING_CANCEL},
    {'isSelected': false, 'status': ACCEPTED},
    {'isSelected': false, 'status': REJECTED},
    {'isSelected': false, 'status': CANCELED}
  ];

  WalletAddressRepository get _walletAddressRepository => Get.find();

  final List<Map<String, dynamic>> walletAddressDropDown = [
    {'value': '', 'label': 'All'}
  ];
  bool isGotWallet = false;

  BehaviorSubject<List<Map<String, dynamic>>> listWalletBHVSJ =
      BehaviorSubject();

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

  String statusFilter = '';
  String walletAddressFilter = PrefsService.getCurrentBEWallet();

  final List<Map<String, dynamic>> filterTmpList = [
    {'isSelected': true, 'status': ALL},
    {'isSelected': false, 'status': PROCESSING_CREATE},
    {'isSelected': false, 'status': FAILED_CREATE},
    {'isSelected': false, 'status': OPEN},
    {'isSelected': false, 'status': PROCESSING_ACCEPT},
    {'isSelected': false, 'status': PROCESSING_REJECT},
    {'isSelected': false, 'status': PROCESSING_CANCEL},
    {'isSelected': false, 'status': ACCEPTED},
    {'isSelected': false, 'status': REJECTED},
    {'isSelected': false, 'status': CANCELED}
  ];

  void pickJustOneFilter(int index) {
    for (final element in filterTmpList) {
      element['isSelected'] = false;
    }
    filterTmpList[index]['isSelected'] = true;
    statusFilter = filterTmpList[index]['status'];
    filterListBHVSJ.sink.add(filterTmpList);
  }

  void resetFilter() {
    filterListBHVSJ.sink.add(filterOriginalList);
  }

  BehaviorSubject<List<Map<String, dynamic>>> filterListBHVSJ =
      BehaviorSubject();

  ///End

  ///extension string
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

  String convertMilisecondsToString(int createAt) {
    final dt = DateTime.fromMillisecondsSinceEpoch(createAt);
    final d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt);
    return d24;
  }

  Future<void> putCryptoAfterConfirmBlockChain({required String id}) async {
    final result = await _offerSentService.putCryptoAfterCancel(id: id);
    result.when(success: (success) {}, error: (error) {});
  }
}
