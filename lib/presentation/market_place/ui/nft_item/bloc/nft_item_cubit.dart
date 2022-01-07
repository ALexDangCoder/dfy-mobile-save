import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

part 'nft_item_state.dart';

class NftItemCubit extends Cubit<NftItemState> {
  NftItemCubit() : super(NftItemInitial());


  DateTime parseTimeServerToDateTime({required int value}) {
    if(value == 0) {
      return DateTime.now(); //todo dang hardcode
    } else {
      final dt = DateTime.fromMillisecondsSinceEpoch(value);
      final dtFormat = DateFormat('dd/MM/yyyy, HH:mm:ss').format(dt);
      final result = DateTime.parse(dtFormat);
      return result;
    }

  }

  bool isOutOfTimeAuction({required DateTime endTime}) {
    final int currentTimestamp = DateTime.now().microsecondsSinceEpoch;
    final int endTimestamp = endTime.microsecondsSinceEpoch;
    if(currentTimestamp > endTimestamp) {
      return false;
    } else {
      return true;
    }
  }
}
