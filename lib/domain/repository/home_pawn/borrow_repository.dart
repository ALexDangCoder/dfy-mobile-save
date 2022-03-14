import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/pawn/borrow/nft_on_request_loan_model.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/domain/model/pawn/crypto_collateral.dart';
import 'package:Dfy/domain/model/pawn/pawn_shop_model.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';

mixin BorrowRepository {
  Future<Result<List<PawnshopPackage>>> getListPawnshop({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
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
    String? cusSort,
  });

  Future<Result<List<CryptoCollateralModel>>> getListCryptoCollateral(
      String walletAddress,
      String packageId,
      String page,);

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
  });

  Future<Result<List<ContentNftOnRequestLoanModel>>> getListNftOnLoanRequest({
    String walletAddress,
    String? page,
    String? size,
  });
}
