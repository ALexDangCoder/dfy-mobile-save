import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'check_pass_state.dart';

class CheckPassCubit extends Cubit<CheckPassState> {
  CheckPassCubit() : super(CheckPassInitial());

  bool _flagNewPW = false;
  bool _flagConfirmPW = false;
  bool _haveValueConfirmPW = false;
  bool _haveValueNewPW = false;

  final BehaviorSubject<bool> _validatePW = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _matchPW = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _showPW = BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _ckcBox = BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<String> _txtWarningNewPW =
      BehaviorSubject<String>.seeded('');
  final BehaviorSubject<String> _txtWarningConfirmPW =
      BehaviorSubject<String>.seeded('');
  final BehaviorSubject<bool> _showConfirmPW =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _isEnableBtn = BehaviorSubject<bool>.seeded(true);

  //stream
  Stream<bool> get isEnableBtnStream => _isEnableBtn.stream;

  Stream<String> get txtWarningNewPWStream => _txtWarningNewPW.stream;

  Stream<String> get txtWarningConfirmPWStream => _txtWarningConfirmPW.stream;

  Stream<bool> get validatePWStream => _validatePW.stream;

  Stream<bool> get matchPWStream => _matchPW.stream;

  Stream<bool> get showPWStream => _showPW.stream;

  Stream<bool> get showConfirmPWStream => _showConfirmPW.stream;

  Stream<bool> get ckcBoxStream => _ckcBox.stream;

  //sink

  Sink<bool> get isEnableBtnSink => _isEnableBtn.sink;

  Sink<bool> get validatePWSink => _validatePW.sink;

  Sink<bool> get matchPWSink => _matchPW.sink;

  Sink<bool> get showPWSink => _showPW.sink;

  Sink<bool> get ckcBoxSink => _ckcBox.sink;

  Sink<bool> get showConfirmPWSink => _showConfirmPW.sink;

  Sink<String> get txtWarningNewPWSink => _txtWarningNewPW.sink;

  Sink<String> get txtWarningConfirmPWSink => _txtWarningConfirmPW.sink;

  //function will show text warning base on type error value
  void showTxtWarningNewPW(String value) {
    if ((value.isNotEmpty && value.length < 8) ||
        (value.isNotEmpty && value.length > 15)) {
      _flagNewPW = false;
      validatePWSink.add(true);
      txtWarningNewPWSink.add(S.current.warn_pw_8_15);
      isEnableBtnSink.add(false);
    } else if (value.isEmpty) {
      _flagNewPW = false;
      validatePWSink.add(true);
      txtWarningNewPWSink.add(S.current.password_is_required);
      isEnableBtnSink.add(false);
    } else if (!Validator.validateStructure(value)) {
      _flagNewPW = false;
      validatePWSink.add(true);
      txtWarningNewPWSink.add(S.current.warn_pw_validate);
      isEnableBtnSink.add(false);
    } else {
      validatePWSink.add(false);
      _flagNewPW = true;
    }
  }

  void showTxtWarningConfirmPW(String value, {required String newPW}) {
    if (value.isEmpty) {
      _flagConfirmPW = false;
      matchPWSink.add(true);
      txtWarningConfirmPWSink.add(S.current.password_is_required);
      isEnableBtnSink.add(false);
    } else if (value != newPW) {
      _flagConfirmPW = false;
      matchPWSink.add(true);
      txtWarningConfirmPWSink.add(S.current.not_match);
      isEnableBtnSink.add(false);
    } else {
      matchPWSink.add(false);
      _flagConfirmPW = true;
    }
  }

  void checkHaveValuePW(String value) {
    if (value.isEmpty) {
      _haveValueNewPW = false;
      isEnableBtnSink.add(false);
    } else {
      _haveValueNewPW = true;
      if (_haveValueConfirmPW && _haveValueNewPW) {
        isEnableBtnSink.add(true);
      } else {
        //nothing
      }
    }
  }

  void checkHaveValueConfirmPW(String value) {
    if (value.isEmpty) {
      _haveValueConfirmPW = false;
      isEnableBtnSink.add(false);
    } else {
      _haveValueConfirmPW = true;
      if (_haveValueConfirmPW && _haveValueNewPW) {
        isEnableBtnSink.add(true);
      } else {
        //nothing
      }
    }
  }

  bool validateAll() {
    if (_flagConfirmPW && _flagNewPW) {
      return true;
    } else {
      return false;
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
