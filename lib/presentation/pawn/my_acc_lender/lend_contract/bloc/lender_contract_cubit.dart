import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/pawn/lender_contract/lender_contract_nft_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/user_infor_model.dart';
import 'package:Dfy/domain/repository/pawn/lender_contract/lender_contract_repository.dart';
import 'package:Dfy/domain/repository/pawn/offer_sent/offer_sent_repository.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/ui/components/tab_nft/lender_contract_nft.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'lender_contract_state.dart';

class LenderContractCubit extends BaseCubit<LenderContractState> {
  LenderContractCubit() : super(LenderContractInitial());

  ///DI
  OfferSentRepository get _offerSentService => Get.find();

  LenderContractRepository get _lenderContractService => Get.find();

  ///get UserId
  String userID = '';
  List<LenderContractNftModel> listNftLenderContract = [];

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

  String walletAddressFilter = PrefsService.getCurrentBEWallet();

  ///1.Api tab Crypto feat NFT not confirm
  ///1.Api tab  NFT temp
  String message = '';
  int page = 0;
  bool loadMore = false;
  bool canLoadMoreList = true;
  bool refresh = false;
  int defaultSize = 12;

  void refreshVariableApi() {
    message = '';
    page = 0;
    loadMore = false;
    canLoadMoreList = true;
    refresh = false;
    defaultSize = 12;
  }

  ///call api tab nft
  Future<void> getListNft({
    String? type,
    String? size,
    String? status,
    String? userId,
    String? sort,
    String? walletAddress,
  }) async {
    showLoading();
    final Result<List<LenderContractNftModel>> result =
        await _lenderContractService.getListOfferSentCrypto(
      status: status,
      type: type,
      walletAddress: walletAddress ?? walletAddressFilter,
      userId: await getUserId(),
      size: size ?? defaultSize.toString(),
      sort: sort,
      page: page.toString(),
    );
    result.when(
      success: (success) {
        emit(LoadCryptoFtNftResult(CompleteType.SUCCESS, list: success));
      },
      error: (error) {
        emit(
          LoadCryptoFtNftResult(
            CompleteType.ERROR,
          ),
        );
        showContent();
      },
    );
  }

  Future<void> loadMoreGetListNft({
    //todo đúng quy trình gọi 0 call crypto trước
    String? type = '1',
    String? size,
    String? status,
    String? userId,
    String? sort,
    String? walletAddress,
  }) async {
    if (loadMore == false) {
      emit(LoadMoreNFT());
      page += 1;
      canLoadMoreList = true;
      loadMore = true;
      await getListNft(
        type: type,
        sort: sort,
        size: size,
        userId: userId,
        walletAddress: walletAddress,
        status: status,
      );
    } else {

    }
  }

  Future<void> refreshGetListNft({String? type = '1'}) async {
    canLoadMoreList = true;
    if (refresh == false) {
      page = 0;
      refresh = true;
      await getListNft(type: type);
    } else {
      //nothing
    }
  }
}
