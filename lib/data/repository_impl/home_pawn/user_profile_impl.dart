import 'package:Dfy/data/response/pawn/user_profile/borrow_total_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/lending_setting_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_collateral_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_comment_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_loan_package_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/list_signed_contract_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/reputation_response.dart';
import 'package:Dfy/data/response/pawn/user_profile/user_profile_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/home_pawn/user_profile_service.dart';
import 'package:Dfy/domain/model/pawn/borrow_available_collateral.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/reputation.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/domain/repository/home_pawn/user_repository.dart';
import 'package:Dfy/utils/constants/api_constants.dart';

class UserProfileRepositoryImpl implements UsersRepository {
  final UserProfileService _userService;

  UserProfileRepositoryImpl(this._userService);

  @override
  Future<Result<UserProfile>> getUserProfile({String? userId}) {
    return runCatchingAsync<UserProfileResponse, UserProfile>(
      () => _userService.getUserProfile(userId ?? ''),
      (response) => response.data?.toDomain() ?? UserProfile(),
    );
  }

  @override
  Future<Result<List<Reputation>>> getListReputation({String? userId}) {
    return runCatchingAsync<List<ReputationResponse>, List<Reputation>>(
      () => _userService.getReputation(userId ?? ''),
      (response) => response.map((e) => e.toDomain()).toList(),
    );
  }

  @override
  Future<Result<BorrowAvailableCollateral>> getBorrowUser(
      {String? userId, String? walletAddress}) {
    return runCatchingAsync<BorrowResponse, BorrowAvailableCollateral>(
      () => _userService.getBorrowCollateralUser(
          userId ?? '', walletAddress ?? ''),
      (response) =>
          response.data?.toCollateral() ?? BorrowAvailableCollateral(),
    );
  }

  @override
  Future<Result<BorrowAvailableCollateral>> getBorrowSignContractUser(
      {String? userId, String? walletAddress}) {
    // TODO: implement getBorrowSignContractUser
    return runCatchingAsync<BorrowResponse, BorrowAvailableCollateral>(
      () => _userService.getBorrowSignContractUser(
          userId ?? '', walletAddress ?? ''),
      (response) =>
          response.data?.toSignContract() ?? BorrowAvailableCollateral(),
    );
  }

  @override
  Future<Result<List<CollateralUser>>> getListCollateral(
      {String? userId, String? walletAddress}) {
    return runCatchingAsync<ListCollateralUser, List<CollateralUser>>(
      () => _userService.getListCollateral(
        userId ?? '',
        walletAddress ?? '',
        ApiConstants.DEFAULT_PAGE_SIZE.toString(),
        '3',
        '1',
      ),
      (response) => response.data?.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<SignedContractUser>>> getListSignedContract(
      {String? userId, String? walletAddress}) {
    return runCatchingAsync<ListSignedContractUser, List<SignedContractUser>>(
      () => _userService.getListSignedContract(
        userId ?? '',
        walletAddress ?? '',
        ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      ),
      (response) => response.data?.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<CommentBorrow>>> getListComment(
      {String? userId, String? walletAddress}) {
    return runCatchingAsync<ListCommentUser, List<CommentBorrow>>(
      () => _userService.getListCommentUser(
        userId ?? '',
        walletAddress ?? '',
        ApiConstants.DEFAULT_PAGE_SIZE.toString(),
        '0',
      ),
      (response) => response.data?.toDomain() ?? [],
    );
  }

  @override
  Future<Result<BorrowAvailableCollateral>> getLenderSignContractUser({
    String? userId,
    String? walletAddress,
  }) {
    return runCatchingAsync<BorrowResponse, BorrowAvailableCollateral>(
      () => _userService.getLenderSignContractUser(
        userId ?? '',
        walletAddress ?? '',
      ),
      (response) =>
          response.data?.toSignContract() ?? BorrowAvailableCollateral(),
    );
  }

  @override
  Future<Result<LendingSetting>> getLendingSetting({String? userId}) {
    return runCatchingAsync<LendingSettingResponse, LendingSetting>(
      () => _userService.getLendingSetting(
        userId ?? '',
      ),
      (response) => response.data?.toDomain() ?? LendingSetting(),
    );
  }

  @override
  Future<Result<List<SignedContractUser>>> getListLoanSignedContract(
      {String? userId, String? walletAddress}) {
    return runCatchingAsync<ListSignedContractUser, List<SignedContractUser>>(
      () => _userService.getListLoanSignedContract(
        userId ?? '',
        walletAddress ?? '',
        ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      ),
      (response) => response.data?.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<PawnshopPackage>>> getListLoanPackage(String pawnshopId,
      {String? userId, String? walletAddress}) {
    return runCatchingAsync<ListLoanPackage, List<PawnshopPackage>>(
      () => _userService.getListLoanPackage(
        pawnshopId,
        userId ?? '',
        walletAddress ?? '',
        '1',
        '0,1,2',
        ApiConstants.DEFAULT_PAGE_SIZE.toString(),
        '0',
      ),
      (response) => response.data?.toDomain() ?? [],
    );
  }

  @override
  Future<Result<UserProfile>> getMyUserProfile() {
    return runCatchingAsync<UserProfileResponse, UserProfile>(
          () => _userService.getMyUserProfile(),
          (response) => response.data?.toDomain() ?? UserProfile(),
    );
  }
}
