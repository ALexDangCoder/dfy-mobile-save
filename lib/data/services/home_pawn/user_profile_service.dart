import 'package:Dfy/data/response/create_hard_nft/confirm_evaluation_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/borrow_total_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/lending_setting_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_collateral_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_comment_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_loan_package_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_signed_contract_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/notification_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/reputation_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/setting_user_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/user_profile_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'user_profile_service.g.dart';

@RestApi()
abstract class UserProfileService {
  @factoryMethod
  factory UserProfileService(Dio dio, {String baseUrl}) = _UserProfileService;

  @GET('${ApiConstants.GET_PROFILE_USER}{userId}/profile')
  Future<UserProfileResponse> getUserProfile(
    @Path('userId') String userId,
  );
  @GET('${ApiConstants.GET_MY_PROFILE_USER}profile')
  Future<UserProfileResponse> getMyUserProfile(

      );
  @PUT(ApiConstants.PUT_PAWN_SHOP_PROFILE)
  Future<ConfirmEvaluationResponse> updatePawnshopProfile(
      @Body() Map<String,String> map,
      );
  @PUT(ApiConstants.PUT_PROFILE_USER)
  Future<ConfirmEvaluationResponse> updatePersonalProfile(
      @Body() Map<String,dynamic> map,
      );
  @PUT(ApiConstants.DISCONNECT_WALLET)
  Future<ConfirmEvaluationResponse> disconnectWallet(
      @Body() Map<String,dynamic> map,
      );
  @PUT('${ApiConstants.GET_NOTIFICATION}/{id}')
  Future<String> updateNoti(
      @Path('id') String id,
      );
  @DELETE('${ApiConstants.GET_NOTIFICATION}/{id}')
  Future<String> deleteNoti(
      @Path('id') String id,
      );




  @GET(ApiConstants.GET_NOTIFICATION)
  Future<NotificationResponse> getNotification(
      @Query('notiType') String? notiType,
      @Query('isReaded') String? isReaded,
      @Query('page') String page,
      @Query('size') String size,
      );


  @GET(ApiConstants.GET_MY_SETTING_EMAIL)
  Future<SettingUserResponse> getEmailSetting();

  @GET(ApiConstants.GET_MY_SETTING_NOTI)
  Future<SettingUserResponse> getNotiSetting();

  @PUT(ApiConstants.GET_MY_SETTING_EMAIL)
  Future<SettingUserResponse> putEmailSetting(
      @Body() Map<String,dynamic>  emailSetting,
      );

  @PUT(ApiConstants.GET_MY_SETTING_NOTI)
  Future<SettingUserResponse> putNotiSetting(
      @Body() Map<String,dynamic>  notiSetting,
      );


  @GET(ApiConstants.GET_REPUTATION)
  Future<List<ReputationResponse>> getReputation(
    @Query('userId') String userId,
  );

  @GET(ApiConstants.GET_BORROW_USER)
  Future<BorrowResponse> getBorrowCollateralUser(
    @Query('userId') String userId,
    @Query('walletAddress') String walletAddress,
  );

  @GET(ApiConstants.GET_BORROW_SIGN_CONTRACT_USER)
  Future<BorrowResponse> getBorrowSignContractUser(
    @Query('userId') String userId,
    @Query('walletAddress') String walletAddress,
  );

  @GET(ApiConstants.GET_LENDER_SIGN_CONTRACT_USER)
  Future<BorrowResponse> getLenderSignContractUser(
    @Query('userId') String userId,
    @Query('walletAddress') String walletAddress,
  );

  @GET(ApiConstants.COLLATERAL_MY_ACC)
  Future<ListCollateralUser> getListCollateral(
    @Query('userId') String userId,
    @Query('walletAddress') String walletAddress,
    @Query('size') String size,
    @Query('status') String status,
    @Query('type') String type,
  );

  @GET(ApiConstants.GET_LIST_CONTRACT_USER)
  Future<ListSignedContractUser> getListSignedContract(
    @Query('userId') String userId,
    @Query('borrower_wallet_address') String walletAddress,
    @Query('size') String size,
  );
  @GET(ApiConstants.GET_LIST_LOAN_CONTRACT_USER)
  Future<ListSignedContractUser> getListLoanSignedContract(
      @Query('userId') String userId,
      @Query('borrower_wallet_address') String walletAddress,
      @Query('size') String size,
      );

  @GET(ApiConstants.GET_LIST_COMMENT)
  Future<ListCommentUser> getListCommentUser(
    @Query('userId') String userId,
    @Query('walletAddress') String walletAddress,
    @Query('size') String size,
    @Query('page') String page,
  );
  @GET(ApiConstants.GET_LENDING_SETTING)
  Future<LendingSettingResponse> getLendingSetting(
      @Query('userId') String userId,
      );
  @GET('${ApiConstants.GET_LIST_LOAN_PACKAGE}{pawnshopId}/pawn-shop-packages')
  Future<ListLoanPackage> getListLoanPackage(
      @Path('pawnshopId') String pawnshopId,
      @Query('userId') String userId,
      @Query('walletAddress') String walletAddress,
      @Query('loanStatus') String loanStatus,
      @Query('loanTypes') String loanTypes,
      @Query('size') String size,
      @Query('page') String page,
      );
}
