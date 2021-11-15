import 'package:Dfy/presentation/create_wallet_first_time/setup_password/helper/validator.dart';



import 'package:Dfy/utils/extensions/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'check_pass_state.dart';

class CheckPassCubit extends Cubit<CheckPassState> {
  CheckPassCubit() : super(CheckPassInitial());

  final BehaviorSubject<bool> _validatePW = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _matchPW = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _showPW = BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _ckcBox = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _showConfirmPW =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _isEnableBtn =
      BehaviorSubject<bool>.seeded(false);

  Stream<bool> get isEnableBtnStream => _isEnableBtn.stream;

  Stream<bool> get validatePWStream => _validatePW.stream;

  Stream<bool> get matchPWStream => _matchPW.stream;

  Stream<bool> get showPWStream => _showPW.stream;

  Stream<bool> get showConfirmPWStream => _showConfirmPW.stream;

  Stream<bool> get ckcBoxStream => _ckcBox.stream;

  Sink<bool> get isEnableBtnSink => _isEnableBtn.sink;

  Sink<bool> get validatePWSink => _validatePW.sink;

  Sink<bool> get matchPWSink => _matchPW.sink;

  Sink<bool> get showPWSink => _showPW.sink;

  Sink<bool> get ckcBoxSink => _ckcBox.sink;

  Sink<bool> get showConfirmPWSink => _showConfirmPW.sink;

  void isValidate(String value) {
    if (Validator.validateStructure(value)) {
      //if validate widget warning will not appear
      validatePWSink.add(false);
    } else {
      validatePWSink.add(true);
    }
  }

  void isEnable(int index) {
    if (index == 1) {
      // index == 1 disEnableBtn
      isEnableBtnSink.add(false);
    } else {
      isEnableBtnSink.add(true);
    }
  }

  bool isValidFtMatchPW(String value, String confirmValue) {
    if (Validator.validateStructure(value)) {
      return false;
    } else {
      return true;
    }
  }

  bool checkMatchPW({required String password, required String confirmPW}) {
    if (password == confirmPW) {
      //if equal widget warning will not appear
      return true;
    } else {
      return false;
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

  void isShowPW(int index) {
    if (index == 1) {
      //if 1 show pass
      showPWSink.add(false);
    } else {
      showPWSink.add(true);
    }
  }

  void isShowConfirmPW(int index) {
    if (index == 1) {
      //if 1 show pass
      showConfirmPWSink.add(false);
    } else {
      showConfirmPWSink.add(true);
    }
  }

  @override
  Future<void> close() {
    _validatePW.close();
    _matchPW.close();
    _showConfirmPW.close();
    _showPW.close();
    return super.close();
  }
}
