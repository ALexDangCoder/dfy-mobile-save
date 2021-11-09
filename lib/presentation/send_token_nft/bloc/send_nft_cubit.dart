import 'package:Dfy/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

part 'send_nft_state.dart';

class SendNftCubit extends Cubit<SendNftState> {
  SendNftCubit() : super(SendNftInitial());

  final BehaviorSubject<String> _fromField = BehaviorSubject<String>.seeded('');
  final BehaviorSubject<bool> _isCustomizeFee =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _isSufficientToken =
      BehaviorSubject<bool>.seeded(false);

  //stream
  Stream<String> get fromFieldStream => _fromField.stream;

  Stream<bool> get isCustomizeFeeStream => _isCustomizeFee.stream;

  Stream<bool> get isSufficientTokenStream => _isSufficientToken.stream;

  //sink
  Sink<String> get fromFieldSink => _fromField.sink;

  Sink<bool> get isCustomizeFeeSink => _isCustomizeFee.sink;

  Sink<bool> get isSufficientTokenSink => _isSufficientToken.sink;

  // "walletAddress*: String
  // receiveAddress*: String
  // nftID*: Int
  // password: String"

  String walletAddress = '';
  String receiveAddress = '';
  int? nftID;
  String password = '';

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'sendNftCallback':
        walletAddress = await methodCall.arguments['walletAddress'];
        receiveAddress = await methodCall.arguments['receiveAddress'];
        password = await methodCall.arguments['password'];
        nftID = await methodCall.arguments['nftID'];
        fromFieldSink.add(walletAddress);
        break;
      default:
        break;
    }
  }

  Future<void> sendNftWallet({
    required String walletAddress,
    required String receiveAddress,
    required int nftID,
    String? password,
  }) async {
    try {
      final data = {
        'password': password,
        //todo wallet, receive, nft
      };
      await trustWalletChannel.invokeMethod('sendNft', data);
    } on PlatformException {
      //todo
    }
  }

  void dispose() {
    _fromField.close();
    _isCustomizeFee.close();
    _isSufficientToken.close();
  }
}
