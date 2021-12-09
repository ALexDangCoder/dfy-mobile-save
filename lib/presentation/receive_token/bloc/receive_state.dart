import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/domain/model/token_price_model.dart';

abstract class ReceiveState extends BaseState {
}

class ReceiveInitial extends ReceiveState {
  @override
  List<Object?> get props => [];
}
class PriceSuccess extends ReceiveState {
  final List<TokenPrice> listTokenPrice;
  PriceSuccess(this.listTokenPrice);

  @override
  List<Object?> get props => [listTokenPrice];

}

