import 'package:Dfy/config/base/base_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'buy_nft_state.dart';

class BuyNftCubit extends BaseCubit<BuyNftState> {
  BuyNftCubit() : super(BuyNftInitial());
  final _amountSubject = BehaviorSubject<int>();

  Stream<int> get amountStream => _amountSubject.stream;

  Sink<int> get amountSink => _amountSubject.sink;
  int get amountValue => _amountSubject.valueOrNull ?? 1;
  final _warnSubject = BehaviorSubject<String>.seeded('');

  Stream<String> get warnStream => _warnSubject.stream;

  Sink<String> get warnSink => _warnSubject.sink;
  final _btnSubject = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get btnStream => _btnSubject.stream;

  Sink<bool> get btnSink => _btnSubject.sink;
}
