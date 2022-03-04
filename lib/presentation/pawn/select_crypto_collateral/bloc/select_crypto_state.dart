part of 'select_crypto_cubit.dart';

@immutable
abstract class SelectCryptoState extends Equatable{}

class SelectCryptoInitial extends SelectCryptoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SelectCryptoLoading extends SelectCryptoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class GetApiSuccess extends SelectCryptoState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<CryptoCollateralModel>? list;
  final String? message;

  GetApiSuccess(this.completeType, {this.list, this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [id, completeType, list, message];
}
