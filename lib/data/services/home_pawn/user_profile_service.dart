import 'package:Dfy/data/response/pawn/user_profile/borrow_total_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_collateral_response.dart';
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

}
