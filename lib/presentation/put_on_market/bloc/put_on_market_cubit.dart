import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_state.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class PutOnMarketCubit extends BaseCubit<PutOnMarketState> {
  PutOnMarketCubit() : super(InputNotFielded());

  final BehaviorSubject<int> _showInPutType = BehaviorSubject<int>();
  BehaviorSubject<List<ModelToken>> getListTokenModel =
  BehaviorSubject.seeded([]);

  Stream<int> get showInPutTypeStream => _showInPutType.stream;

  void changeIndexChoose(int value){
    _showInPutType.sink.add(value);
  }

}
