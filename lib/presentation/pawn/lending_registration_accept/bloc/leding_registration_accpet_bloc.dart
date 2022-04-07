import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/phone_code_model.dart';
import 'package:Dfy/domain/repository/hard_nft_my_account/step1/step1_repository.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'leding_registration_accpet_state.dart';

class LendingRegistrationAcceptBloc
    extends BaseCubit<LendingRegistrationAcceptState> {
  BehaviorSubject<bool> isCheckBtn = BehaviorSubject.seeded(false);
  List<String> listPhone = [];

  LendingRegistrationAcceptBloc() : super(LendingRegistrationAcceptInitial());

  Step1Repository get _step1Repository => Get.find();

  Future<void> getPhonesApi() async {
    showLoading();
    emit(
      LendingRegistrationAcceptLoading(),
    );
    final Result<List<PhoneCodeModel>> resultPhone =
        await _step1Repository.getPhoneCode();
    resultPhone.when(
      success: (res) {
        listPhone.addAll(
          res.map((e) => e.code.toString()).toList(),
        );
        emit(
          LendingRegistrationAcceptSuccess(
            CompleteType.SUCCESS,
          ),
        );
        showContent();
      },
      error: (error) {
        emit(
          LendingRegistrationAcceptSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
      },
    );
  }
}
