import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
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
  UserProfile userProfile = UserProfile();
  String message = '';

  Future<void> getUserProfile({String? userId}) async {
    showLoading();
    final Result<UserProfile> result =
    await _repo.getUserProfile(userId: userId);
    result.when(
      success: (res) {
        emit(OtherProfileSuccess(CompleteType.SUCCESS,userProfile: res,));
      },
      error: (error) {
        emit(OtherProfileSuccess(CompleteType.SUCCESS,message: error.message,));
      },
    );
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
