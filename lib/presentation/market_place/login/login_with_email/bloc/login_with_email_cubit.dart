import 'dart:developer';

import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/nonce_model.dart';
import 'package:Dfy/domain/repository/market_place/nonce_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:meta/meta.dart';

part 'login_with_email_state.dart';

class LoginWithEmailCubit extends Cubit<LoginWithEmailState> {
  LoginWithEmailCubit() : super(LoginWithEmailInitial());

  NonceRepository get _nonceRepository => Get.find();

  void checkValidate(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      emit(EmailInvalid());
      return;
    }
    if (email.length > 50) {
      emit(EmailTooLong());
      return;
    }
    emit(ValidateSuccess());
  }

  Future<void> getNonce({required String walletAddress}) async {
    final Result<NonceModel> result =
        await _nonceRepository.getNonce(walletAddress);
    result.when(
        success: (res) {
        },
        error: (err) {
          log(err.message);
        });
  }
}
