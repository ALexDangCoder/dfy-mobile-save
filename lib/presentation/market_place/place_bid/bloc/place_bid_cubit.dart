import 'package:Dfy/presentation/market_place/place_bid/bloc/place_bid_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PlaceBidCubit extends Cubit<PlaceBidState> {
  PlaceBidCubit() : super(PlaceBidInitial());

}
