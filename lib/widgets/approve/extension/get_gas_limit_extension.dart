import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/extension/common_extension.dart';
import 'package:flutter/cupertino.dart';

extension GetGasLimit on ApproveCubit {
  Future<double> getGasLimitByType(
      {required TYPE_CONFIRM_BASE type, required String hexString,}) async {
    final web3Client = Web3Utils();
    String gasLimit = '';
    switch (type) {
      case TYPE_CONFIRM_BASE.BUY_NFT:
        {
          gasLimit = '1000';
          break;
        }
      case TYPE_CONFIRM_BASE.CANCEL_SALE:
        {
          try {
            gasLimit = await web3Client.getGasLimitByData(
              from: addressWallet ?? '',
              toContractAddress: getSpender(),
              dataString: hexString,
            );
          } catch (e) {
            AppException(S.current.error, e.toString());
          }
          break;
        }
      case TYPE_CONFIRM_BASE.PUT_ON_MARKET:
        {

          gasLimit = '20000';
          break;
        }
      case TYPE_CONFIRM_BASE.CREATE_COLLECTION : {
        try {
          gasLimit = await web3Client.getGasLimitByData(
            from: addressWallet ?? '',
            toContractAddress: getSpender(),
            dataString: hexString,
          );
        } catch (e) {
          AppException(S.current.error, e.toString());
        }
        break;
      }
      case TYPE_CONFIRM_BASE.SEND_NFT:
        // TODO: Handle this case.
        break;
      case TYPE_CONFIRM_BASE.SEND_TOKEN:
        // TODO: Handle this case.
        break;
      case TYPE_CONFIRM_BASE.SEND_OFFER:
        // TODO: Handle this case.
        break;
      case TYPE_CONFIRM_BASE.PLACE_BID:
        // TODO: Handle this case.
        break;
    }
    return double.parse(gasLimit);
  }

  Future<void> getGasLimitApprove({
    required BuildContext context,
    required String contractAddress,
  }) async {
    showLoading();
    final web3Client = Web3Utils();
    final data = await web3Client.getTokenApproveData(
      context: context,
      spender: getSpender(),
      contractAddress: contractAddress,
    );
    tokenApproveData = data;
    final gasLimitApprove = await web3Client.getGasLimitByData(
      dataString: data,
      from: addressWallet ?? '',
      toContractAddress: contractAddress,
    );
    gasLimit = double.parse(gasLimitApprove);
    gasLimitFirst = double.parse(gasLimitApprove);
    gasLimitFirstSubject.sink.add( double.parse(gasLimitApprove));
    gasPrice = gasPriceFirst;
    showContent();
  }
}
