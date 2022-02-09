import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/presentation/bts_nft_detail/bloc/nft_detail_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:rxdart/rxdart.dart';

class NFTBloc extends BaseCubit<NFTDetailState> {
  final BehaviorSubject<int> _lengthSubject = BehaviorSubject<int>();
  final BehaviorSubject<bool> _showSubject = BehaviorSubject<bool>();

  NFTBloc() : super(NFTDetailInitial());

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
