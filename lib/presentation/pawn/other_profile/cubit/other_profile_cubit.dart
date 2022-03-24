import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/borrow_available_collateral.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/reputation.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/domain/repository/home_pawn/user_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'other_profile_state.dart';

class OtherProfileCubit extends BaseCubit<OtherProfileState> {
  OtherProfileCubit() : super(OtherProfileInitial());

  UsersRepository get _repo => Get.find();

  BehaviorSubject<String> titleStream = BehaviorSubject.seeded('');
  BehaviorSubject<String> reputationBorrowStream = BehaviorSubject.seeded('0');
  BehaviorSubject<String> reputationLenderStream = BehaviorSubject.seeded('0');
  BehaviorSubject<bool> getDataBorrow = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> getDataLender = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> seeMoreCollateral = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> viewMoreCollateral = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> seeMoreSignContract = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> viewMoreSignContract = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> seeMoreMessage = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> viewMoreMessage = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> seeMoreLendingSetting = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> viewMoreLendingSetting = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> seeMoreLenderSignContract =
      BehaviorSubject.seeded(false);
  BehaviorSubject<bool> viewMoreLenderSignContract =
      BehaviorSubject.seeded(false);
  UserProfile userProfile = UserProfile();
  List<Reputation> reputation = [];
  List<String> walletAddress = [
    'All Wallet',
  ];
  String message = '';
  String userId = '';
  String pawnshopId = '';
  int totalReputationBorrow = 0;
  int totalReputationLender = 0;

  void selectWalletBorrow(String? walletAddress) {
    getDataBorrow.add(false);
    seeMoreCollateral.add(false);
    viewMoreCollateral.add(false);
    seeMoreSignContract.add(false);
    viewMoreSignContract.add(false);
    seeMoreMessage.add(false);
    viewMoreMessage.add(false);
    if (walletAddress != 'All Wallet') {
      getBorrowUser(walletAddress: walletAddress);
      getSignedContract(walletAddress: walletAddress);
      getListCollateral(walletAddress: walletAddress);
      getListSignedContract(walletAddress: walletAddress);
      getListComment(walletAddress: walletAddress);
    } else {
      getBorrowUser();
      getSignedContract();
      getListCollateral();
      getListSignedContract();
      getListComment();
    }
  }

  void selectWalletLender(String? walletAddress) {
    getDataLender.add(false);
    seeMoreLendingSetting.add(false);
    viewMoreLendingSetting.add(false);
    seeMoreLenderSignContract.add(false);
    viewMoreLenderSignContract.add(false);
    if (walletAddress != 'All Wallet') {
      getSignedContractLender(walletAddress: walletAddress);
      getLendingSetting();
      getListLenderSignedContract(walletAddress: walletAddress);
      getListLoanPage(pawnshopId, walletAddress: walletAddress);
    } else {
      getSignedContractLender();
      getLendingSetting();
      getListLenderSignedContract();
      getListLoanPage(pawnshopId);
    }
  }

  Future<void> getMyUserProfile() async {
    showLoading();
    final Result<UserProfile> result = await _repo.getMyUserProfile();
    result.when(
      success: (res) {
        if (res.pawnshop != null) {
          userId = res.pawnshop?.userId.toString() ?? '';
          getReputation(userId: res.pawnshop?.userId.toString() ?? '');
          getListComment();
        }
        emit(
          OtherProfileSuccess(
            CompleteType.SUCCESS,
            userProfile: res,
          ),
        );
      },
      error: (err) {
        if (err.code == CODE_USER_NOT_FOUND) {
          emit(
            OtherProfileSuccess(
              CompleteType.SUCCESS,
              userProfile: userProfile,
            ),
          );
        } else {
          emit(
            OtherProfileSuccess(
              CompleteType.ERROR,
              message: err.message,
            ),
          );
        }
      },
    );
  }

