import 'package:Dfy/data/response/home_pawn/list_reputation_borrower_response.dart';
import 'package:Dfy/data/response/pawn/lender_contract/lender_contract_nft_response.dart';
import 'package:Dfy/data/response/pawn/loan_request_list/detail_loan_request_response.dart';
import 'package:Dfy/data/response/pawn/loan_request_list/loan_request_crypto_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';

part 'loan_request_list_service.g.dart';

@RestApi()
abstract class LoanRequestListService {
  @factoryMethod
  factory LoanRequestListService(Dio dio, {String baseUrl}) =
      _LoanRequestListService;

  @GET(ApiConstants.GET_LOAN_REQUEST_LIST)
  Future<LoanRequestCryptoTotalResponse> getLoanRequestListCrypto(
    @Query('p2p') String? p2p,
    @Query('page') String? page,
    @Query('size') String? size,
    @Query('collateral') String? collateral,
    @Query('status') String? status,
    @Query('walletAddress') String? walletAddress,
  );

  @GET(ApiConstants.GET_LIST_REPUTATION)
  Future<List<ReputationBorrowerResponse>> getBorrowerInfo(
    @Query('walletAddress') String walletAddress,
  );

  @GET('${ApiConstants.GET_LOAN_REQUEST}{id}')
  Future<DetailLoanRequestTotalResponse> getDetailLoanRequest(
    @Path('id') String id,
  );

  @GET(ApiConstants.GET_NFT_LOAN_REQUEST)
  Future<LoanRequestCryptoTotalResponse> getListNftLoanRequest(
    @Query('nftType') String? nftType,
    @Query('status') String? status,
    @Query('walletAddress') String? walletAddress,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @POST('${ApiConstants.GET_COLLATERAL_PAWNSHOP_PACKAGE}{id}/createOffer')
  Future<String> postSendOfferRequest({
    @Path('id') required String id,
    @Field('collateralId') String? collateralId,
    @Field('duration') String? duration,
    @Field('durationType') String? durationType,
    @Field('interestRate') String? interestRate,
    @Field('latestBlockchainTxn') String? latestBlockchainTxn,
    @Field('liquidationThreshold') String? liquidationThreshold,
    @Field('loanAmount') String? loanAmount,
    @Field('loanRequestId') String? loanRequestId,
    @Field('loanToValue') String? loanToValue,
    @Field('message') String? message,
    @Field('repaymentToken') String? repaymentToken,
    @Field('supplyCurrency') String? supplyCurrency,
    @Field('walletAddress') String? walletAddress,
  });


  @POST(ApiConstants.REJECT_LOAN_REQUEST)
  Future<String> rejectCryptoLoanRequest({
    @Field('loanRequestId') required String loanRequestId,
  });

  @POST(ApiConstants.REJECT_LOAN_REQUEST_NFT)
  Future<String> rejectNFTLoanRequest({
    @Field('loanRequestId') required String loanRequestId,
  });



}
