import 'package:Dfy/data/response/home_pawn/crypto_collateral_res.dart';
import 'package:Dfy/data/response/home_pawn/pawnshop_packgae_response.dart';
import 'package:Dfy/data/response/home_pawn/personal_lending_hard_response.dart';
import 'package:Dfy/data/response/home_pawn/personal_lending_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/home_pawn/borrow_service.dart';
import 'package:Dfy/domain/model/pawn/crypto_collateral.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
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
}
