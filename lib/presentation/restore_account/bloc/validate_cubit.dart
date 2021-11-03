import 'package:Dfy/presentation/restore_account/bloc/validate_state.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CheckPassCubit extends Cubit<CheckPassState> {
  CheckPassCubit() : super(CheckPassInitial());

  final BehaviorSubject<bool> _validatePW = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _matchPW = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get validatePWStream => _validatePW.stream;

  Stream<bool> get matchPWStream => _matchPW.stream;

  Sink<bool> get validatePWSink => _validatePW.sink;

  Sink<bool> get matchPWSink => _matchPW.sink;

  void isValidate(String value) {
    if (Validator.validateStructure(value)) {
      //if validate widget warning will not appear
      validatePWSink.add(false);
    } else {
      validatePWSink.add(true);
    }
  }

  void isMatchPW({required String password, required String confirmPW}) {
    if (password == confirmPW) {
      //if equal widget warning will not appear
      matchPWSink.add(false);
    } else {
      matchPWSink.add(true);
    }
  }

  @override
  Future<void> close() {
    _validatePW.close();
    _matchPW.close();
    return super.close();
  }
}
