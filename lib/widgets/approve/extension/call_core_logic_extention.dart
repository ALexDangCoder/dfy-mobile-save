import 'package:Dfy/data/exception/app_exception.dart';
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
          for (final element in data) {
            listWallet.add(Wallet.fromJson(element));
          }
          addressWalletCoreSubject.sink.add(listWallet.first.address!);
          addressWallet = listWallet.first.address;
          nameWalletSubject.sink.add(listWallet.first.name!);
          nameWallet = listWallet.first.name;
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
          await loopCheckApprove().timeout(
            const Duration(milliseconds: 5000),
          );
          checkingApprove = false;
          isApprovedSubject.sink.add(isApprove);
        } else {
          final result = await sendRawData(rawData ?? '');
          switch (type) {
            case TYPE_CONFIRM_BASE.BUY_NFT:
              if (result['isSuccess']) {
                emit(SignSuccess(result['txHash'], TYPE_CONFIRM_BASE.BUY_NFT));
              } else {
                emit(SignFail(S.current.buy_nft, TYPE_CONFIRM_BASE.BUY_NFT));
              }
              break;
            case TYPE_CONFIRM_BASE.SEND_OFFER:
              if (result['isSuccess']) {
                emit(
                  SignSuccess(
                    result['txHash'],
                    TYPE_CONFIRM_BASE.SEND_OFFER,
                  ),
                );
              } else {
                emit(
                  SignFail(S.current.send_offer, TYPE_CONFIRM_BASE.SEND_OFFER),
                );
              }
              break;
            case TYPE_CONFIRM_BASE.PLACE_BID:
              if (result['isSuccess']) {
                emit(
                  SignSuccess(result['txHash'], TYPE_CONFIRM_BASE.PLACE_BID),
                );
              } else {
                emit(
                  SignFail(S.current.send_offer, TYPE_CONFIRM_BASE.SEND_OFFER),
                );
              }
              break;
            case TYPE_CONFIRM_BASE.CREATE_COLLECTION:
              if (result['isSuccess']) {
                emit(
                  SignSuccess(
                    result['txHash'],
                    TYPE_CONFIRM_BASE.CREATE_COLLECTION,
                  ),
                );
                showContent();
              } else {
                showError();
              }
              break;
            case TYPE_CONFIRM_BASE.CANCEL_SALE:
              if (result['isSuccess']) {
                emit(
                  SignSuccess(result['txHash'], TYPE_CONFIRM_BASE.CANCEL_SALE),
                );
              } else {
                emit(
                  SignFail(
                      S.current.cancel_sale, TYPE_CONFIRM_BASE.CANCEL_SALE),
                );
              }
              break;
            case TYPE_CONFIRM_BASE.PUT_ON_SALE:
              if (result['isSuccess']) {
                emit(
                  SignSuccess(
                    result['txHash'],
                    TYPE_CONFIRM_BASE.PUT_ON_SALE,
                  ),
                );
              } else {
                emit(
                  SignFail(
                    S.current.put_on_sale,
                    TYPE_CONFIRM_BASE.PUT_ON_SALE,
                  ),
                );
              }
              break;
            case TYPE_CONFIRM_BASE.CANCEL_AUCTION:
              if (result['isSuccess']) {
                emit(
                  SignSuccess(
                    result['txHash'],
                    TYPE_CONFIRM_BASE.CANCEL_AUCTION,
                  ),
                );
              } else {
                emit(
                  SignFail(
                    S.current.cancel_sale,
                    TYPE_CONFIRM_BASE.CANCEL_AUCTION,
                  ),
                );
              }
              break;
            case TYPE_CONFIRM_BASE.PUT_ON_PAWN:
              if (result['isSuccess']) {
                emit(
                  SignSuccess(
                    result['txHash'],
                    TYPE_CONFIRM_BASE.PUT_ON_PAWN,
                  ),
                );
              } else {
                emit(
                  SignFail(
                    S.current.put_on_pawn,
                    TYPE_CONFIRM_BASE.PUT_ON_PAWN,
                  ),
                );
              }
              break;
            case TYPE_CONFIRM_BASE.PUT_ON_AUCTION:
              if (result['isSuccess']) {
                emit(
                  SignSuccess(
                    result['txHash'],
                    TYPE_CONFIRM_BASE.PUT_ON_AUCTION,
                  ),
                );
              } else {
                emit(
                  SignFail(
                    S.current.put_on_auction,
                    TYPE_CONFIRM_BASE.PUT_ON_AUCTION,
                  ),
                );
              }
              break;
            case TYPE_CONFIRM_BASE.CREATE_SOFT_NFT:
              if (result['isSuccess']) {
                emit(
                  SignSuccess(
                    result['txHash'],
                    TYPE_CONFIRM_BASE.CREATE_SOFT_NFT,
                  ),
                );
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
            await Fluttertoast.showToast(msg: S.current.nft_fail);
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