  Future<void> getUserProfile({String? userId}) async {
    showLoading();
    final Result<UserProfile> result =
        await _repo.getUserProfile(userId: userId);
    result.when(
      success: (res) {
        pawnshopId = res.pawnshop?.id.toString() ?? '';
        getBorrowUser();
        getSignedContract();
        getListCollateral();
        getListSignedContract();
        getListComment();
        getSignedContractLender();
        getLendingSetting();
        getListLenderSignedContract();
        getListLoanPage(pawnshopId);
        emit(
          OtherProfileSuccess(
            CompleteType.SUCCESS,
            userProfile: res,
          ),
        );
      },
      error: (error) {
        emit(
          OtherProfileSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
      },
    );
  }

  /// Detail Lender

  BorrowAvailableCollateral lenderSignedContract = BorrowAvailableCollateral();
  LendingSetting lendingSetting = LendingSetting();
  List<SignedContractUser> listLenderSignedContract = [];

  List<PawnshopPackage> listLoanPackage = [];

  Future<void> getSignedContractLender({String? walletAddress}) async {
    final Result<BorrowAvailableCollateral> result =
        await _repo.getLenderSignContractUser(
      userId: userId,
      walletAddress: walletAddress,
    );
    result.when(
      success: (res) {
        lenderSignedContract = res;
        getDataLender.add(true);
      },
      error: (err) {},
    );
  }

  Future<void> getLendingSetting() async {
    final Result<LendingSetting> result = await _repo.getLendingSetting(
      userId: userId,
    );
    result.when(
      success: (res) {
        lendingSetting = res;
        getDataLender.add(true);
      },
      error: (err) {},
    );
  }

  Future<void> getListLenderSignedContract({String? walletAddress}) async {
    final Result<List<SignedContractUser>> result =
        await _repo.getListLoanSignedContract(
      userId: userId,
      walletAddress: walletAddress,
    );
    result.when(
      success: (res) {
        listLenderSignedContract = res;
        getDataLender.add(true);
      },
      error: (err) {},
    );
  }

  Future<void> getListLoanPage(String pawnShopId,
      {String? walletAddress}) async {
    final Result<List<PawnshopPackage>> result = await _repo.getListLoanPackage(
      pawnShopId,
      userId: userId,
      walletAddress: walletAddress,
    );
    result.when(
      success: (res) {
        listLoanPackage = res;
        getDataLender.add(true);
      },
      error: (err) {},
    );
  }

  /// Detail Borrower
  BorrowAvailableCollateral available = BorrowAvailableCollateral();
  BorrowAvailableCollateral signedContract = BorrowAvailableCollateral();
  List<CollateralUser> listCollateral = [];
  List<SignedContractUser> listSignedContract = [];
  List<CommentBorrow> listComment = [];

  Future<void> getListComment({String? walletAddress}) async {
    final Result<List<CommentBorrow>> result = await _repo.getListComment(
      userId: userId,
      walletAddress: walletAddress != 'All Wallet' ? walletAddress : '',
    );
    result.when(
      success: (res) {
        listComment = res;
        getDataBorrow.add(true);
      },
      error: (err) {},
    );
  }

  Future<void> getListCollateral({String? walletAddress}) async {
    final Result<List<CollateralUser>> result = await _repo.getListCollateral(
      userId: userId,
      walletAddress: walletAddress,
    );
    result.when(
      success: (res) {
        listCollateral = res;
        getDataBorrow.add(true);
      },
      error: (err) {},
    );
  }

  Future<void> getListSignedContract({String? walletAddress}) async {
    final Result<List<SignedContractUser>> result =
        await _repo.getListSignedContract(
      userId: userId,
      walletAddress: walletAddress,
    );
    result.when(
      success: (res) {
        listSignedContract = res;
        getDataBorrow.add(true);
      },
      error: (err) {},
    );
  }

  Future<void> getBorrowUser({String? walletAddress}) async {
    final Result<BorrowAvailableCollateral> result = await _repo.getBorrowUser(
      userId: userId,
      walletAddress: walletAddress,
    );
    result.when(
      success: (res) {
        available = res;
        getDataBorrow.add(true);
      },
      error: (err) {},
    );
  }

  Future<void> getSignedContract({String? walletAddress}) async {
    final Result<BorrowAvailableCollateral> result =
        await _repo.getBorrowSignContractUser(
      userId: userId,
      walletAddress: walletAddress,
    );
    result.when(
      success: (res) {
        signedContract = res;
        getDataBorrow.add(true);
      },
      error: (err) {},
    );
  }

  Future<void> getReputation({String? userId}) async {
    final Result<List<Reputation>> result =
        await _repo.getListReputation(userId: userId);
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          for (final element in res) {
            if (element.walletAddress != '') {
              reputation.add(element);
              totalReputationBorrow =
                  totalReputationBorrow + (element.reputationBorrower ?? 0);
              totalReputationLender =
                  totalReputationLender + (element.reputationLender ?? 0);
            }
          }
          for (final element in res) {
            if (element.walletAddress != '') {
              walletAddress.add(element.walletAddress ?? '');
            }
          }
          getPoint(walletAddress[0]);
          getPointLender(walletAddress[0]);
        }
      },
      error: (error) {
        showError();
      },
    );
  }

  void getPoint(String item) {
    if (item == 'All Wallet') {
      reputationBorrowStream.add(totalReputationBorrow.toString());
    } else {
      for (final element in reputation) {
        if (item == element.walletAddress) {
          reputationBorrowStream.add(element.reputationBorrower.toString());
        }
      }
    }
  }

  void getPointLender(String item) {
    if (item == 'All Wallet') {
      reputationLenderStream.add(totalReputationLender.toString());
    } else {
      for (final element in reputation) {
        if (item == element.walletAddress) {
          reputationLenderStream.add(element.reputationLender.toString());
        }
      }
    }
  }

  void setTitle(int index) {
    if (index == 0) {
      titleStream.add('Borrower profile');
    } else {
      titleStream.add('Lender profile');
    }
  }

  String date() {
    final DateTime data = DateTime.fromMillisecondsSinceEpoch(
      userProfile.pawnshop?.createAt ?? 0,
    );
    String month = '';
    switch (data.month) {
      case 1:
        month = S.current.january;
        break;
      case 2:
        month = S.current.february;
        break;
      case 3:
        month = S.current.march;
        break;
      case 4:
        month = S.current.april;
        break;
      case 5:
        month = S.current.may;
        break;
      case 6:
        month = S.current.june;
        break;
      case 7:
        month = S.current.july;
        break;
      case 8:
        month = S.current.august;
        break;
      case 9:
        month = S.current.september;
        break;
      case 10:
        month = S.current.october;
        break;
      case 11:
        month = S.current.november;
        break;
      case 12:
        month = S.current.december;
        break;
    }
    return '$month${data.year}';
  }
}
