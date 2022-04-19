import 'package:Dfy/data/request/pawn/lender/create_new_loan_package_request.dart';
import 'package:Dfy/data/response/home_pawn/list_collateral_response.dart';
import 'package:Dfy/data/response/pawn/manage_package/detail_pawn_shop_package_response.dart';
import 'package:Dfy/data/response/pawn/manage_package/find_by_user_id_response.dart';
import 'package:Dfy/data/response/pawn/manage_package/info_after_post_new_loan_package_response.dart';
import 'package:Dfy/data/response/pawn/manage_package/list_pawn_shop_package_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'setting_package_lender_service.g.dart';

@RestApi()
abstract class SettingPackageLenderService {
  @factoryMethod
  factory SettingPackageLenderService(Dio dio, {String baseUrl}) =
      _SettingPackageLenderService;

  @GET(ApiConstants.GET_FIND_USER_ID)
  Future<FindByUserIdTotalResponse> getFindByUserId(
    @Query('userId') String? userId,
  );

  @GET('${ApiConstants.GET_LIST_LOAN_PACKAGE}{id}/pawn-shop-packages')
  Future<PawnShopPackageTotalResponse> getListPawnShopPackage(
    @Path('id') String id,
    @Query('page') String? page,
    @Query('size') String? size,
    @Query('walletAddress') String? walletAddress,
  );

  @GET('${ApiConstants.GET_COLLATERAL_PAWNSHOP_PACKAGE}{id}/collaterals')
  Future<ListCollateralResponse> getListCollateral(
    @Path('id') String id,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @GET('${ApiConstants.GET_PAWNSHOP_PACKAGE_DETAIL}{packageId}')
  Future<DetailPawnShopPackageResponse> getPawnshopPackageDetail(
    @Path('packageId') String? packageId,
  );

  // @POST('${ApiConstants.POST_NEW_LOAN_PACKAGE}')
  // Future<RepaymentPayResponse> postRepaymentPay(
  //     @Path('id') String? id,
  //     @Body() CalculateRepaymentRequest? repaymentPayRequest,
  //     );

  @POST(ApiConstants.POST_NEW_LOAN_PACKAGE)
  Future<InfoAfterPostNewLoanPackageResponse> postInfoNewLoanPackage(
    @Body() CreateNewLoanPackageRequest? createNewLoanPackageRequest,
  );

  @PUT('${ApiConstants.GET_COLLATERAL_PAWNSHOP_PACKAGE}{id}/cancel')
  Future<String> postCancelPackageAfterCfBC({
    @Path('id') String? id,
  });

  @POST(ApiConstants.REJECT_LOAN_REQUEST)
  Future<String> postRejectCollateralAfterCFBC({
    @Field('loanRequestId') required String loanRequestId,
  });

  @POST(ApiConstants.ACCEPT_LOAN_REQUEST)
  Future<String> postAcceptCollateralAfterCFBC({
    @Field('loanRequestId') required String loanRequestId,
  });
}
