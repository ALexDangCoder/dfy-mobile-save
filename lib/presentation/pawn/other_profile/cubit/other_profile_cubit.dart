import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/borrow_available_collateral.dart';
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
  BehaviorSubject<String> reputationBorrowStream = BehaviorSubject.seeded('');
  BehaviorSubject<String> reputationLenderStream = BehaviorSubject.seeded('');
  BehaviorSubject<bool> getDataBorrow = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> seeMoreCollateral = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> seeMoreSignContract = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> seeMoreMessage = BehaviorSubject.seeded(false);
  UserProfile userProfile = UserProfile();
  List<Reputation> reputation = [];
  List<String> walletAddress = [
    'All Wallet',
  ];
  String message = '';
  String userId = '';
  int totalReputationBorrow = 0;
  int totalReputationLender = 0;

  Future<void> getUserProfile({String? userId}) async {
    showLoading();
    final Result<UserProfile> result =
        await _repo.getUserProfile(userId: userId);
    result.when(
      success: (res) {
        getBorrowUser();
        getSignedContract();
        getListCollateral();
        getListSignedContract();
        emit(OtherProfileSuccess(
          CompleteType.SUCCESS,
          userProfile: res,
        ));
      },
      error: (error) {
        emit(OtherProfileSuccess(
          CompleteType.SUCCESS,
          message: error.message,
        ));
      },
    );
  }

  /// Detail Borrower
  BorrowAvailableCollateral available = BorrowAvailableCollateral();
  BorrowAvailableCollateral signedContract = BorrowAvailableCollateral();
  List<CollateralUser> listCollateral = [];
  List<SignedContractUser> listSignedContract = [];

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
