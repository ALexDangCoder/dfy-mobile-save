import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

part 'buy_nft_state.dart';

class BuyNftCubit extends BaseCubit<BuyNftState> {
  BuyNftCubit() : super(BuyNftInitial());
  final _amountSubject = BehaviorSubject<int>();
  final Web3Utils web3Client = Web3Utils();
  double total = 0;

  Stream<int> get amountStream => _amountSubject.stream;

  Sink<int> get amountSink => _amountSubject.sink;

  int get amountValue => _amountSubject.valueOrNull ?? 1;
  final _warnSubject = BehaviorSubject<String>.seeded('');

  Stream<String> get warnStream => _warnSubject.stream;

  Sink<String> get warnSink => _warnSubject.sink;
  final _btnSubject = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get btnStream => _btnSubject.stream;

  Sink<bool> get btnSink => _btnSubject.sink;

  Future<String> getBuyNftData({
    required String contractAddress,
    required String orderId,
    required String numberOfCopies,
    required BuildContext context,
  }) async {
    late final String hexString;
    showLoading();
    try {
      hexString = await web3Client.getBuyNftData(
        contractAddress: contractAddress,
        orderId: orderId,
        numberOfCopies: numberOfCopies,
        context: context,
      );
      showContent();
    } catch (e) {
      showError();
      throw AppException(S.current.error, e.toString());
    }
    return hexString;
  }
}
