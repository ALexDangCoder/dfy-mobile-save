import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/detail_history_nft.dart';
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
  final Web3Utils _client = Web3Utils();

  // Future<void> getDetailTransaction() async {
  //   listDetailHistory = await _client.getNFTHistoryDetail();
  // }

  String getImgStatus(String status) {
    switch (status) {
      case 'success':
        return ImageAssets.ic_tick_circle;
      case 'fail':
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
