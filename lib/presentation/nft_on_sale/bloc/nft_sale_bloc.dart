import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'nft_sale_state.dart';

class SaleBloc extends Cubit<SaleState> {
  SaleBloc() : super(SaleInitial());
  final _viewSubject = BehaviorSubject.seeded(true);

  Stream<bool> get viewStream => _viewSubject.stream;

  Sink<bool> get viewSink => _viewSubject.sink;
}
