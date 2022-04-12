import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/home_pawn/pawn_shop_model.dart';
import 'package:Dfy/domain/model/pawn/manage_loan_package/pawnshop_package_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/user_infor_model.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/repository/pawn/manage_loan_package/manage_loan_package_repository.dart';
import 'package:Dfy/domain/repository/pawn/offer_sent/offer_sent_repository.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

part 'manage_loan_package_state.dart';

class ManageLoanPackageCubit extends BaseCubit<ManageLoanPackageState> {
  ManageLoanPackageCubit() : super(ManageLoanPackageInitial());

  OfferSentRepository get _offerSentService => Get.find();

  ManageLoanPackageRepository get _manageSettingService => Get.find();

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

  String _idPawnShop = '';

  Future<String> getIdPawnShopPackage() async {
    final Result<PawnShopModel> result =
        await _manageSettingService.getFindUserId(userId: await getUserId());
    result.when(
      success: (success) {
        _idPawnShop = success.id.toString();
      },
      error: (error) {
        _idPawnShop = '';
      },
    );
    return _idPawnShop;
  }

  int page = 0;
  bool loadMore = false;
  bool canLoadMoreList = true;
  bool refresh = false;
  int defaultSize = 10;

  List<PawnshopPackage> listPawnShop = [];

  Future<void> getListPawnShop() async {
    showLoading();
    final Result<List<PawnshopPackage>> result =
        await _manageSettingService.getListPawnShopPackage(
      id: await getIdPawnShopPackage(),
      size: defaultSize.toString(),
      page: page.toString(),
      walletAddress: 'all',
    );

    result.when(
      success: (success) {
        emit(
          ManageLoadApiListPawnShop(
            CompleteType.SUCCESS,
            list: success,
          ),
        );
      },
      error: (error) {
        emit(ManageLoadApiListPawnShop(CompleteType.ERROR));
      },
    );
  }


  ///FOR LENDING SETTING

  BehaviorSubject<String> txtWarningInterestMin = BehaviorSubject.seeded('');
  BehaviorSubject<String> txtWarningInterestMax = BehaviorSubject.seeded('');
}
