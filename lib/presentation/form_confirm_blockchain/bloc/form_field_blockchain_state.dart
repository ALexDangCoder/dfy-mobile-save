part of 'form_field_blockchain_cubit.dart';

@immutable
abstract class FormFieldBlockchainState {}

class FormFieldBlockchainInitial extends FormFieldBlockchainState {}

class FormBlockchainSendTokenSuccess extends FormFieldBlockchainState {

}
class FormBlockchainSendTokenFail extends FormFieldBlockchainState {

}

class FormBlockchainSendNftSuccess extends FormFieldBlockchainState{

}

class FormBlockchainSendNftFail extends FormFieldBlockchainState{

}

class FormBlockchainSendNftLoading extends FormFieldBlockchainState{

}

class FormBlockchainSendTokenLoading extends FormFieldBlockchainState{

}

