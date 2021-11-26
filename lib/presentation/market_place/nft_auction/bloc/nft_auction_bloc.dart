import 'package:Dfy/presentation/market_place/nft_auction/bloc/nft_auction_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AuctionBloc extends Cubit<AuctionState> {
  AuctionBloc() : super(AuctionInitial());
}
