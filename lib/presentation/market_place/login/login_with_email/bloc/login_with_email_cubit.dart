import 'dart:async';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/nonce_model.dart';
import 'package:Dfy/domain/repository/market_place/nonce_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'login_with_email_state.dart';

class LoginWithEmailCubit extends Cubit<LoginWithEmailState> {
  LoginWithEmailCubit() : super(LoginWithEmailInitial());

  BehaviorSubject<String> validateTextSubject = BehaviorSubject.seeded('');

  BehaviorSubject<int> timeCountDownSubject = BehaviorSubject();

  BehaviorSubject<bool> isEnableResendSubject = BehaviorSubject.seeded(false);

  Stream<String> get validateStream => validateTextSubject.stream;

  Stream<int> get timeCountDownStream => timeCountDownSubject.stream;

  Stream<bool> get isEnableResendStream => isEnableResendSubject.stream;

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
    timeCountDownSubject.sink.add(60);

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
}
