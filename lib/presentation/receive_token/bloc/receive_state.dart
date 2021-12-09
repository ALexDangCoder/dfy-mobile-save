import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/domain/model/token_price_model.dart';

abstract class ReceiveState extends BaseState {
  @override
  List<Object> get props => [];
}

class ReceiveInitial extends ReceiveState {}
class PriceSuccess extends ReceiveState {
  final List<TokenPrice> listTokenPrice;
  PriceSuccess(this.listTokenPrice);
}

