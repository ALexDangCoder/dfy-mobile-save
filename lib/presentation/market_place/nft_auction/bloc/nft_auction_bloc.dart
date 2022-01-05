import 'package:Dfy/presentation/market_place/nft_auction/bloc/nft_auction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AuctionBloc extends Cubit<AuctionState> {
  AuctionBloc() : super(AuctionInitial());
  final _viewSubject = BehaviorSubject.seeded(true);

  Stream<bool> get viewStream => _viewSubject.stream;

  Sink<bool> get viewSink => _viewSubject.sink;
}
