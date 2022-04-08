import 'package:Dfy/data/request/pawn/borrow/nft_send_loan_request.dart';
import 'package:Dfy/data/request/pawn/calculate_repayment_fee.dart';
import 'package:Dfy/data/request/pawn/review_create_request.dart';
import 'package:Dfy/data/response/pawn/borrow/nft_res_after_post_request_loan.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/home_pawn/asset_filter_model.dart';
import 'package:Dfy/domain/model/home_pawn/check_rate_model.dart';
import 'package:Dfy/domain/model/home_pawn/collateral_detail_my_acc_model.dart';
import 'package:Dfy/domain/model/home_pawn/crypto_pawn_model.dart';
import 'package:Dfy/domain/model/home_pawn/history_detail_collateral_model.dart';
import 'package:Dfy/domain/model/home_pawn/offers_received_model.dart';
import 'package:Dfy/domain/model/home_pawn/send_offer_lend_crypto_model.dart';
import 'package:Dfy/domain/model/home_pawn/send_to_loan_package_model.dart';
import 'package:Dfy/domain/model/home_pawn/total_repaymnent_model.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/pawn/borrow/nft_on_request_loan_model.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/domain/model/pawn/contract_detail_pawn.dart';
import 'package:Dfy/domain/model/pawn/crypto_collateral.dart';
import 'package:Dfy/domain/model/pawn/detail_collateral.dart';
import 'package:Dfy/domain/model/pawn/offer_detail_my_acc.dart';
import 'package:Dfy/domain/model/pawn/pawn_shop_model.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/domain/model/pawn/repayment_request_model.dart';
import 'package:Dfy/domain/model/pawn/repayment_stats_model.dart';
import 'package:Dfy/domain/model/pawn/reputation_borrower.dart';
import 'package:Dfy/domain/model/pawn/result_create_new_collateral_model.dart';

