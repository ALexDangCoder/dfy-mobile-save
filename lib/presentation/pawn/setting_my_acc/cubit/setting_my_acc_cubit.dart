import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/domain/repository/home_pawn/user_repository.dart';
import 'package:Dfy/domain/repository/market_place/wallet_address_respository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'setting_my_acc_state.dart';

class SettingMyAccCubit extends BaseCubit<SettingMyAccState> {
  SettingMyAccCubit() : super(SettingMyAccInitial());

  WalletAddressRepository get _walletAddressRepository => Get.find();

  UsersRepository get _repo => Get.find();

  EmailSetting emailSetting = EmailSetting();
  NotiSetting notiSetting = NotiSetting();
  List<WalletAddressModel> listWallet = [];

  Future<void> getListWallet() async {
    showLoading();
    final Result<List<WalletAddressModel>> result =
        await _walletAddressRepository.getListWalletAddress();
    result.when(
      success: (res) {
        for (final element in res) {
          if (element.walletAddress != '') {
            listWallet.add(element);
          }
        }
        emit(SettingWallet(listWallet));
        showContent();
      },
      error: (err) {},
    );
  }

  Future<void> getEmailSetting() async {
    final Result<EmailSetting> result = await _repo.getEmailSetting();
    result.when(
      success: (res) {
        emailSetting = res;
        emit(SettingEmail(emailSetting));
        showContent();
      },
      error: (err) {},
    );
  }

  Future<void> putEmailSetting() async {
    final Map<String, dynamic> map = {
      'activitiesEmail': emailSetting.activitiesEmail,
      'email': emailSetting.email,
      'notificationEmail': emailSetting.notificationEmail,
      'otherUserEmail': emailSetting.otherUserEmail,
    };

    final Result<EmailSetting> result = await _repo.putEmailSetting(map);
    result.when(
      success: (res) {
        emailSetting = res;
        emit(SettingEmail(emailSetting));
        showContent();
      },
      error: (err) {},
    );
  }

  Future<void> getNotiSetting() async {
    final Result<NotiSetting> result = await _repo.getNotiSetting();
    result.when(
      success: (res) {
        notiSetting = res;
        emit(SettingNotification(notiSetting));
        showContent();
      },
      error: (err) {},
    );
  }

  void removeWallet(String wallet){
    listWallet.removeWhere((element) => element.walletAddress == wallet);
    emit(SettingEmail(emailSetting));
    putDisconnectWallet(wallet);
  }

  Future<void> putDisconnectWallet(String walletAddress) async {
    final Map<String, String> data = {
      'walletAddress': walletAddress,

    };
    final Result<String> code = await _repo.disconnectWalletToBe(map: data);
    code.when(
      success: (res) {

      },
      error: (error) {
      },
    );
  }

  Future<void> putNotiSetting() async {
    final Map<String, dynamic> map = {
      'activitiesNoti': notiSetting.activitiesNoti,
      'email': notiSetting.email,
      'hotNewNoti': notiSetting.hotNewNoti,
      'newSystemNoti': notiSetting.newSystemNoti,
      'warningNoti': notiSetting.warningNoti,
    };
    final Result<NotiSetting> result = await _repo.putNotiSetting(map);
    result.when(
      success: (res) {
        notiSetting = res;
        emit(SettingNotification(notiSetting));
        showContent();
      },
      error: (err) {},
    );
  }
}
