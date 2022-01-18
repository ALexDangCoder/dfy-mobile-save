import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/bloc/approve_state.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../main.dart';

extension CallCoreLogicApproveExtension on ApproveCubit{
  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        if (data.isEmpty) {
        } else {
          for (final element in data) {
            listWallet.add(Wallet.fromJson(element));
          }
          addressWalletCoreSubject.sink.add(listWallet.first.address!);
          addressWallet = listWallet.first.address;
          nameWalletSubject.sink.add(listWallet.first.name!);
          nameWallet = listWallet.first.name;
          if (needApprove) {
            final result = await checkApprove(
              payValue: payValue ?? '',
              tokenAddress: tokenAddress ?? ' ',
            );
            if (result ){
              await gesGasLimitFirst(hexString ?? '');
            }
          }
          try {
            balanceWallet = await web3Client.getBalanceOfBnb(
              ofAddress: addressWalletCoreSubject.valueOrNull ?? '',
            );
            showContent();
          } catch (e) {
            showError();
            AppException('title', e.toString());
          }
          balanceWalletSubject.sink.add(balanceWallet ?? 0);
        }
        break;
      case 'signTransactionWithDataCallback':
        rawData = methodCall.arguments['signedTransaction'];
        if (checkingApprove) {
          final resultApprove = await web3Client.sendRawTransaction(
            transaction: rawData ?? '',
          );
          checkingApprove = false;
          isApprovedSubject.sink.add(resultApprove.boolValue('isSuccess'));
        } else {
          final result = await sendRawData(rawData ?? '');
          switch (type) {
            case TYPE_CONFIRM_BASE.BUY_NFT:
              if (result['isSuccess']) {
                showContent();
                emit(SignSuccess(result['txHash'], TYPE_CONFIRM_BASE.BUY_NFT));
              } else {
                showContent();
                emit(SignFail(S.current.buy_nft));
              }
              break;
            case TYPE_CONFIRM_BASE.CREATE_COLLECTION:
              if (result['isSuccess']) {
                showContent();
              } else {}
              break;
            case TYPE_CONFIRM_BASE.CANCEL_SALE:
              if (result['isSuccess']) {
                emit(SendRawDataSuccess(result['txHash']));
                showContent();
              } else {
                showError();
              }
              break;
            default:
              break;
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
            await Fluttertoast.showToast(msg: S.current.buy_fail);
            break;
          case 401:
            await Fluttertoast.showToast(msg: S.current.nft_fail);
            break;
        }
        break;
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
    } on PlatformException {
      //print ('â');
    }
  }

  Future<void> getListWallets() async {
    try {
      final data = {};
      showLoading();
      await trustWalletChannel.invokeMethod('getListWallets', data);
      showContent();
    } on PlatformException {
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