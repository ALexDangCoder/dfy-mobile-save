import 'package:Dfy/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

part 'send_nft_state.dart';

class SendNftCubit extends Cubit<SendNftState> {
  SendNftCubit() : super(SendNftInitial());

  final BehaviorSubject<String> _fromField = BehaviorSubject<String>.seeded('');

  Stream<String> get fromFieldStream => _fromField.stream;

  Sink<String> get fromFieldSink => _fromField.sink;

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
}
