import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/borrow_available_collateral.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/reputation.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';

mixin UsersRepository {
  Future<Result<UserProfile>> getUserProfile({String? userId});
  Future<Result<UserProfile>> getMyUserProfile();

  Future<Result<List<Reputation>>> getListReputation({String? userId});

  Future<Result<BorrowAvailableCollateral>> getBorrowUser({
    String? userId,
    String? walletAddress,
  });

  Future<Result<BorrowAvailableCollateral>> getBorrowSignContractUser({
    String? userId,
    String? walletAddress,
  });

  Future<Result<List<CollateralUser>>> getListCollateral({
    String? userId,
    String? walletAddress,
  });

  Future<Result<List<SignedContractUser>>> getListSignedContract({
    String? userId,
    String? walletAddress,
  });

  Future<Result<List<SignedContractUser>>> getListLoanSignedContract({
    String? userId,
    String? walletAddress,
  });

  Future<Result<List<CommentBorrow>>> getListComment({
    String? userId,
    String? walletAddress,
  });

  Future<Result<BorrowAvailableCollateral>> getLenderSignContractUser({
    String? userId,
    String? walletAddress,
  });

  Future<Result<LendingSetting>> getLendingSetting({String? userId});

  Future<Result<List<PawnshopPackage>>> getListLoanPackage(
    String pawnshopId, {
    String? userId,
    String? walletAddress,
  });
}
