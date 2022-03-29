import 'package:Dfy/data/request/pawn/borrow/nft_send_loan_request.dart';
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
import 'package:Dfy/data/response/home_pawn/repayment_request_response.dart';
import 'package:Dfy/data/response/home_pawn/repayment_stats_response.dart';
import 'package:Dfy/data/response/home_pawn/send_offer_lend_crypto_response.dart';
import 'package:Dfy/data/response/home_pawn/send_to_loan_package_response.dart';
import 'package:Dfy/data/response/home_pawn/total_repayment_response.dart';
import 'package:Dfy/data/response/pawn/borrow/nft_on_request_loan_response.dart';
import 'package:Dfy/data/response/pawn/borrow/nft_res_after_post_request_loan.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/home_pawn/borrow_service.dart';
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
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/utils/constants/api_constants.dart';

class BorrowRepositoryImpl implements BorrowRepository {
  final BorrowService _client;

  BorrowRepositoryImpl(this._client);

  @override
  Future<Result<List<PawnshopPackage>>> getListPawnshop({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
    String? page,
    String? duration,
  }) {
    return runCatchingAsync<PawnshopPackageResponse, List<PawnshopPackage>>(
      () => _client.getPawnshopPackage(
        collateralAmount,
        collateralSymbols,
        name,
        interestRanges,
        loanToValueRanges,
        loanSymbols,
        loanType,
        duration,
        page,
        ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      ),
      (response) => response.data?.toDomain() ?? [],
    );
  }

