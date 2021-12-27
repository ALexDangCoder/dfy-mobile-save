import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/detail_history_nft.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:rxdart/rxdart.dart';

class NFTBloc {
  final BehaviorSubject<int> _lengthSubject = BehaviorSubject<int>();
  final BehaviorSubject<bool> _showSubject = BehaviorSubject<bool>();

  Stream<int> get lenStream => _lengthSubject.stream;

  Sink<int> get lenSink => _lengthSubject.sink;

  int get curLen => _lengthSubject.valueOrNull ?? 0;

  Stream<bool> get showStream => _showSubject.stream;

  Sink<bool> get showSink => _showSubject.sink;

  String getImgStatus(String status) {
    switch (status) {
      case STATUS_TRANSACTION_SUCCESS:
        return ImageAssets.ic_tick_circle;
      case STATUS_TRANSACTION_FAIL:
        return ImageAssets.ic_fail;
      default:
        return ImageAssets.ic_pending;
    }
  }



  void dispose() {
    _showSubject.close();
    _lengthSubject.close();
  }
}
