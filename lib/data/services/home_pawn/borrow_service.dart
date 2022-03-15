import 'package:Dfy/data/response/create_hard_nft/confirm_evaluation_response.dart';
import 'package:Dfy/data/response/home_pawn/asset_filter_response.dart';
import 'package:Dfy/data/response/home_pawn/crypto_collateral_res.dart';
import 'package:Dfy/data/response/home_pawn/detail_collateral_response.dart';
import 'package:Dfy/data/response/home_pawn/list_collateral_response.dart';
import 'package:Dfy/data/response/home_pawn/list_collection_filter_response.dart';
import 'package:Dfy/data/response/home_pawn/list_reputation_borrower_response.dart';
import 'package:Dfy/data/response/home_pawn/nft_collateral_response.dart';
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
    @Query('loanTypes') String? loanType,
    @Query('durationTypes') String? durationType,
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
    @Query('durationTypes') String? durationType,
    @Query('page') String? page,
    @Query('size') String? size,
    @Query('cusSort') String? cusSort,
  );

  @GET(ApiConstants.GET_PERSONAL_LENDING_HARD)
  Future<PersonalLendingHardResponse> getPersonalLendingHard(
    @Query('collateralAmount') String? collateralAmount,
    @Query('collateralSymbols') String? collateralSymbols,
    @Query('name') String? name,
    @Query('interestRanges') String? interestRanges,
    @Query('loanToValueRanges') String? loanToValueRanges,
    @Query('loanSymbols') String? loanSymbols,
    @Query('loanType') String? loanType,
    @Query('page') String? page,
    @Query('size') String? size,
    @Query('cusSort') String? cusSort,
    @Query('collateralType') String? collateralType,
    @Query('isNft') bool? isNft,
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
  Future<PawnListResponse> getListPawnShopMy(
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @GET(ApiConstants.GET_LIST_NFT_COLLATERAL)
  Future<CollateralNFTResponse> getListNFTCollateral(
    @Query('page') String? page,
    @Query('size') String? size,
    @Query('maximunLoanAmount') String? maximunLoanAmount,
    @Query('loanSymbols') String? loanSymbols,
    @Query('durationTypes') String? durationTypes,
    @Query('durationQuantity') String? durationQuantity,
    @Query('types') String? types,
    @Query('assetTypes') String? assetTypes,
    @Query('loanAmountFrom') String? loanAmountFrom,
    @Query('loanAmountTo') String? loanAmountTo,
    @Query('collectionId') String? collectionId,
  );

  @POST(ApiConstants.POST_COLLATERAL_TO_BE)
  Future<ConfirmEvaluationResponse> confirmSendLoanRequest(
    @Body() Map<String, String> map,
  );

  @GET(ApiConstants.GET_COLLECTION_FILTER)
  Future<ListCollectionFilterResponse> getListCollectionFilter();

  @GET(ApiConstants.GET_ASSET_FILTER)
  Future<AssetFilterResponse> getListAssetFilter();

  @GET('${ApiConstants.GET_DETAIL_COLLATERAL}{id}')
  Future<DetailCollateralResponse> getDetailCollateral(
    @Path('id') String? id,
  );

  @GET(ApiConstants.GET_LIST_REPUTATION)
  Future<List<ReputationBorrowerResponse>> getListReputation(
    @Query('walletAddress') String? walletAddress,
  );
}
