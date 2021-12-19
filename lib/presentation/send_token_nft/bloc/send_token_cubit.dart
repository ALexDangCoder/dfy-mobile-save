import 'dart:typed_data';

import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

part 'send_token_state.dart';

enum typeSend { SEND_NFT, SEND_TOKEN }

//this class will handle cubit nft and token
class SendTokenCubit extends Cubit<SendTokenState> {
  //todo fix handle warning error
  SendTokenCubit() : super(SendTokenInitial());

  // 3 boolean below check validate
  bool _flagAddress = false;
  bool _flagAmount = false;
  bool _flagQuantity = false;
  late double balanceWallet;
  late double gasPrice;
  late double estimateGasFee; //gas limit

  //Web3
  //handle token
  Future<void> getBalanceWallet({required String ofAddress}) async {
    balanceWallet = await Web3Utils().getBalanceOfBnb(ofAddress: ofAddress);
  }

  Future<void> getGasPrice() async {
    final result = await Web3Utils().getGasPrice();
    gasPrice = double.parse(result);
  }

  Future<void> getEstimateGas({
    required String from,
    required String to,
    required double value,
  }) async {
    final result =
        await Web3Utils().getEstimateGasPrice(from: from, to: to, value: value);
    estimateGasFee = double.parse(result);
  }

  //handle nft pending api

  //3 boolean below check if 3 forms have value
  bool _haveVLAddress = false;
  bool _haveVLQuantity = false;

  //regex
  final regex = RegExp(r'^0x[a-fA-F0-9]{40}$');

  final BehaviorSubject<String> _formField = BehaviorSubject<String>.seeded('');
  final BehaviorSubject<String> _formEstimateGasFee = BehaviorSubject<String>();

  //both stream below is manage confirm fee token screen
  final BehaviorSubject<bool> _isCustomizeFee = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _isSufficientToken = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _isShowCFBlockChain =
      BehaviorSubject<bool>.seeded(true);

  //stream below regex amount form and address
  final BehaviorSubject<bool> _isValidAddressForm =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _isValidAmountForm =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _isValidQuantityForm =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<String> _txtInvalidAddressForm =
      BehaviorSubject<String>.seeded('');
  final BehaviorSubject<String> _txtInvalidAmount =
      BehaviorSubject<String>.seeded('');
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

  //handle send token screen
  //check have value will enable button
  void checkHaveVlAddressFormToken(String value, {required typeSend type}) {
    if (type == typeSend.SEND_TOKEN) {
      ///validate address
      if (value.isEmpty) {
        _flagAddress = false;
        isShowCFBlockChainSink.add(false);
        isValidAddressFormSink.add(true);
        txtInvalidAddressFormSink.add(S.current.address_required);
      } else if (!regex.hasMatch(value)) {
        _flagAddress = false;
        isShowCFBlockChainSink.add(false);
        isValidAddressFormSink.add(true);
        txtInvalidAddressFormSink.add(S.current.invalid_address);
      } else {
        isValidAddressFormSink.add(false);
        _flagAddress = true;
        if (_flagAddress && _flagAmount) {
          isShowCFBlockChainSink.add(true);
        }
      }
    } else {
      if (_haveVLAddress && _haveVLQuantity) {
        isShowCFBlockChainSink.add(true);
      } else {
        isShowCFBlockChainSink.add(false);
      }
    }
  }

  void checkHaveVLAmountFormToken(
    String value, {
    required double amountBalance,
  }) {
    if (value.isEmpty) {
      _flagAmount = false;
      isShowCFBlockChainSink.add(false);
      isValidAmountFormSink.add(true);
      txtInvalidAmountSink.add(S.current.amount_required);
    } else if (double.parse(value) > amountBalance) {
      _flagAmount = false;
      isShowCFBlockChainSink.add(false);
      isValidAmountFormSink.add(true);
      txtInvalidAmountSink.add(S.current.insufficient_balance);
    } else {
      isValidAmountFormSink.add(false);
      _flagAmount = true;
      if (_flagAddress && _flagAmount) {
        isShowCFBlockChainSink.add(true);
      }
    }
    // if (_haveVLAddress && _flagAmount) {
    //   isShowCFBlockChainSink.add(true);
    // } else {
    //   isShowCFBlockChainSink.add(false);
    // }
  }

  void checkHaveVLQuantityFormNFT(String value) {
    if (value.isEmpty) {
      _haveVLQuantity = false;
    } else {
      _haveVLQuantity = true;
    }
    if (_haveVLAddress && _haveVLQuantity) {
      isShowCFBlockChainSink.add(true);
    } else {
      isShowCFBlockChainSink.add(false);
    }
  }

  void checkValidAddress(String value) {
    if (value.isEmpty) {
      _flagAddress = false;
      isValidAddressFormSink.add(true);
      txtInvalidAddressFormSink.add(S.current.address_required);
      isShowCFBlockChainSink.add(false);
    }
    //todo
    // else if (!Validator.validateAddress(value)) {
    //   _flagAddress = false;
    //   isValidAddressFormSink.add(true);
    //   txtInvalidAddressFormSink.add(S.current.invalid_address);
    //   isShowCFBlockChainSink.add(false);
    // }
    else {
      _flagAddress = true;
      isValidAddressFormSink.add(false);
    }
  }

  void checkValidAmount(String value) {
    if (value.isEmpty) {
      _flagAmount = false;
      isValidAmountFormSink.add(true);
      txtInvalidAmountSink.add(S.current.amount_required);
      isShowCFBlockChainSink.add(false);
    }
    // else if (!Validator.validateMoney(value)) { todo
    else if (value.contains(',')) {
      _flagAmount = false;
      isValidAmountFormSink.add(true);
      txtInvalidAmountSink.add(S.current.amount_invalid);
      isShowCFBlockChainSink.add(false);
    } else {
      _flagAmount = true;
      isValidAmountFormSink.add(false);
    }
  }

  void checkValidQuantity(String value, {required int quantityFirstFetch}) {
    if (value.isEmpty) {
      _flagQuantity = false;
      isValidQuantityFormSink.add(true);
      txtInvalidQuantityFormSink.add(S.current.amount_required);
      isShowCFBlockChainSink.add(false);
    } else if (!Validator.validateQuantity(value)) {
      _flagQuantity = false;
      isValidQuantityFormSink.add(true);
      txtInvalidQuantityFormSink.add(S.current.amount_invalid);
      isShowCFBlockChainSink.add(false);
    } else if (int.parse(value) > quantityFirstFetch) {
      _flagQuantity = false;
      isValidQuantityFormSink.add(true);
      txtInvalidQuantityFormSink.add(S.current.quantity_invalid_of_all);
      isShowCFBlockChainSink.add(false);
    } else {
      _flagQuantity = true;
      isValidQuantityFormSink.add(false);
    }
  }

  bool checkAddressFtAmount() {
    if (_flagAmount && _flagAddress) {
      return true;
    } else {
      return false;
    }
  }

  bool checkAddressFtQuantity() {
    if (_flagQuantity && _flagAddress) {
      return true;
    } else {
      return false;
    }
  }

  void isShowCustomizeFee({required bool isShow}) {
    isCustomizeFeeSink.add(isShow);
  }

  //handle enable or disable button gold to go to confirm screen
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

//handle number with e

}
