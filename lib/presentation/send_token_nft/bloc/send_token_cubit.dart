import 'package:Dfy/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:Dfy/generated/l10n.dart';

part 'send_token_state.dart';

class SendTokenCubit extends Cubit<SendTokenState> {
  SendTokenCubit() : super(SendTokenInitial());

  final BehaviorSubject<String> _formField = BehaviorSubject<String>.seeded('');
  final BehaviorSubject<String> _formEstimateGasFee = BehaviorSubject<String>();

  //both stream below is manage confirm fee token screen
  final BehaviorSubject<bool> _isCustomizeFee =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _isSufficientToken = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _isShowCFBlockChain =
      BehaviorSubject<bool>.seeded(false);

  //stream below regrex amount form and address
  final BehaviorSubject<bool> _isValidAddressForm = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _isValidAmountForm = BehaviorSubject<bool>();
  final BehaviorSubject<String> _txtInvalidAddressForm =
      BehaviorSubject<String>.seeded('');
  final BehaviorSubject<String> _txtInvalidAmount =
      BehaviorSubject<String>.seeded('');
  final BehaviorSubject<bool> _isValidQuantityForm = BehaviorSubject<bool>();
  final BehaviorSubject<String> _txtInvalidQuantityForm =
      BehaviorSubject<String>.seeded('');

  //stream
  Stream<String> get fromFieldStream => _formField.stream;

  Stream<bool> get isCustomizeFeeStream => _isCustomizeFee.stream;

  Stream<bool> get isSufficientTokenStream => _isSufficientToken.stream;

  Stream<bool> get isShowCFBlockChainStream => _isShowCFBlockChain.stream;

  Stream<String> get formEstimateGasFeeStream => _formEstimateGasFee.stream;

  Stream<bool> get isValidAddressFormStream => _isValidAddressForm.stream;

  Stream<bool> get isValidAmountFormStream => _isValidAmountForm.stream;

  Stream<bool> get isValidQuantityFormStream => _isValidQuantityForm.stream;

  Stream<String> get txtInvalidAddressFormStream =>
      _txtInvalidAddressForm.stream;

  Stream<String> get txtInvalidAmountStream => _txtInvalidAmount.stream;

  Stream<String> get txtInvalidQuantityFormStream =>
      _txtInvalidQuantityForm.stream;

  //sink
  Sink<String> get fromFieldSink => _formField.sink;

  Sink<bool> get isCustomizeFeeSink => _isCustomizeFee.sink;

  Sink<bool> get isSufficientTokenSink => _isSufficientToken.sink;

  Sink<bool> get isShowCFBlockChainSink => _isShowCFBlockChain.sink;

  Sink<String> get formEstimateGasFeeSink => _formEstimateGasFee.sink;

  Sink<bool> get isValidAddressFormSink => _isValidAddressForm.sink;

  Sink<bool> get isValidAmountFormSink => _isValidAmountForm.sink;

  Sink<bool> get isValidQuantityFormSink => _isValidQuantityForm.sink;

  Sink<String> get txtInvalidAddressFormSink => _txtInvalidAddressForm.sink;

  Sink<String> get txtInvalidAmountSink => _txtInvalidAmount.sink;

  Sink<String> get txtInvalidQuantityFormSink => _txtInvalidQuantityForm.sink;

  String walletAddressToken = '';
  String walletAddressNft = '';
  String receiveAddressToken = '';
  String receiveAddressNft = '';
  int? tokenIDToken;
  int? gasFeeToken;
  int? gasFeeNft;
  int? tokenIDNft;
  int? amountToken;
  String passwordToken = '';
  String passwordNft = '';
  int flagAddress = 0;
  int flagAmount = 0;
  int flagQuantity = 0;

