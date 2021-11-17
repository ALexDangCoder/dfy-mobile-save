import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  //declare flag to handle enable btn or disable btn
  int _flagOldPW = 0;
  int _flagNewPW = 0;
  int _flagCfPW = 0;
  bool _haveValueOldPW = false;
  bool _haveValueNewPW = false;
  bool _haveValueConfirmPW = false;

  final BehaviorSubject<bool> _validatePW = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _matchPW = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _matchOldPW = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _showOldPW = BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _showNewPW = BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _showCfPW = BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _isEnableButton =
  BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<String> _txtWarnOldPW =
  BehaviorSubject<String>.seeded('');
  final BehaviorSubject<String> _txtWarnNewPW =
  BehaviorSubject<String>.seeded('');
  final BehaviorSubject<String> _txtWarnCfPW =
  BehaviorSubject<String>.seeded('');

  //stream
  Stream<bool> get validatePWStream => _validatePW.stream;

  Stream<bool> get matchPWStream => _matchPW.stream;

  Stream<bool> get matchOldPWStream => _matchOldPW.stream;

  Stream<bool> get isEnableButtonStream => _isEnableButton.stream;

  Stream<bool> get showOldStream => _showOldPW.stream;

  Stream<bool> get showNewPWStream => _showNewPW.stream;

  Stream<bool> get showCfPWStream => _showCfPW.stream;

  Stream<String> get txtWarnOldPWStream => _txtWarnOldPW.stream;

  Stream<String> get txtWarnNewPWStream => _txtWarnNewPW.stream;

  Stream<String> get txtWarnCfPWStream => _txtWarnCfPW.stream;

  //sink
  Sink<bool> get validatePWSink => _validatePW.sink;

  Sink<bool> get matchPWSink => _matchPW.sink;

  Sink<bool> get matchOldPWSink => _matchOldPW.sink;

  Sink<bool> get isEnableButtonSink => _isEnableButton.sink;

  Sink<bool> get showOldSink => _showOldPW.sink;

  Sink<bool> get showNewPWSink => _showNewPW.sink;

  Sink<bool> get showCfPWSink => _showCfPW.sink;

  Sink<String> get txtWarnOldPWSink => _txtWarnOldPW.sink;

  Sink<String> get txtWarnNewPWSink => _txtWarnNewPW.sink;

  Sink<String> get txtWarnCfPWSink => _txtWarnCfPW.sink;

  //function check show or not show warning
  void isMatchPW({required String password, required String confirmPW}) {
    if (password == confirmPW) {
      //if equal widget warning will not appear
      matchPWSink.add(false);
    } else {
      matchPWSink.add(true);
    }
  }

  void isValidFtMatchPW(String value, String confirmValue) {
    if (Validator.validateStructure(value)) {
      //if validate will not show warning text
      validatePWSink.add(false);
    } else {
      validatePWSink.add(true);
    }
  }

  void isMatchOldPW({required String oldPW, required String enterOldPW}) {
    if (enterOldPW == oldPW) {
      matchOldPWSink.add(false);
    } else {
      matchOldPWSink.add(true);
    }
  }

  //function handle will show or hide password
  //index = 0 -> icon is show, index = 1 -> icon is hide
  void showOldPW(int index) {
    if (index == 0) {
      showOldSink.add(true);
    } else {
      showOldSink.add(false);
    }
  }

  void showNewPW(int index) {
    if (index == 0) {
      showNewPWSink.add(true);
    } else {
      showNewPWSink.add(false);
    }
  }

  void showConfirmPW(int index) {
    if (index == 0) {
      showCfPWSink.add(true);
    } else {
      showCfPWSink.add(false);
    }
  }

  //function will show text warning base on type error value
  void showTxtWarningOldPW(String value, {String? passwordOld}) {
    if ((value.isNotEmpty && value.length < 8) ||
        (value.isNotEmpty && value.length > 15)) {
      matchOldPWSink.add(true);
      txtWarnOldPWSink.add(S.current.warn_pw_8_15);
      isEnableButtonSink.add(false);
    } else if (value.isEmpty) {
      matchOldPWSink.add(true);
      txtWarnOldPWSink.add(S.current.warn_pw_required);
      isEnableButtonSink.add(false);
    } else if (!Validator.validateStructure(value)) {
      matchOldPWSink.add(true);
      txtWarnOldPWSink.add(S.current.warn_pw_validate);
      isEnableButtonSink.add(false);
    } else if (value != passwordOld) {
      matchOldPWSink.add(true);
      txtWarnOldPWSink.add(S.current.warn_old_pw_not_match);
      isEnableButtonSink.add(false);
    } else {
      matchOldPWSink.add(false);
      _flagOldPW = 1;
      if (_flagCfPW == 1 && _flagNewPW == 1 && _flagOldPW == 1) {
        isEnableButtonSink.add(true);
      } else {
        //nothing
      }
    }
  }

  void showTxtWarningNewPW(String value) {
    if ((value.isNotEmpty && value.length < 8) ||
        (value.isNotEmpty && value.length > 15)) {
      validatePWSink.add(true);
      txtWarnNewPWSink.add(S.current.warn_pw_8_15);
      isEnableButtonSink.add(false);
    } else if (value.isEmpty) {
      validatePWSink.add(true);
      txtWarnNewPWSink.add(S.current.warn_pw_required);
      isEnableButtonSink.add(false);
    } else if (!Validator.validateStructure(value)) {
      validatePWSink.add(true);
      txtWarnNewPWSink.add(S.current.warn_pw_validate);
      isEnableButtonSink.add(false);
    } else {
      validatePWSink.add(false);
      _flagNewPW = 1;
      if (_flagCfPW == 1 && _flagNewPW == 1 && _flagOldPW == 1) {
        isEnableButtonSink.add(true);
      } else {
        //nothing
      }
    }
  }

  void showTxtWarningConfirmPW(String value, {required String newPassword}) {
    if ((value.isNotEmpty && value.length < 8) ||
        (value.isNotEmpty && value.length > 15)) {
      matchPWSink.add(true);
      txtWarnCfPWSink.add(S.current.warn_pw_8_15);
      isEnableButtonSink.add(false);
    } else if (value.isEmpty) {
      matchPWSink.add(true);
      txtWarnCfPWSink.add(S.current.warn_pw_required);
      isEnableButtonSink.add(false);
    } else if (!Validator.validateStructure(value)) {
      matchPWSink.add(true);
      txtWarnCfPWSink.add(S.current.warn_pw_validate);
      isEnableButtonSink.add(false);
    } else if (!(value == newPassword)) {
      matchPWSink.add(true);
      txtWarnCfPWSink.add(S.current.warn_cf_pw);
      isEnableButtonSink.add(false);
    } else {
      matchPWSink.add(false);
      _flagCfPW = 1;
      if (_flagCfPW == 1 && _flagNewPW == 1 && _flagOldPW == 1) {
        isEnableButtonSink.add(true);
      } else {
        //nothing
      }
    }
  }

  //functions will enable button when have value in 3 forms
  void checkHaveValueOldPW(String value) {
    if (value.isNotEmpty) {
      _haveValueOldPW = true;
    } else {
      _haveValueOldPW = false;
    }
    if (_haveValueNewPW && _haveValueOldPW && _haveValueConfirmPW) {
      isEnableButtonSink.add(true);
    } else {
      isEnableButtonSink.add(false);
    }
  }

  void checkHaveValueNewPW(String value) {
    if (value.isNotEmpty) {
      _haveValueNewPW = true;
    } else {
      _haveValueNewPW = false;
    }
    if (_haveValueNewPW && _haveValueOldPW && _haveValueConfirmPW) {
      isEnableButtonSink.add(true);
    } else {
      isEnableButtonSink.add(false);
    }
  }

  void checkHaveValueConfirmPW(String value) {
    if (value.isNotEmpty) {
      _haveValueConfirmPW = true;
    } else {
      _haveValueConfirmPW = false;
    }
    if (_haveValueNewPW && _haveValueOldPW && _haveValueConfirmPW) {
      isEnableButtonSink.add(true);
    } else {
      isEnableButtonSink.add(false);
    }
  }

  //check 3 forms is validate -> change screen
  bool checkAllValidate(
      {required String oldPWFetch, required String oldPW, required String newPW,
        required String confirmPW,}) {
    if (oldPW == oldPWFetch && Validator.validateStructure(newPW) &&
        Validator.validateStructure(confirmPW)) {
      return true;
    } else {
      return false;
    }
  }
}
