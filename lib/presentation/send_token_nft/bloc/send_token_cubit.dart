import 'package:Dfy/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

part 'send_token_state.dart';

class SendTokenCubit extends Cubit<SendTokenState> {
  SendTokenCubit() : super(SendTokenInitial());

  final BehaviorSubject<String> _formField = BehaviorSubject<String>.seeded('');
  final BehaviorSubject<String> _formEstimateGasFee =
      BehaviorSubject<String>();

  //both stream below is manage confirm fee token screen
  final BehaviorSubject<bool> _isCustomizeFee =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _isSufficientToken = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _isShowCFBlockChain =
      BehaviorSubject<bool>.seeded(false);

  //stream
  Stream<String> get fromFieldStream => _formField.stream;

  Stream<bool> get isCustomizeFeeStream => _isCustomizeFee.stream;

  Stream<bool> get isSufficientTokenStream => _isSufficientToken.stream;

  Stream<bool> get isShowCFBlockChainStream => _isShowCFBlockChain.stream;

  Stream<String> get formEstimateGasFeeStream => _formEstimateGasFee.stream;

  //sink
  Sink<String> get fromFieldSink => _formField.sink;

  Sink<bool> get isCustomizeFeeSink => _isCustomizeFee.sink;

  Sink<bool> get isSufficientTokenSink => _isSufficientToken.sink;

  Sink<bool> get isShowCFBlockChainSink => _isShowCFBlockChain.sink;

  Sink<String> get formEstimateGasFeeSink => _formEstimateGasFee.sink;

  String walletAddress = '';
  String receiveAddress = '';
  int? tokenID;
  int? amount;
  String password = '';

  void isShowCustomizeFee({required bool isShow}) {
    isCustomizeFeeSink.add(isShow);
  }

  void isShowConfirmBlockChain({
    required bool isHaveFrAddress,
    required bool isHaveAmount,
  }) {
    if (isHaveAmount && isHaveFrAddress) {
      isShowCFBlockChainSink.add(true);
    } else {
      isShowCFBlockChainSink.add(false);
    }
  }

  void isEstimatingGasFee(double value) {
    formEstimateGasFeeSink.add(value.toString());
  }

  void isSufficientGasFee({required double gasFee, required double balance}) {
    if(gasFee < balance) {
      isSufficientTokenSink.add(false);
    } else {
      isSufficientTokenSink.add(true);
    }
  }

  bool isFirstFetchDataToCompare({
    required double balance,
    required double gasFeeFirstFetch,
  }) {
    if (balance < gasFeeFirstFetch) {
      //=> insufficient=> false
      return false;
    } else {
      return true;
    }
  }

  // "walletAddress*: String
  // receiveAddress*: String
  // tokenID*: Int
  // amount*: Int
  // password: String"

  Future<dynamic> sendTokenWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'sendTokenCallback':
        walletAddress = await methodCall.arguments['walletAddress'];
        receiveAddress = await methodCall.arguments['receiveAddress'];
        password = await methodCall.arguments['password'];
        tokenID = await methodCall.arguments['tokenID'];
        amount = await methodCall.arguments['amount'];
        fromFieldSink.add(walletAddress);
        break;
      default:
        break;
    }
  }

  //input and nameCallback
  Future<void> checkPasswordWallet({
    required String walletAddress,
    required String receiveAddress,
    required int tokenID,
    required int amount,
    String? password,
  }) async {
    try {
      final data = {
        'password': password,
        //todo wallet
      };
      //param invokeMethod is api
      await trustWalletChannel.invokeMethod('sendNft', data);
    } on PlatformException {
      //todo
    }
  }

  void dispose() {
    _formField.close();
    _isCustomizeFee.close();
    _isSufficientToken.close();
  }
}
