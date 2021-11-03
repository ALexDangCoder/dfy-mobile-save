import 'package:Dfy/presentation/create_wallet_first_time/setup_password/helper/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'check_pass_state.dart';
class CheckPassCubit extends Cubit<bool> {
  CheckPassCubit() : super(true);

  void isValidate(String value) {
    if (Validator.isValidPassword(value)) {
      emit(true);
    } else {
      emit(false);
    }
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