  void checkValidAddress(String value) {
    if (value.isEmpty) {
      flagAddress = 0;
      txtInvalidAddressFormSink.add(S.current.address_required);
      isValidAddressFormSink.add(true);
      isShowCFBlockChainSink.add(false);
    }
    // else if(Validator.validateAddress(value)) {
    //   print('here2');
    //   txtInvalidAddressFormSink.add(S.current.invalid_address);
    //   isValidAddressFormSink.add(true);
    //   isShowCFBlockChainSink.add(false);
    //   flagAddress = 0;
    // }
    else {
      // txtInvalidAddressFormSink.add('');
      flagAddress = 1;
      isValidAddressFormSink.add(false);
      if (flagAddress == 1 && flagAmount == 1) {
        isShowCFBlockChainSink.add(true);
      } else {
        //nothing
      }
    }
  }

  void checkValidAmount(String value) {
    if (value.isEmpty) {
      flagAmount = 0;
      txtInvalidAmountSink.add(S.current.amount_required);
      isValidAmountFormSink.add(true);
      isShowCFBlockChainSink.add(false);
    } else {
      flagAmount = 1;
      isValidAmountFormSink.add(false);
      if (flagAddress == 1 && flagAmount == 1) {
        isShowCFBlockChainSink.add(true);
      } else {
        //nothing
      }
    }
  }

  void checkValidQuantity(String value) {
    if(value.isEmpty) {
      flagQuantity = 0;
      txtInvalidAmountSink.add(S.current.amount_required);
      isValidQuantityFormSink.add(true);
      isShowCFBlockChainSink.add(false);
    } else {
      flagQuantity = 1;
      isValidQuantityFormSink.add(false);
      if(flagAddress == 1 && flagQuantity == 1) {
        isShowCFBlockChainSink.add(true);
      } else {
        //nothing
      }
    }
  }

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

  void isEstimatingGasFee(String value) {
    if (value.length > 15) {
      value = '$value...';
      value = '${value.substring(1, 15)}...';
    }

    formEstimateGasFeeSink.add(value);
  }

  // void isValidGasLimitFtPrice(String value) {
  //   if(value.contains(other))
  // }

  void isSufficientGasFee({required double gasFee, required double balance}) {
    if (gasFee < balance) {
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

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'sendTokenCallback':
        bool isSuccess = await methodCall.arguments['isSuccess'];
        print(isSuccess);
        // fromFieldSink.add(walletAddressToken);
        break;
      default:
        break;
    }
  }

  // "walletAddress*: String
  // receiveAddress*: String
  // tokenID*: Int
  // amount*: Int
  // password: String"
  //input and nameCallback
  Future<void> sendNft({
    required String walletAddress,
    required String receiveAddress,
    required int nftID,
    required int gasFee,
    String? password,
  }) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'receiveAddress': receiveAddress,
        'nftID': nftID,
        'gasFee': gasFee,
        'password': password,
        //
      };
      await trustWalletChannel.invokeMethod('sendToken', data);
    } on PlatformException {
      //todo
    }
  }

  Future<void> sendToken({
    required String walletAddress,
    required String receiveAddress,
    required int tokenID,
    required int amount,
    required int gasFee,
    String? password,
  }) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'receiveAddress': receiveAddress,
        'amount': amount,
        'tokenID': tokenID,
        'password': password,
        'gasFee': gasFee,
        //todo wallet
      };
      //param invokeMethod is api
      await trustWalletChannel.invokeMethod('sendToken', data);
    } on PlatformException {
      //todo
    }
  }

  //handle number with e
  String toExact(double input) {
    double value = double.parse(input.toStringAsFixed(5));
    var sign = '';
    if (value < 0) {
      value = -value;
      sign = '-';
    }
    var string = value.toString();
    var e = string.lastIndexOf('e');
    if (e < 0) return '$sign$string';
    assert(string.indexOf('.') == 1);
    final offset = int.parse(
        string.substring(e + (string.startsWith('-', e + 1) ? 1 : 2)));
    final digits = string.substring(0, 1) + string.substring(2, e);
    if (offset < 0) {
      return "${sign}0.${"0" * ~offset}$digits";
    }
    if (offset > 0) {
      if (offset >= digits.length) {
        return sign + digits.padRight(offset + 1, '0');
      }
      return '$sign${digits.substring(0, offset + 1)}'
          '.${digits.substring(offset + 1)}';
    }
    return digits;
  }
}
