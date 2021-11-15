import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'confirm_pw_prvkey_seedpharse_state.dart';

class ConfirmPwPrvKeySeedpharseCubit
    extends Cubit<ConfirmPwPrvKeySeedpharseState> {
  ConfirmPwPrvKeySeedpharseCubit() : super(ConfirmPwPrvKeySeedpharseInitial());

  final BehaviorSubject<bool> _isEnableButton =
      BehaviorSubject<bool>.seeded(false);

  //stream
  Stream<bool> get isEnableBtnStream => _isEnableButton.stream;

  //sink
  Sink<bool> get isEnableBtnSink => _isEnableButton.sink;

  void isEnableButton({required String value,String? passwordConfirm}) {
    if(value.isNotEmpty) {
      isEnableBtnSink.add(true);
    } else {
      isEnableBtnSink.add(false);
    }
  }
}
