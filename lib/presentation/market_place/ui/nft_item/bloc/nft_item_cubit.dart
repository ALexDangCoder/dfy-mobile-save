import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'nft_item_state.dart';

class NftItemCubit extends Cubit<NftItemState> {
  NftItemCubit() : super(NftItemInitial());


  DateTime parseTimeServerToDateTime({required int value}) {
    if(value == 0) {
      return DateTime.now(); //todo dang hardcode
    } else {
      final dt = DateTime.fromMillisecondsSinceEpoch(value);
      return dt;
    }

  }

  int daysBetween(DateTime endTimeAuction) {
    final dtNow = DateTime.now();
    final difference = endTimeAuction.difference(dtNow).inMilliseconds;
    return difference;
  }

  bool isOutOfTimeAuction({required DateTime endTime}) {
    // final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    // final int endTimestamp = endTime.millisecondsSinceEpoch;
    //nếu endtime trước hôm nay -> quá hạn
    if(endTime.isBefore(DateTime.now())) {
      return false;
    } else {
      return true;
    }
  }
}
