import 'package:Dfy/data/response/home_pawn/crypto_collateral_res.dart';
import 'package:Dfy/data/response/home_pawn/list_collateral_response.dart';
import 'package:Dfy/data/response/home_pawn/pawn_list_response.dart';
import 'package:Dfy/data/response/home_pawn/pawnshop_packgae_response.dart';
import 'package:Dfy/data/response/home_pawn/personal_lending_hard_response.dart';
import 'package:Dfy/data/response/home_pawn/personal_lending_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'borrow_service.g.dart';

@RestApi()
abstract class BorrowService {
  @factoryMethod
  factory BorrowService(Dio dio, {String baseUrl}) = _BorrowService;

  @GET(ApiConstants.GET_PAWNSHOP_PACKAGE)
  Future<PawnshopPackageResponse> getPawnshopPackage(
    @Query('collateralAmount') String? collateralAmount,
    @Query('collateralSymbols') String? collateralSymbols,
    @Query('name') String? name,
    @Query('interestRanges') String? interestRanges,
    @Query('loanToValueRanges') String? loanToValueRanges,
    @Query('loanSymbols') String? loanSymbols,
    @Query('loanType') String? loanType,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @GET(ApiConstants.GET_PERSONAL_LENDING)
  Future<PersonalLendingResponse> getPersonalLending(
    @Query('collateralAmount') String? collateralAmount,
    @Query('collateralSymbols') String? collateralSymbols,
    @Query('name') String? name,
    @Query('interestRanges') String? interestRanges,
    @Query('loanToValueRanges') String? loanToValueRanges,
    @Query('loanSymbols') String? loanSymbols,
    @Query('loanType') String? loanType,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @GET(ApiConstants.GET_PERSONAL_LENDING_HARD)
  Future<PersonalLendingHardResponse> getPersonalLendingHard(
    @Query('collateralAmount') String? collateralAmount,
    @Query('collection_address') String? collateralSymbols,
    @Query('name') String? name,
    @Query('interestRanges') String? interestRanges,
    @Query('loanToValueRanges') String? loanToValueRanges,
    @Query('loanSymbols') String? loanSymbols,
    @Query('loanType') String? loanType,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @GET(ApiConstants.GET_CRYPTO_COLLATERAL)
  Future<CryptoCollateralResponse> getCryptoCollateral(
    @Query('walletAddress') String walletAddress,
    @Query('packageId') String? packageId,
    @Query('isRequestLoan') String? isRequestLoan,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @GET(ApiConstants.GET_LIST_COLLATERAL)
  Future<ListCollateralResponse> getListCollateral(
    @Query('collateralSymbols') String? collateralSymbols,
    @Query('loanSymbols') String? loanSymbols,
    @Query('durationTypes') String? durationTypes,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @GET(ApiConstants.GET_LIST_PAWN)
  Future<PawnListResponse> getListPawnShopMy();
}
