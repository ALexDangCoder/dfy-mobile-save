import 'package:Dfy/data/request/pawn/lender/create_new_loan_package_request.dart';
import 'package:Dfy/data/response/home_pawn/official_pawn_with_token_res.dart';
import 'package:Dfy/data/response/pawn/manage_package/list_pawn_shop_package_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/home_pawn/pawn_shop_model.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/domain/model/pawn/manage_loan_package/infor_after_post_new_loan_package.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';

mixin ManageLoanPackageRepository {
  Future<Result<PawnShopModel>> getFindUserId({
    String? userId,
  });

  Future<Result<List<PawnshopPackage>>> getListPawnShopPackage({
    String? page,
    String? size,
    String? walletAddress,
    required String id,
  });

  Future<Result<List<CollateralResultModel>>> getListCollateral({
    required String id,
    String? page,
    String? size,
  });

  Future<Result<PawnshopPackage>> getPawnshopDetail({
    required String packageId,
  });

  Future<Result<InfoAfterPostNewLoanPackage>> postInfoNewLoanPackage({
    CreateNewLoanPackageRequest? createNewLoanPackageRequest,
  });
}
