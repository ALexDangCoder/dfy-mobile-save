import 'package:Dfy/data/request/pawn/lender/create_new_loan_package_request.dart';
import 'package:Dfy/data/response/home_pawn/list_collateral_response.dart';
import 'package:Dfy/data/response/home_pawn/official_pawn_with_token_res.dart';
import 'package:Dfy/data/response/pawn/manage_package/detail_pawn_shop_package_response.dart';
import 'package:Dfy/data/response/pawn/manage_package/find_by_user_id_response.dart';
import 'package:Dfy/data/response/pawn/manage_package/info_after_post_new_loan_package_response.dart';
import 'package:Dfy/data/response/pawn/manage_package/list_pawn_shop_package_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/pawn/setting_package_lender/setting_package_lender_service.dart';
import 'package:Dfy/domain/model/home_pawn/pawn_shop_model.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/domain/model/pawn/manage_loan_package/infor_after_post_new_loan_package.dart';
import 'package:Dfy/domain/model/pawn/manage_loan_package/pawnshop_package_model.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/repository/pawn/manage_loan_package/manage_loan_package_repository.dart';

class ManageLoanPackageImplement implements ManageLoanPackageRepository {
  final SettingPackageLenderService _client;

  ManageLoanPackageImplement(this._client);

  @override
  Future<Result<PawnShopModel>> getFindUserId({String? userId}) {
    return runCatchingAsync<FindByUserIdTotalResponse, PawnShopModel>(
      () => _client.getFindByUserId(
        userId,
      ),
      (response) => response.data.toModel(),
    );
  }

  @override
  Future<Result<List<PawnshopPackage>>> getListPawnShopPackage(
      {String? page, String? size, String? walletAddress, required String id}) {
    return runCatchingAsync<PawnShopPackageTotalResponse,
        List<PawnshopPackage>>(
      () => _client.getListPawnShopPackage(
        id,
        page,
        size,
        walletAddress,
      ),
      (response) =>
          response.data?.content?.map((e) => e.toPawnShop()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<CollateralResultModel>>> getListCollateral(
      {required String id, String? page, String? size}) {
    return runCatchingAsync<ListCollateralResponse,
        List<CollateralResultModel>>(
      () => _client.getListCollateral(id, page, size),
      (response) =>
          response.data?.content?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<PawnshopPackage>> getPawnshopDetail(
      {required String packageId}) {
    return runCatchingAsync<DetailPawnShopPackageResponse, PawnshopPackage>(
      () => _client.getPawnshopPackageDetail(packageId),
      (response) => response.data?.toDomain() ?? PawnshopPackage(),
    );
  }

  @override
  Future<Result<InfoAfterPostNewLoanPackage>> postInfoNewLoanPackage(
      {CreateNewLoanPackageRequest? createNewLoanPackageRequest}) {
    return runCatchingAsync<InfoAfterPostNewLoanPackageResponse,
        InfoAfterPostNewLoanPackage>(
      () => _client.postInfoNewLoanPackage(createNewLoanPackageRequest),
      (response) => response.toModel(),
    );
  }

//
// @override
// Future<Result<List<CryptoPawnModel>>> getListOfferSentCrypto(
//     {String? type,
//       String? page,
//       String? size,
//       String? status,
//       String? userId,
//       String? sort,
//       String? walletAddress}) {
//   return runCatchingAsync<LenderContractNftReponse,
//       List<CryptoPawnModel>>(
//         () => _client.getListCryptoFtNft(
//       type,
//       page,
//       size,
//       status,
//       userId,
//       sort,
//       walletAddress,
//     ),
//         (response) =>
//     response.data?.content?.map((e) => e.toDomain()).toList() ?? [],
//   );
// }
}
