import 'package:Dfy/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

part 'send_token_state.dart';

class SendTokenCubit extends Cubit<SendTokenState> {
  SendTokenCubit() : super(SendTokenInitial());

  final BehaviorSubject<String> _fromField = BehaviorSubject<String>.seeded('');

  Stream<String> get fromFieldStream => _fromField.stream;

  Sink<String> get fromFieldSink => _fromField.sink;



  String walletAddress = '';
  String receiveAddress = '';
  int? tokenID;
  int? amount;
  String password = '';

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
        print(walletAddress.toString());
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
    _fromField.close();
  }
}
