import 'dart:developer';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'cancel_sale_state.dart';

class CancelSaleCubit extends BaseCubit<CancelSaleState> {
  CancelSaleCubit({required this.ntfValue, required this.quantity})
      : super(CancelSaleInitial());
  final String ntfValue;
  final String quantity;

  String transaction = '';
  String dataString = '';
  BehaviorSubject<double> gasLimitSubject = BehaviorSubject.seeded(0);

  Stream<double> get gasLimitStream => gasLimitSubject.stream;

  Web3Utils web3utils = Web3Utils();

  List<DetailItemApproveModel> initListApprove() {
    List<DetailItemApproveModel> listApprove = [
      DetailItemApproveModel(title: 'NTF', value: ntfValue),
      DetailItemApproveModel(title: S.current.quantity, value: quantity)
    ];
    return listApprove;
  }

  //get limit gas
  Future<void> getGasLimit(
      {required BuildContext context,
      required String orderId,
      required String walletAddress}) async {
    //a19d9f27-e023-4824-8a6e-23a9566fb733
    //get dataString
    dataString = await web3utils.getCancelListingData(
      contractAddress: nft_sales_address_dev2,
      orderId: orderId,
      context: context,
    );
    //get gas limit by  data
    double gasLimit = double.parse(
      await web3utils.getGasLimitByData(
        from: walletAddress,
        toContractAddress: nft_sales_address_dev2,
        dataString: dataString,
      ),
    );
    gasLimitSubject.sink.add(gasLimit);
  }

  //ky giao dich
  Future<void> signTransactionWithData(
      {required String walletAddress,
      required String nonce,
      required String chainId,
      required String gasPrice,
      required String gasLimit,
      required String withData}) async {
    try {
      final TransactionCountResponse transaction =
          await web3utils.getTransactionCount(address: walletAddress);
      if (!transaction.isSuccess) {
        return;
      }
      final data = {
        'walletAddress': walletAddress,
        'contractAddress': nft_sales_address_dev2,
        'nonce': transaction.count.toString(),
        'chainId': String,
        'gasPrice': String,
        'gasLimit': String,
        'withData': withData,
      };
      await trustWalletChannel.invokeMethod('signTransactionWithData', data);
    } on PlatformException catch (e) {
      //
    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    if (methodCall.method == 'signTransactionWithDataCallback') {
      transaction = await methodCall.arguments;
    }
  }

  //cancel sale:
  Future<Map<String, dynamic>> cancelSale() async {
    final Map<String, dynamic> res =
        await web3utils.sendRawTransaction(transaction: transaction);
    return res;
  }
}
