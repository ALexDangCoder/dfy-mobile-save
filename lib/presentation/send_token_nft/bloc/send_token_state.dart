part of 'send_token_cubit.dart';

abstract class SendTokenState extends Equatable {
  const SendTokenState();
}

class SendTokenInitial extends SendTokenState {
  @override
  List<Object> get props => [];
}

class LoadingBeforeConfirm extends SendTokenState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoadSuccessBeforeConfirm extends SendTokenState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
