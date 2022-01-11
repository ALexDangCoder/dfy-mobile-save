import 'dart:developer';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'cancel_sale_state.dart';

class CancelSaleCubit extends BaseCubit<CancelSaleState> {
  CancelSaleCubit({required this.ntfValue, required this.quantity})
      : super(CancelSaleInitial());
  final String ntfValue;
  final String quantity;

  String transaction = '';
  String dataString = '';

  Web3Utils web3utils = Web3Utils();


  List<DetailItemApproveModel> initListApprove() {
    List<DetailItemApproveModel> listApprove = [
      DetailItemApproveModel(title: 'NTF', value: ntfValue),
      DetailItemApproveModel(title: S.current.quantity, value: quantity)
    ];
    return listApprove;
  }



  //ky giao dich
  Future<void> signTransactionWithData({
    required String walletAddress,
    required String gasPrice,
    required String gasLimit,
    required String withData,
  }) async {
    try {
      // final TransactionCountResponse transaction =
      //     await web3utils.getTransactionCount(address: walletAddress);
      // if (!transaction.isSuccess) {
      //   return;
      // }
      final data = {
        'walletAddress': 'walletAddress',
        'contractAddress': 'nft_sales_address_dev2',
        'nonce': 'transaction.count.toString()',
        'chainId': 'appConstant.chaninId',
        'gasPrice': 'gasPrice',
        'gasLimit': 'gasLimit',
        'withData': 'withData',
      };

      await trustWalletChannel.invokeMethod('signTransactionWithData', data);
    } on PlatformException catch (e) {
      //
      throw e;
    }
  }

  //cancel sale:
  Future<Map<String, dynamic>> cancelSale() async {
    final Map<String, dynamic> res =
        await web3utils.sendRawTransaction(transaction: transaction);
    return res;
  }
}
