import 'package:equatable/equatable.dart';

abstract class PutOnMarketState extends Equatable {

}

class InputFielded extends PutOnMarketState {
  @override
  List<Object?> get props => [];
}
class InputNotFielded extends PutOnMarketState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}