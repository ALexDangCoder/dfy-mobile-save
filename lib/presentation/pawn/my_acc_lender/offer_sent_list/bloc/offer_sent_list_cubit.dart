import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_crypto_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_detail_crypto_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_detail_cryptp_collateral_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/user_infor_model.dart';
import 'package:Dfy/domain/repository/pawn/offer_sent/offer_sent_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

part 'offer_sent_list_state.dart';

class OfferSentListCubit extends BaseCubit<OfferSentListState> {
  OfferSentListCubit() : super(OfferSentListInitial());

  ///DI
  OfferSentRepository get _offerSentService => Get.find();

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

  ///1.Api tab crypto
  String message = '';
  int page = 0;
  bool loadMore = false;
  bool canLoadMoreList = true;
  bool refresh = false;
  int defaultSize = 10;
  List<OfferSentCryptoModel> listOfferSentCrypto = [];

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
      walletAddress: PrefsService.getCurrentBEWallet(),
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

  //todo need to fix parram
  Future<void> loadMoreGetListCrypto({
    String? type,
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

  Future<void> refreshGetListOfferSentCrypto() async {
    canLoadMoreList = true;
    if (refresh == false) {
      page = 0;
      refresh = true;
      await getListOfferSentCrypto();
    } else {
      //nothing
    }
  }

  bool refreshDetailCrypto = false;
  String messageDetailCrypto = '';

  ///api detail crypto
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

  ///filter
  List<Map<String, dynamic>> fakeDataWallet = [
    {
      'value': '1',
      'label': 'wallet 1',
    },
    {
      'value': '2',
      'label': 'wallet 2',
    },
    {
      'value': '3',
      'label': 'wallet 3',
    }
  ];
}
