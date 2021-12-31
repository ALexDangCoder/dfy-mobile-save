import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_state.dart';
import 'package:rxdart/rxdart.dart';

class PutOnMarketCubit extends BaseCubit<PutOnMarketState> {
  PutOnMarketCubit() : super(InputNotFielded());

  final BehaviorSubject<int> _showInPutType = BehaviorSubject<int>();

  Stream<int> get showInPutTypeStream => _showInPutType.stream;

  void changeIndexChoose(int value){
    _showInPutType.sink.add(value);
  }


}
