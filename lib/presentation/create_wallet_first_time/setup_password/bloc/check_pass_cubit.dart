import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/presentation/create_wallet_first_time/setup_password/helper/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'check_pass_state.dart';

class CheckPassCubit extends BaseCubit<CheckPassState> {
  CheckPassCubit() : super(CheckPassInitial());

  BehaviorSubject<bool> _validatePW = new BehaviorSubject<bool>.seeded(false);

  Stream<bool> get validatePWStream => _validatePW.stream;

  Sink<bool> get validatePWSink => _validatePW.sink;

  void isValidate(String value) {
    if (Validator.isValidPassword(value)) {
      validatePWSink.add(true);
    } else {
      validatePWSink.add(false);
    }
  }

  @override
  Future<void> close() {
    _validatePW.close();
    return super.close();
  }
}

class CheckMatchPassCubit extends Cubit<bool> {
  CheckMatchPassCubit() : super(true);

  void isMatchPassword(String password, String cfPassword) {
    if (password == cfPassword) {
      emit(true);
    } else {
      emit(false);
    }
  }
}
