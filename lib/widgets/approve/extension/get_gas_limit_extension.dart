import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/extension/common_extension.dart';
import 'package:flutter/cupertino.dart';

extension GetGasLimit on ApproveCubit {
  Future<double> getGasLimitByType({
    required String hexString,
  }) async {
    final web3Client = Web3Utils();
    String gasLimit = '';
    try {
      gasLimit = await web3Client.getGasLimitByData(
        from: addressWallet ?? '',
        toContractAddress: spender,
        dataString: hexString,
      );
    } catch (e) {
      //Gas limit error
      AppException(S.current.error, e.toString());
    }
    return double.parse(gasLimit);
  }

  Future<String> gesDataApprove(
      String contractAddress, BuildContext context) async {
    if (isPutOnMarket) {
      final data = await web3Client.getNftApproveForAllData(
        approved: true,
        collectionAddress: putOnMarketModel?.collectionAddress ?? '',
        operatorAddress: spender,
      );
      return data;
    } else {
      final data = await web3Client.getTokenApproveData(
        context: context,
        spender: spender,
        contractAddress: contractAddress,
      );
      return data;
    }
  }

  Future<void> getGasLimitApprove({
    required BuildContext context,
    required String contractAddress,
  }) async {
    showLoading();
    final web3Client = Web3Utils();
    final data = await gesDataApprove(contractAddress, context);

    final String fromAddress = isPutOnMarket
        ? putOnMarketModel?.collectionAddress ?? ''
        : contractAddress;

    tokenApproveData = data;
    final gasLimitApprove = await web3Client.getGasLimitByData(
      dataString: data,
      from: addressWallet ?? '',
      toContractAddress: fromAddress,
    );
    gasLimit = double.parse(gasLimitApprove);
    gasLimitFirst = double.parse(gasLimitApprove);
    gasLimitFirstSubject.sink.add(double.parse(gasLimitApprove));
    gasPrice = gasPriceFirst;
    showContent();
  }
}
