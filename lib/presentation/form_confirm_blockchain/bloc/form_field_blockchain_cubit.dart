import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'form_field_blockchain_state.dart';

class FormFieldBlockchainCubit extends Cubit<FormFieldBlockchainState> {
  FormFieldBlockchainCubit() : super(FormFieldBlockchainInitial());
  final _isSufficientGasFee = BehaviorSubject<bool>();
  final _isEnableBtn = BehaviorSubject<bool>();
  final _isCustomizeGasFee = BehaviorSubject<bool>.seeded(false);
  final _txtGasFeeWhenEstimating = BehaviorSubject<String>();
  final _gasPrice = BehaviorSubject<double>();

  //validate form
  final txtWarningGasLimit = BehaviorSubject<String>.seeded('');
  final txtWarningGasPrice = BehaviorSubject<String>.seeded('');
  final showWarningGasLimit = BehaviorSubject<bool>.seeded(false);
  final showWarningGasPrice = BehaviorSubject<bool>.seeded(false);

  //flag to enable btn
  bool _flagGasPrice = false;
  bool _flagGasLimit = false;
  bool _flagSufficientFee = false;

  final regexAmount = RegExp(r'^\d+((.)|(.\d{0,5})?)$');

  void validateGasLimit(String value) {
    if (value.isEmpty || (double.parse(value) == 0)) {
      _flagGasLimit = false;
      txtWarningGasLimit.sink.add(S.current.gas_limit_required);
      showWarningGasLimit.sink.add(true);
      isEnableBtnSink.add(false);
    } else if (!regexAmount.hasMatch(value)) {
      _flagGasLimit = false;
      txtWarningGasLimit.sink.add(S.current.invalid_gas_limit);
      showWarningGasLimit.sink.add(true);
      isEnableBtnSink.add(false);
    } else {
      _flagGasLimit = true;
      showWarningGasLimit.sink.add(false);
      if (_flagGasLimit && _flagGasPrice && _flagSufficientFee) {
        isEnableBtnSink.add(true);
      }
    }
  }

  void validateGasPrice(String value) {
    if (value.isEmpty || (double.parse(value) == 0)) {
      _flagGasPrice = false;
      txtWarningGasPrice.sink.add(S.current.gas_price_required);
      showWarningGasPrice.sink.add(true);
      isEnableBtnSink.add(false);
    } else if (!regexAmount.hasMatch(value)) {
      _flagGasPrice = false;
      txtWarningGasPrice.sink.add(S.current.invalid_gas_price);
      showWarningGasPrice.sink.add(true);
      isEnableBtnSink.add(false);
    } else {
      _flagGasPrice = true;
      showWarningGasPrice.sink.add(false);
      if (_flagGasPrice && _flagSufficientFee && _flagGasLimit) {
        isEnableBtnSink.add(true);
      }
    }
  }

  //web3

  //stream
  Stream<bool> get isSufficientGasFeeStream => _isSufficientGasFee.stream;

  Stream<bool> get isEnableBtnStream => _isEnableBtn.stream;

  Stream<bool> get isCustomizeGasFeeStream => _isCustomizeGasFee.stream;

  Stream<double> get getGasPriceStream => _gasPrice.stream;

  Stream<String> get txtGasFeeWhenEstimatingStream =>
      _txtGasFeeWhenEstimating.stream;

  //sink
  Sink<bool> get isSufficientGasFeeSink => _isSufficientGasFee.sink;

  Sink<double> get gasPriceSink => _gasPrice.sink;

  Sink<bool> get isEnableBtnSink => _isEnableBtn.sink;

  Sink<bool> get isCustomizeGasFeeSink => _isCustomizeGasFee.sink;

  Sink<String> get txtGasFeeWhenEstimatingSink => _txtGasFeeWhenEstimating.sink;

  Future<void> getGasPrice() async {
    final result = await Web3Utils().getGasPrice();
    final double gasPrice = double.parse(result) / 1000000000;
    gasPriceSink.add(gasPrice);
  }

  //function
  void isShowCustomizeFee({required bool isShow}) {
    isCustomizeGasFeeSink.add(isShow);
  }

  void isEstimatingGasFee(String value) {
    if (value.length > 15) {
      value = '$value...';
      value = '${value.substring(1, 15)}...';
    }
    txtGasFeeWhenEstimatingSink.add(value);
  }

