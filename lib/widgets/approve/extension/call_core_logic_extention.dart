import 'dart:convert';

import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/bloc/approve_state.dart';
import 'package:Dfy/widgets/approve/extension/common_extension.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../main.dart';

extension CallCoreExtension on ApproveCubit {
  ///
  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        if (data.isEmpty) {
        } else {
          final String wallet = PrefsService.getCurrentBEWallet();
          for (final element in data) {
            final data = Wallet.fromJson(element);
            if (data.address == wallet){
              addressWalletCoreSubject.sink.add(data.address ?? '');
              addressWallet = data.address;
              nameWalletSubject.sink.add(data.name ?? '');
              nameWallet = data.name;
            }
          }
          try {
            balanceWallet = await web3Client.getBalanceOfBnb(
              ofAddress: addressWalletCoreSubject.valueOrNull ?? '',
            );
            balanceWalletSubject.sink.add(balanceWallet ?? 0);
            await getGasPrice();
            if (needApprove) {
              final result = await checkApprove(
                payValue: payValue ?? '',
                tokenAddress: tokenAddress ?? ' ',
              );
              if (result) {
                await gesGasLimitFirst(hexString ?? '');
              } else {
                showContent();
              }
            } else {
              await gesGasLimitFirst(hexString ?? '');
            }
          } catch (e) {
            showError();
            AppException('title', e.toString());
          }
        }
        break;
      case 'signTransactionWithDataCallback':
        rawData = methodCall.arguments['signedTransaction'];
        if (checkingApprove ?? false) {
          await web3Client.sendRawTransaction(
            transaction: rawData ?? '',
          );
          await loopCheckApprove();
          // isApprovedSubject.sink.add(resultApprove.boolValue('isSuccess'));
          if (isApprove) {
            emit(ApproveSuccess());
          } else {
            emit(ApproveFail());
          }
        } else {
          final result = await sendRawData(rawData ?? '');
          if (result['isSuccess']) {
            emit(SignSuccess(result['txHash'], type));
          } else {
            emit(SignFail(S.current.buy_nft, type));
          }
        }
        break;
      //todo
      case 'importNftCallback':
        final int code = await methodCall.arguments['code'];
        switch (code) {
          case 200:
            await Fluttertoast.showToast(msg: S.current.nft_success);
            break;
          case 400:
            await Fluttertoast.showToast(msg: S.current.nft_fail);
            break;
          case 401:
            await Fluttertoast.showToast(msg: S.current.nft_fail);
            break;
        }
        break;
    }
  }

  Future<void> emitJsonNftToWalletCore({
    required String contract,
    required int id,
    required String address,
  }) async {
    final result = await web3Client.getCollectionInfo(
        contract: contract, address: address, id: id);
    await importNftIntoWalletCore(
      jsonNft: json.encode(result),
      address: address,
    );
  }

  Future<void> importNft({
    required String contract,
    required String address,
    required int id,
  }) async {
    final res = await web3Client.importNFT(
      contract: contract,
      address: address,
      id: id,
    );
    if (!res.isSuccess) {
    } else {
      await emitJsonNftToWalletCore(
        contract: contract,
        address: address,
        id: id,
      );
    }
  }

  Future<void> signTransactionWithData({
    required String walletAddress,
    required String contractAddress,
    required String nonce,
    required String chainId,
    required String gasPrice,
    required String gasLimit,
    required String hexString,
  }) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'contractAddress': contractAddress,
        'nonce': nonce,
        'chainId': chainId,
        'gasPrice': gasPrice,
        'gasLimit': gasLimit,
        'withData': hexString,
      };
      await trustWalletChannel.invokeMethod('signTransactionWithData', data);
    } on PlatformException {}
  }

  Future<void> getListWallets() async {
    showLoading();
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getListWallets', data);
    } on PlatformException {
      showError();
      //nothing
    }
  }

  Future<void> importNftIntoWalletCore({
    required String jsonNft,
    required String address,
  }) async {
    try {
      final data = {
        'jsonNft': jsonNft,
        'walletAddress': address,
      };
      await trustWalletChannel.invokeMethod('importNft', data);
    } on PlatformException {
      //todo
    }
  }
}
