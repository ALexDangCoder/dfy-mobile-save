import 'package:Dfy/presentation/create_wallet_first_time/setup_password/helper/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';
part 'check_pass_state.dart';
class CheckPassCubit extends Cubit<CheckPassState> {


  CheckPassCubit() : super(CheckPassInitial());

  final BehaviorSubject<bool> _validatePW = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _matchPW =  BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _showPW =  BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _showConfirmPW = BehaviorSubject<bool>.seeded(true);

  Stream<bool> get validatePWStream => _validatePW.stream;
  Stream<bool> get matchPWStream => _matchPW.stream;
  Stream<bool> get showPWStream => _showPW.stream;
  Stream<bool> get showConfirmPWStream => _showConfirmPW.stream;

  Sink<bool> get validatePWSink => _validatePW.sink;
  Sink<bool> get matchPWSink => _matchPW.sink;
  Sink<bool> get showPWSink => _showPW.sink;
  Sink<bool> get showConfirmPWSink => _showConfirmPW.sink;



  void isValidate(String value) {
    if (Validator.validateStructure(value)) {
      //if validate widget warning will not appear
      validatePWSink.add(false);
    } else {
      validatePWSink.add(true);
    }
  }

  void isMatchPW({required String password, required String confirmPW}) {
    if(password == confirmPW) {
      //if equal widget warning will not appear
      matchPWSink.add(false);
    } else {
      matchPWSink.add(true);
    }
  }

  void isShowPW(int index) {
    if(index == 1) {
      //if 1 show pass
      showPWSink.add(false);
    } else {
      showPWSink.add(true);
    }
  }

  void isShowConfirmPW(int index) {
    if(index == 1) {
      //if 1 show pass
      showConfirmPWSink.add(false);
    } else {
      showConfirmPWSink.add(true);
    }
  }


  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    String privateKey;
    String walletAddress;
    String passPhrase;
    switch (methodCall.method) {
      case 'generateWalletCallBack':
        privateKey = methodCall.arguments['privateKey'];
        walletAddress = methodCall.arguments['walletAddress'];
        passPhrase = methodCall.arguments['passPhrase'];
        break;
      default:
        break;
    }
  }

  // Future<void> checkPasswordWallet(String password) async {
  //   try {
  //     final data = {
  //       'password': password,
  //     };
  //     await trustWalletChannel.invokeMethod('checkPassword', data);
  //   } on PlatformException {}
  // }

  Future<void> generateWallet({required String password}) async {
    try {
      final data = {
        'password': password,
      };
      await trustWalletChannel.invokeMethod('generateWallet', data);
    } on PlatformException {
      //todo
    }
  }


  @override
  Future<void> close() {
    _validatePW.close();
    _matchPW.close();
    _showConfirmPW.close();
    _showPW.close();
    return super.close();
  }


}

