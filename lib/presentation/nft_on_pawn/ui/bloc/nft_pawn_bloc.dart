import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'nft_pawn_state.dart';

class PawnBloc extends Cubit<PawnState> {
  PawnBloc() : super(PawnInitial());
  final _viewSubject = BehaviorSubject.seeded(true);

  Stream<bool> get viewStream => _viewSubject.stream;

  Sink<bool> get viewSink => _viewSubject.sink;
}
