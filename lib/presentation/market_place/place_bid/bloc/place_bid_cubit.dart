import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/place_bid/bloc/place_bid_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class PlaceBidCubit extends BaseCubit<PlaceBidState> {
  PlaceBidCubit() : super(PlaceBidInitial());
  final _warnSubject = BehaviorSubject<String>.seeded('');

  Stream<String> get warnStream => _warnSubject.stream;

  Sink<String> get warnSink => _warnSubject.sink;
  final _btnSubject = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get btnStream => _btnSubject.stream;

  Sink<bool> get btnSink => _btnSubject.sink;
  final Web3Utils web3Client = Web3Utils();
  Future<String> getBidData({
    required String contractAddress,
    required String auctionId,
    required String bidValue,
    required BuildContext context,
  }) async {
    showLoading();
    late final String hexString;
    try {
      hexString = await web3Client.getBidData(
        contractAddress: contractAddress,
        auctionId: auctionId,
        bidValue: bidValue,
        context: context,
      );
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
    return hexString;
  }
}
