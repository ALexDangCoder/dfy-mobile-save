import 'package:Dfy/data/response/home_pawn/pawnshop_packgae_response.dart';
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
    @Query('collection_address') String? collateralSymbols,
    @Query('collateralSymbols') String? name,
    @Query('interestRanges') String? interestRanges,
    @Query('collection_address') String? loanToValueRanges,
    @Query('loanToValueRanges') String? loanSymbols,
    @Query('loanType') String? loanType,
    @Query('page') String? page,
    @Query('size') String? size,
  );


  @GET(ApiConstants.GET_PERSONAL_LENDING)
  Future<PersonalLendingResponse> getPersonalLending(
      @Query('collateralAmount') String? collateralAmount,
      @Query('collection_address') String? collateralSymbols,
      @Query('collateralSymbols') String? name,
      @Query('interestRanges') String? interestRanges,
      @Query('collection_address') String? loanToValueRanges,
      @Query('loanToValueRanges') String? loanSymbols,
      @Query('loanType') String? loanType,
      @Query('page') String? page,
      @Query('size') String? size,
  );
}
