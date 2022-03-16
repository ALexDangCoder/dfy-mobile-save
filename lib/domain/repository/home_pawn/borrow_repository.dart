import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/home_pawn/asset_filter_model.dart';
import 'package:Dfy/domain/model/home_pawn/send_offer_lend_crypto_model.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/pawn/borrow/nft_on_request_loan_model.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/domain/model/pawn/crypto_collateral.dart';
import 'package:Dfy/domain/model/pawn/detail_collateral.dart';
import 'package:Dfy/domain/model/pawn/pawn_shop_model.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/domain/model/pawn/reputation_borrower.dart';

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
  });

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
  });

  Future<Result<String>> confirmCollateralToBe({
    required Map<String, String> map,
  });
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
}