  void isSufficientGasFee({required double gasFee, required double balance}) {
    if (gasFee < balance) {
      //nếu phí giao dịch bé hơn số dư thì không báo đỏ
      isSufficientGasFeeSink.add(true);

      isEnableBtnSink.add(true);
    } else {
      //ngược lại
      isSufficientGasFeeSink.add(false);
      isEnableBtnSink.add(false);
      _flagSufficientFee = false;
    }
  }

  ///SEND TOKEN
  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    bool isSuccess = false;
    String signedTransaction = '';
    switch (methodCall.method) {
      case 'setDeleteNftCallback':
        break;
      case 'signTransactionTokenCallback':
        // print(methodCall.arguments);
        emit(FormBlockchainSendTokenLoading());
        isSuccess = await methodCall.arguments['isSuccess'];
        signedTransaction = await methodCall.arguments['signedTransaction'];
        if (isSuccess) {
          final result = await Web3Utils()
              .sendRawTransaction(transaction: signedTransaction);
          if (result) {
            emit(FormBlockchainSendTokenSuccess());
          } else {
            emit(FormBlockchainSendTokenFail());
          }
        } else {
          emit(FormBlockchainSendTokenFail());
        }
        break;
      case 'signTransactionNftCallback':
        final bool isSuccess = await methodCall.arguments['isSuccess'];
        final String signedTransaction =
            await methodCall.arguments['signedTransaction'];
        final String walletAddress =
            await methodCall.arguments['walletAddress'];
        final String collectionAddress =
            await methodCall.arguments['collectionAddress'];
        final String nftId = await methodCall.arguments['nftId'];
        if (isSuccess) {
          final result = await Web3Utils()
              .sendRawTransaction(transaction: signedTransaction);
          if (result) {
            deleteNft(
                walletAddress: walletAddress,
                collectionAddress: collectionAddress,
                nftId: nftId);
            emit(FormBlockchainSendNftSuccess());
          } else {
            emit(FormBlockchainSendNftFail());
          }
        } else {
          emit(FormBlockchainSendNftFail());
        }
        break;
      default:
        break;
    }
  }

  Future<int> getNonceWeb3({required String walletAddress}) async {
    final result =
        await Web3Utils().getTransactionCount(address: walletAddress);
    return result.count;
  }

  void signTransactionToken({
    required String walletAddress,
    required String tokenAddress,
    required String toAddress,
    required String nonce,
    required String chainId,
    required String gasPrice,
    required String gasLimit,
    required String amount,
  }) {
    try {
      final String newAmount = handleAmount(amount);
      final data = {
        'walletAddress': walletAddress,
        'tokenAddress': tokenAddress,
        'toAddress': toAddress,
        'nonce': nonce,
        'chainId': chainId,
        'gasPrice': gasPrice,
        'gasLimit': gasLimit,
        'amount': newAmount,
      };
      trustWalletChannel.invokeMethod('signTransactionToken', data);
    } on PlatformException {
      //todo
    }
  }

  //sign Nft
  void signTransactionNFT({
    required String fromAddress,
    required String toAddress,
    required String contractNft,
    required String nonce,
    required String chainId,
    required String gasPrice,
    required String gasLimit,
    required String nftID,
  }) {
    try {
      final data = {
        'walletAddress': fromAddress,
        'tokenAddress': contractNft,
        'toAddress': toAddress,
        'nonce': nonce,
        'chainId': chainId,
        'gasPrice': gasPrice,
        'gasLimit': gasLimit,
        'tokenId': nftID,
      };
      trustWalletChannel.invokeMethod('signTransactionNft', data);
    } on PlatformException {
      //todo
    }
  }

  void deleteNft({
    required String walletAddress,
    required String collectionAddress,
    required String nftId,
  }) {
    try {
      final data = {
        'walletAddress': walletAddress,
        'nftId': nftId,
        'collectionAddress': collectionAddress,
      };
      trustWalletChannel.invokeMethod('deleteNft', data);
    } on PlatformException {
      //todo
    }
  }

  String handleAmount(String amount) {
    final parts = amount.split('.');
    if (amount.isEmpty) {
      return '0';
    } else {
      if (parts.length == 1) {
        return '${amount}000000000000000000';
      } else if (parts.length > 1) {
        if (parts[1].length >= 18) {
          return parts[0] + parts[1].substring(0, 18);
        } else {
          final String valueAmount = parts[0];
          final String valueDecimal = parts[1];
          final buffer = StringBuffer();
          for (var i = valueDecimal.length; i < 18; i++) {
            buffer.write('0');
          }
          return valueAmount + valueDecimal + buffer.toString();
        }
      } else {
        return '0';
      }
    }
  }
}
