import 'package:Dfy/data/request/pawn/borrow/nft_send_loan_request.dart';
import 'package:Dfy/data/request/pawn/repayment_pay_request.dart';
import 'package:Dfy/data/response/create_hard_nft/confirm_evaluation_response.dart';
import 'package:Dfy/data/response/home_pawn/asset_filter_response.dart';
import 'package:Dfy/data/response/home_pawn/borrow_list_my_acc_response.dart';
import 'package:Dfy/data/response/home_pawn/check_rate_response.dart';
import 'package:Dfy/data/response/home_pawn/collateral_detail_my_acc_response.dart';
import 'package:Dfy/data/response/home_pawn/collateral_widraw_response.dart';
import 'package:Dfy/data/response/home_pawn/contract_detail_response.dart';
import 'package:Dfy/data/response/home_pawn/create_new_collateral_response.dart';
import 'package:Dfy/data/response/home_pawn/crypto_collateral_res.dart';
import 'package:Dfy/data/response/home_pawn/detail_collateral_response.dart';
import 'package:Dfy/data/response/home_pawn/detail_pawnshop_response.dart';
import 'package:Dfy/data/response/home_pawn/history_collateral_response.dart';
import 'package:Dfy/data/response/home_pawn/list_collateral_response.dart';
import 'package:Dfy/data/response/home_pawn/list_collection_filter_response.dart';
import 'package:Dfy/data/response/home_pawn/list_reputation_borrower_response.dart';
import 'package:Dfy/data/response/home_pawn/nft_collateral_response.dart';
import 'package:Dfy/data/response/home_pawn/offer_detail_my_acc.dart';
import 'package:Dfy/data/response/home_pawn/offer_received_response.dart';
import 'package:Dfy/data/response/home_pawn/pawn_list_response.dart';
import 'package:Dfy/data/response/home_pawn/pawnshop_packgae_response.dart';
import 'package:Dfy/data/response/home_pawn/personal_lending_hard_response.dart';
import 'package:Dfy/data/response/home_pawn/personal_lending_response.dart';
import 'package:Dfy/data/response/home_pawn/repayment_pay_response.dart';
import 'package:Dfy/data/response/home_pawn/repayment_request_response.dart';
import 'package:Dfy/data/response/home_pawn/repayment_stats_response.dart';
import 'package:Dfy/data/response/home_pawn/send_offer_lend_crypto_response.dart';
import 'package:Dfy/data/response/home_pawn/send_to_loan_package_response.dart';
import 'package:Dfy/data/response/home_pawn/total_repayment_response.dart';
import 'package:Dfy/data/response/pawn/borrow/nft_on_request_loan_response.dart';
import 'package:Dfy/data/response/pawn/borrow/nft_res_after_post_request_loan.dart';
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

  @GET('${ApiConstants.GET_PAWNSHOP_PACKAGE_DETAIL}{packageId}')
  Future<DetailPawnShopResponse> getPawnshopPackageDetail(
    @Path('packageId') String? packageId,
  );

  @POST(ApiConstants.POST_NFT_SEND_LOAN_REQUEST)
  Future<NftResAfterPostLoanRequestResponse> postNftOnLoanRequest(
    @Body() NftSendLoanRequest nftSendLoanRequest,
  );

  @GET(ApiConstants.GET_NFT_SEND_lOAN_REQUEST)
  Future<NftOnRequestLoanResponse> getListNftOnRequestLoan(
    @Query('walletAddress') String walletAddress,
    @Query('page') String? page,
    @Query('size') String? size,
    @Query('name') String? nameSearch,
    @Query('nftType') String? nftType,
  );

  @POST(ApiConstants.POST_SEND_OFFER_REQUEST)
  Future<SendOfferLendCryptoResponse> postSendOfferRequest(
    @Field('collateralId') String? collateralId,
    @Field('loanRequestId') String? loanRequestId,
    @Field('duration') String? duration,
    @Field('durationType') String? durationType,
    @Field('interestRate') String? interestRate,
    @Field('latestBlockchainTxn') String? latestBlockchainTxn,
    @Field('liquidationThreshold') String? liquidationThreshold,
    @Field('loanAmount') String? loanAmount,
    @Field('loanToValue') String? loanToValue,
    @Field('message') String? message,
    @Field('repaymentToken') String? repaymentToken,
    @Field('supplyCurrency') String? supplyCurrency,
    @Field('walletAddress') String? walletAddress,
  );

  @GET(ApiConstants.COLLATERAL_MY_ACC)
  Future<ListCollateralResponse> getListCollateralMyAcc(
    @Query('status') String? status,
    @Query('page') String? page,
    @Query('size') String? size,
    @Query('collateralCurrencySymbol') String? collateralCurrencySymbol,
    @Query('walletAddress') String? walletAddress,
    @Query('sort') String? sort,
    @Query('supplyCurrencySymbol') String? supplyCurrencySymbol,
  );

  @POST(ApiConstants.CREATE_NEW_COLLATERAL)
  Future<CreateNewCollateralResponse> postCreateNewCollateral(
    @Field('amount') String? amount,
    @Field('collateral') String? collateral,
    @Field('description') String? description,
    @Field('expected_loan_duration_time') String? expectedLoanDurationTime,
    @Field('expected_loan_duration_type') String? expectedLoanDurationType,
    @Field('status') String? status,
    @Field('supply_currency') String? supplyCurrency,
    @Field('txid') String? txid,
    @Field('wallet_address') String? walletAddress,
  );

  @GET('${ApiConstants.DETAIL_COLLATERAL_MY_ACC}{collateral_id}')
  Future<CollateralDetailMyAccResponse> getDetailCollateralMyAcc(
    @Path('collateral_id') String? collateralId,
  );

  @GET(
      '${ApiConstants.HISTORY_DETAIL_COLLATERAL_MY_ACC}{collateral_id}${ApiConstants.HISTORY_MY_ACC}')
  Future<HistoryCollateralResponse> getHistoryDetailCollateralMyAcc(
    @Path('collateral_id') String? collateralId,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @GET(ApiConstants.OFFERS_RECEIVED_MY_ACC)
  Future<OfferReceivedResponse> getListReceived(
    @Query('collateralId') String? collateralId,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @GET(ApiConstants.SEND_TO_LOAN_PACKAGE_MY_ACC)
  Future<SendToLoanPackageResponse> getListSendToLoanPackage(
    @Query('collateral-id') String? collateralId,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @POST(ApiConstants.COLLATERAL_WITHDRAW)
  Future<CollateralWithDrawResponse> postCollateralWithdraw(
    @Query('id') String? id,
  );

  @GET('${ApiConstants.OFFER_DETAIL_MY_ACC}{id}')
  Future<OfferDetailMyAccResponse> getOfferDetailMyAcc(
    @Path('id') String? id,
  );

  @GET(ApiConstants.GET_BORROW_CONTRACT)
  Future<BorrowListMyAccResponse> getBorrowContract(
    @Query('borrower_wallet_address') String? borrowerWalletAddress,
    @Query('status') String? status,
    @Query('type') String? type,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  //

  @GET('${ApiConstants.GET_DETAIl_CONTRACT_LENDER}{id}')
  Future<ContractlDetailMyAccResponse> getLenderContract(
    @Path('id') String? id,
    @Query('walletAddress') String? walletAddress,
    @Query('type') String? type,
  );

  @GET(
      '${ApiConstants.GET_BORROW_REPAYMENT_HISTORY}{id}${ApiConstants.REPAYMENT_STATS}')
  Future<RepaymentStatsResponse> getRepaymentHistory(
    @Path('id') String? id,
  );

  @GET(
      '${ApiConstants.GET_BORROW_REPAYMENT_REQUEST}{id}${ApiConstants.REPAYMENT_REQUEST}')
  Future<RepaymentRequestResponse> getRepaymentResquest(
    @Path('id') String? id,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @GET(ApiConstants.GET_CHECK_RATE)
  Future<CheckRateResponse> getCheckRate(
    @Query('contractId') String? contractId,
    @Query('walletAddress') String? walletAddress,
    @Query('type') String? type,
  );

  @GET('${ApiConstants.GET_LIST_ITEM_REPAYMENT}{id}')
  Future<RepaymentRequestResponse> getListItemRepayment(
    @Path('id') String? id,
    @Query('page') String? walletAddress,
    @Query('size') String? type,
  );

  @GET('${ApiConstants.GET_TOTAL_REPAYMENT}{id}${ApiConstants.SUMMARY}')
  Future<TotalRepaymentResponse> getTotalRepayment(
    @Path('id') String? id,
  );

  @GET('${ApiConstants.GET_REPAYMENT_PAY}{id}${ApiConstants.ACTIVE_REPAYMENT}')
  Future<RepaymentPayResponse> getRepaymentPay(
    @Path('id') String? id,
  );

  @POST('${ApiConstants.POST_REPAYMENT_PAY}{id}${ApiConstants.CALCULATE}')
  Future<RepaymentPayResponse> postRepaymentPay(
    @Path('id') String? id,
    @Body() RepaymentPayRequest? repaymentPayRequest,
  );
}