mixin BorrowRepository {
  Future<Result<List<PawnshopPackage>>> getListPawnshop({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
    String? duration,
    String? page,
  });

  Future<Result<List<PersonalLending>>> getListPersonalLending({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
    String? page,
    String? duration,
    String? cusSort,
  });

  Future<Result<List<CryptoCollateralModel>>> getListCryptoCollateral(
    String walletAddress,
    String packageId,
    String page,
  );

  Future<Result<List<PersonalLending>>> getListPersonalLendingHard({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
    String? page,
    String? cusSort,
    String? collateralType,
    bool? isNft,
  });

  Future<Result<List<CollateralResultModel>>> getListCollateral({
    String? collateralSymbols,
    String? loanSymbols,
    String? durationTypes,
    String? page,
    String? size,
  });

  Future<Result<List<PawnShopModelMy>>> getListPawnShopMy({
    String? page,
    String? size,
    String? interestRanges,
    String? loanSymbols,
    String? collateralSymbols,
    String? name,
    String? cusSort,
  });

  Future<Result<List<NftMarket>>> getListNFTCollateral({
    String? page,
    String? size,
    String? maxiMunLoanAmount,
    String? loanSymbols,
    String? durationTypes,
    String? durationQuantity,
    String? types,
    String? assetTypes,
    String? loanAmountFrom,
    String? loanAmountTo,
    String? collectionId,
  });

  Future<Result<String>> confirmCollateralToBe({
    required Map<String, String> map,
  });

  Future<Result<NftResAfterPostLoanRequestResponse>> postNftToServer(
      {required NftSendLoanRequest request});

  Future<Result<List<ContentNftOnRequestLoanModel>>> getListNftOnLoanRequest({
    String? walletAddress,
    String? page,
    String? size,
    String? name,
    String? nftType,
  });

  Future<Result<List<CollectionMarketModel>>> getListCollectionFilter();

  Future<Result<List<AssetFilterModel>>> getListAssetFilter();

  Future<Result<CollateralDetail>> getDetailCollateral({
    String? id,
  });

  Future<Result<List<ReputationBorrower>>> getListReputation({
    String? addressWallet,
  });

  Future<Result<SendOfferLendCryptoModel>> postSendOfferRequest({
    String? collateralId,
    String? loanRequestId,
    String? duration,
    String? durationType,
    String? interestRate,
    String? latestBlockchainTxn,
    String? liquidationThreshold,
    String? loanAmount,
    String? loanToValue,
    String? message,
    String? repaymentToken,
    String? supplyCurrency,
    String? walletAddress,
  });

  Future<Result<PawnshopPackage>> getPawnshopDetail({
    required String packageId,
  });

  Future<Result<List<CollateralResultModel>>> getListCollateralMyAcc({
    String? status,
    String? page,
    String? size,
    String? collateralCurrencySymbol,
    String? walletAddress,
    String? sort,
    String? supplyCurrencySymbol,
  });

  Future<Result<ResultCreateNewModel>> postCreateNewCollateral({
    String? amount,
    String? collateral,
    String? description,
    String? expectedLoanDurationTime,
    String? expectedLoanDurationType,
    String? status,
    String? supplyCurrency,
    String? txid,
    String? walletAddress,
  });

  Future<Result<CollateralDetailMyAcc>> getDetailCollateralMyAcc({
    String? collateralId,
  });

  Future<Result<List<HistoryCollateralModel>>> getHistoryDetailCollateralMyAcc({
    String? collateralId,
    String? page,
    String? size,
  });

  Future<Result<List<OffersReceivedModel>>> getListReceived({
    String? collateralId,
    String? page,
    String? size,
  });

  Future<Result<List<SendToLoanPackageModel>>> getListSendToLoanPackage({
    String? collateralId,
    String? page,
    String? size,
  });

  Future<Result<String>> postCollateralWithdraw({
    required String id,
  });

  Future<Result<OfferDetailMyAcc>> getOfferDetailMyAcc({
    String? id,
  });

  Future<Result<List<CryptoPawnModel>>> getBorrowContract({
    String? borrowerWalletAddress,
    String? status,
    String? type,
    String? page,
    String? size,
  });

  Future<Result<ContractDetailPawn>> getLenderContract({
    String? id,
    String? walletAddress,
    String? type,
  });

  Future<Result<ContractDetailPawn>> getLenderDetail({
    String? id,
    String? walletAddress,
    String? type,
  });

  Future<Result<RepaymentStatsModel>> getRepaymentHistory({
    String? id,
  });

  Future<Result<List<RepaymentRequestModel>>> getRepaymentResquest({
    String? id,
    String? page,
    String? size,
  });

  Future<Result<CheckRateModel>> getCheckRate({
    String? contractId,
    String? walletAddress,
    String? type,
  });

  Future<Result<List<RepaymentRequestModel>>> getListItemRepayment({
    String? id,
    String? page,
    String? size,
  });

  Future<Result<TotalRepaymentModel>> getTotalRepayment({
    String? id,
  });

  Future<Result<RepaymentRequestModel>> getRepaymentPay({
    String? id,
  });

  Future<Result<RepaymentRequestModel>> postRepaymentPay({
    String? id,
    CalculateRepaymentRequest? repaymentPayRequest,
  });

  Future<Result<String>> putCancelOffer({
    String? idCollateral,
    String? idOffer,
    String? walletAddress,
  });

  Future<Result<String>> putAcceptOffer({
    String? id,
  });

  Future<Result<String>> putAddMoreCollateral({
    String? id,
    double? amount,
    String? symbol,
    String? txnHash,
  });

  Future<Result<String>> postReview({
    ReviewCreateRequest? reviewCreateRequest,
  });

  Future<Result<String>> postLendingCreate({
    String? address,
    String? description,
    String? email,
    String? name,
    String? phoneNumber,
    String? type,
    String? userId,
    String? walletAddress,
  });
}
