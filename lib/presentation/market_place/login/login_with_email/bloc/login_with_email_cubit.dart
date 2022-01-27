import 'dart:async';
import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:Dfy/domain/repository/market_place/login_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'login_with_email_state.dart';

class LoginWithEmailCubit extends BaseCubit<LoginWithEmailState> {
  LoginWithEmailCubit() : super(LoginWithEmailInitial());

  BehaviorSubject<String> validateTextSubject = BehaviorSubject.seeded('');

  BehaviorSubject<bool> isCheckedCheckboxSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<int> timeCountDownSubject = BehaviorSubject();

  BehaviorSubject<bool> isEnableResendSubject = BehaviorSubject.seeded(false);

  Stream<String> get validateStream => validateTextSubject.stream;

  Stream<int> get timeCountDownStream => timeCountDownSubject.stream;

  Stream<bool> get isEnableResendStream => isEnableResendSubject.stream;

  Stream<bool> get isCheckedCheckBoxStream => isCheckedCheckboxSubject.stream;

  void setCheckboxValue(){
    isCheckedCheckboxSubject.sink.add(!isCheckedCheckboxSubject.value);
  }

  void dispose(){
    validateTextSubject.close();
    isCheckedCheckboxSubject.close();
    timeCountDownSubject.close();
    isEnableResendSubject.close();
  }

  bool checkValidate(String email) {
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    if (!emailValid) {
      validateTextSubject.sink.add(S.current.email_invalid);
      return false;
    }
    if (email.length > 50) {
      validateTextSubject.sink.add(S.current.email_too_long);
      return false;
    }
    validateTextSubject.sink.add('');
    return true;
  }

  void startTimer({int timeStart = 60}) {
    const oneSec = Duration(milliseconds: 1000);
    timeCountDownSubject.sink.add(timeStart);

    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timeStart == 0) {
          timer.cancel();
          timeCountDownSubject.sink.add(0);
          isEnableResendSubject.sink.add(true);
        } else {
          timeStart--;
          timeCountDownSubject.sink.add(timeStart);
          isEnableResendSubject.sink.add(false);
        }
      },
    );
  }

  LoginRepository get loginRepo => Get.find();

  Future<String> sendOTP({required String email, required int type}) async {
    String transactionId = '';
    final result = await loginRepo.sendOTP(email, type);
    result.when(
      success: (res) {
        transactionId = res.transactionId ?? '';
      },
      error: (err) {
        showError();
      },
    );
    return transactionId;
  }

  Future<bool> verifyOTP({
    required String otp,
    required String transactionID,
  }) async {
    bool isSuccess = false;
    showLoading();
    final result = await loginRepo.verifyOTP(otp, transactionID);
    await result.when(
      success: (res) async {
        await PrefsService.saveWalletLogin(
          loginToJson(res),
        );
        await getUserProfile();
        showContent();
        isSuccess = true;
      },
      error: (err) {
        isSuccess = false;
      },
    );
    return isSuccess;
  }

  Future<void> getUserProfile() async {
    final result = await loginRepo.getUserProfile();
    await result.when(
      success: (res) async {
        final UserProfileModel userProfile =
        UserProfileModel.fromJson(res.data ?? {});
        await PrefsService.saveUserProfile(userProfileToJson(userProfile));
      },
      error: (err) async {
        await PrefsService.saveUserProfile(
          PrefsService.userProfileEmpty(),
        );
      },
    );
  }
}

