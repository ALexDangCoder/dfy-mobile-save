import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'form_field_blockchain_state.dart';

class FormFieldBlockchainCubit extends Cubit<FormFieldBlockchainState> {
  FormFieldBlockchainCubit() : super(FormFieldBlockchainInitial());
}
