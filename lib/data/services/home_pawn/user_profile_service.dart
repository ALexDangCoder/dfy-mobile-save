import 'package:Dfy/data/response/pawn/user_profile/borrow_total_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/lending_setting_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_collateral_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_comment_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_loan_package_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_signed_contract_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/reputation_response.dart';
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