  @override
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
  }) {
    return runCatchingAsync<PersonalLendingResponse, List<PersonalLending>>(
      () => _client.getPersonalLending(
        collateralAmount,
        collateralSymbols,
        name,
        interestRanges,
        loanToValueRanges,
        loanSymbols,
        loanType,
        duration,
        page,
        ApiConstants.DEFAULT_PAGE_SIZE.toString(),
        cusSort,
      ),
      (response) => response.data?.toDomain() ?? [],
    );
  }

  @override
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
  }) {
    return runCatchingAsync<PersonalLendingHardResponse, List<PersonalLending>>(
      () => _client.getPersonalLendingHard(
        collateralAmount,
        collateralSymbols,
        name,
        interestRanges,
        loanToValueRanges,
        loanSymbols,
        loanType,
        page,
        ApiConstants.DEFAULT_PAGE_SIZE.toString(),
        cusSort,
        collateralType,
        isNft,
      ),
      (response) => response.data?.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<CryptoCollateralModel>>> getListCryptoCollateral(
    String walletAddress,
    String packageId,
    String page,
  ) {
    return runCatchingAsync<CryptoCollateralResponse,
        List<CryptoCollateralModel>>(
      () => _client.getCryptoCollateral(walletAddress, packageId, 'true', page,
          ApiConstants.DEFAULT_PAGE_SIZE.toString()),
      (response) => response.data?.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<CollateralResultModel>>> getListCollateral({
    String? collateralSymbols,
    String? loanSymbols,
    String? durationTypes,
    String? page,
    String? size,
  }) {
    return runCatchingAsync<ListCollateralResponse,
        List<CollateralResultModel>>(
      () => _client.getListCollateral(
        collateralSymbols,
        loanSymbols,
        durationTypes,
        page,
        size,
      ),
      (response) =>
          response.data?.content?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<PawnShopModelMy>>> getListPawnShopMy({
    String? page,
    String? size,
  }) {
    return runCatchingAsync<PawnListResponse, List<PawnShopModelMy>>(
      () => _client.getListPawnShopMy(
        page,
        size,
      ),
      (response) =>
          response.data?.data?.content?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<NftMarket>>> getListNFTCollateral({
    String? page,
    String? size,
    String? maximunLoanAmount,
    String? loanSymbols,
    String? durationTypes,
    String? durationQuantity,
    String? types,
    String? assetTypes,
    String? loanAmountFrom,
    String? loanAmountTo,
    String? collectionId,
  }) {
    return runCatchingAsync<CollateralNFTResponse, List<NftMarket>>(
      () => _client.getListNFTCollateral(
        page,
        size,
        maximunLoanAmount,
        loanSymbols,
        durationTypes,
        durationQuantity,
        types,
        assetTypes,
        loanAmountFrom,
        loanAmountTo,
        collectionId,
      ),
      (response) =>
          response.data?.content?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<String>> confirmCollateralToBe(
      {required Map<String, String> map}) {
    return runCatchingAsync<ConfirmEvaluationResponse, String>(
      () => _client.confirmSendLoanRequest(map),
      (response) => response.code.toString(),
    );
  }

  @override
  Future<Result<List<CollectionMarketModel>>> getListCollectionFilter() {
    return runCatchingAsync<ListCollectionFilterResponse,
        List<CollectionMarketModel>>(
      () => _client.getListCollectionFilter(),
      (response) => response.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<AssetFilterModel>>> getListAssetFilter() {
    return runCatchingAsync<AssetFilterResponse, List<AssetFilterModel>>(
      () => _client.getListAssetFilter(),
      (response) => response.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<CollateralDetail>> getDetailCollateral({String? id}) {
    return runCatchingAsync<DetailCollateralResponse, CollateralDetail>(
      () => _client.getDetailCollateral(
        id,
      ),
      (response) => response.data?.toDomain() ?? CollateralDetail(),
    );
  }

  @override
  Future<Result<List<ReputationBorrower>>> getListReputation({
    String? addressWallet,
  }) {
    return runCatchingAsync<List<ReputationBorrowerResponse>,
        List<ReputationBorrower>>(
      () => _client.getListReputation(
        addressWallet,
      ),
      (response) => response.map((e) => e.toDomain()).toList(),
    );
  }

  @override
  Future<Result<PawnshopPackage>> getPawnshopDetail(
      {required String packageId}) {
    return runCatchingAsync<DetailPawnShopResponse, PawnshopPackage>(
      () => _client.getPawnshopPackageDetail(packageId),
      (response) => response.data?.toDomain() ?? PawnshopPackage(),
    );
  }

  @override
  Future<Result<List<ContentNftOnRequestLoanModel>>> getListNftOnLoanRequest({
    String? walletAddress,
    String? page,
    String? size,
    String? name,
    String? nftType,
  }) {
    return runCatchingAsync<NftOnRequestLoanResponse,
        List<ContentNftOnRequestLoanModel>>(
      () => _client.getListNftOnRequestLoan(
        walletAddress ?? '',
        page,
        size,
        name,
        nftType,
      ),
      (response) =>
          response.data?.content?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<NftResAfterPostLoanRequestResponse>> postNftToServer({
    required NftSendLoanRequest request,
  }) {
    return runCatchingAsync<NftResAfterPostLoanRequestResponse,
        NftResAfterPostLoanRequestResponse>(
      () => _client.postNftOnLoanRequest(request),
      (response) => response,
    );
  }

  @override
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
  }) {
    return runCatchingAsync<SendOfferLendCryptoResponse,
        SendOfferLendCryptoModel>(
      () => _client.postSendOfferRequest(
        collateralId,
        loanRequestId,
        duration,
        durationType,
        interestRate,
        latestBlockchainTxn,
        liquidationThreshold,
        loanAmount,
        loanToValue,
        message,
        repaymentToken,
        supplyCurrency,
        walletAddress,
      ),
      (response) => response.data?.toDomain() ?? SendOfferLendCryptoModel(),
    );
  }

  @override
  Future<Result<List<CollateralResultModel>>> getListCollateralMyAcc({
    String? status,
    String? page,
    String? size,
    String? collateralCurrencySymbol,
    String? walletAddress,
    String? sort,
    String? supplyCurrencySymbol,
  }) {
    return runCatchingAsync<ListCollateralResponse,
        List<CollateralResultModel>>(
      () => _client.getListCollateralMyAcc(
        status,
        page,
        size,
        collateralCurrencySymbol,
        walletAddress,
        sort,
        supplyCurrencySymbol,
      ),
      (response) =>
          response.data?.content?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
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
  }) {
    return runCatchingAsync<CreateNewCollateralResponse, ResultCreateNewModel>(
      () => _client.postCreateNewCollateral(
        amount,
        collateral,
        description,
        expectedLoanDurationTime,
        expectedLoanDurationType,
        status,
        supplyCurrency,
        txid,
        walletAddress,
      ),
      (response) => response.data?.toDomain() ?? ResultCreateNewModel(),
    );
  }

  @override
  Future<Result<CollateralDetailMyAcc>> getDetailCollateralMyAcc(
      {String? collateralId}) {
    return runCatchingAsync<CollateralDetailMyAccResponse,
        CollateralDetailMyAcc>(
      () => _client.getDetailCollateralMyAcc(
        collateralId,
      ),
      (response) => response.data?.toDomain() ?? CollateralDetailMyAcc(),
    );
  }

  @override
  Future<Result<List<HistoryCollateralModel>>> getHistoryDetailCollateralMyAcc({
    String? collateralId,
    String? page,
    String? size,
  }) {
    return runCatchingAsync<HistoryCollateralResponse,
        List<HistoryCollateralModel>>(
      () => _client.getHistoryDetailCollateralMyAcc(
        collateralId,
        page,
        size,
      ),
      (response) => response.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<OffersReceivedModel>>> getListReceived({
    String? collateralId,
    String? page,
    String? size,
  }) {
    return runCatchingAsync<OfferReceivedResponse, List<OffersReceivedModel>>(
      () => _client.getListReceived(
        collateralId,
        page,
        size,
      ),
      (response) =>
          response.data?.content?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<SendToLoanPackageModel>>> getListSendToLoanPackage(
      {String? collateralId, String? page, String? size}) {
    return runCatchingAsync<SendToLoanPackageResponse,
        List<SendToLoanPackageModel>>(
      () => _client.getListSendToLoanPackage(
        collateralId,
        page,
        size,
      ),
      (response) => response.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<String>> postCollateralWithdraw({required String id}) {
    return runCatchingAsync<CollateralWithDrawResponse, String>(
      () => _client.postCollateralWithdraw(
        id,
      ),
      (response) => response.error ?? '',
    );
  }

  @override
  Future<Result<OfferDetailMyAcc>> getOfferDetailMyAcc({String? id}) {
    return runCatchingAsync<OfferDetailMyAccResponse, OfferDetailMyAcc>(
      () => _client.getOfferDetailMyAcc(
        id,
      ),
      (response) => response.data?.toDomain() ?? OfferDetailMyAcc(),
    );
  }

  @override
  Future<Result<List<CryptoPawnModel>>> getBorrowContract({
    String? borrowerWalletAddress,
    String? status,
    String? type,
    String? page,
    String? size,
  }) {
    return runCatchingAsync<BorrowListMyAccResponse, List<CryptoPawnModel>>(
      () => _client.getBorrowContract(
        borrowerWalletAddress,
        status,
        type,
        page,
        size,
      ),
      (response) =>
          response.data?.content?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<CheckRateModel>> getCheckRate(
      {String? contractId, String? walletAddress, String? type}) {
    return runCatchingAsync<CheckRateResponse, CheckRateModel>(
      () => _client.getCheckRate(contractId, walletAddress, type),
      (response) => response.data?.toDomain() ?? CheckRateModel.create(),
    );
  }

  @override
  Future<Result<ContractDetailPawn>> getLenderContract(
      {String? id, String? walletAddress, String? type}) {
    return runCatchingAsync<ContractlDetailMyAccResponse, ContractDetailPawn>(
      () => _client.getLenderContract(
        id,
        walletAddress,
        type,
      ),
      (response) => response.data?.toDomain() ?? ContractDetailPawn.name(),
    );
  }

  @override
  Future<Result<RepaymentStatsModel>> getRepaymentHistory({String? id}) {
    return runCatchingAsync<RepaymentStatsResponse, RepaymentStatsModel>(
      () => _client.getRepaymentHistory(
        id,
      ),
      (response) => response.data?.toDomain() ?? RepaymentStatsModel.name(),
    );
  }

  @override
  Future<Result<List<RepaymentRequestModel>>> getRepaymentResquest({
    String? id,
    String? page,
    String? size,
  }) {
    return runCatchingAsync<RepaymentRequestResponse,
        List<RepaymentRequestModel>>(
      () => _client.getRepaymentResquest(
        id,
        page,
        size,
      ),
      (response) =>
          response.data?.content?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<RepaymentRequestModel>>> getListItemRepayment({
    String? id,
    String? page,
    String? size,
  }) {
    return runCatchingAsync<RepaymentRequestResponse,
        List<RepaymentRequestModel>>(
      () => _client.getListItemRepayment(
        id,
        page,
        size,
      ),
      (response) =>
          response.data?.content?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<TotalRepaymentModel>> getTotalRepayment({String? id}) {
    return runCatchingAsync<TotalRepaymentResponse, TotalRepaymentModel>(
      () => _client.getTotalRepayment(
        id,
      ),
      (response) => response.data?.toDomain() ?? TotalRepaymentModel.name(),
    );
  }
}
