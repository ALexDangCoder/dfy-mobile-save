import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'form_field_blockchain_state.dart';

class FormFieldBlockchainCubit extends Cubit<FormFieldBlockchainState> {
  FormFieldBlockchainCubit() : super(FormFieldBlockchainInitial());
  final _isSufficientGasFee = BehaviorSubject<bool>();
  final _isEnableBtn = BehaviorSubject<bool>();
  final _isCustomizeGasFee = BehaviorSubject<bool>.seeded(false);
  final _txtGasFeeWhenEstimating = BehaviorSubject<String>();

  //stream
  Stream<bool> get isSufficientGasFeeStream => _isSufficientGasFee.stream;

  Stream<bool> get isEnableBtnStream => _isEnableBtn.stream;

  Stream<bool> get isCustomizeGasFeeStream => _isCustomizeGasFee.stream;

  Stream<String> get txtGasFeeWhenEstimatingStream =>
      _txtGasFeeWhenEstimating.stream;

  //sink
  Sink<bool> get isSufficientGasFeeSink => _isSufficientGasFee.sink;

  Sink<bool> get isEnableBtnSink => _isEnableBtn.sink;

  Sink<bool> get isCustomizeGasFeeSink => _isCustomizeGasFee.sink;

  Sink<String> get txtGasFeeWhenEstimatingSink => _txtGasFeeWhenEstimating.sink;

  //function
  void isShowCustomizeFee({required bool isShow}) {
    isCustomizeGasFeeSink.add(isShow);
  }

  void isEstimatingGasFee(String value) {
    if (value.length > 15) {
      value = '$value...';
      value = '${value.substring(1, 15)}...';
    }
    txtGasFeeWhenEstimatingSink.add(value);
  }

  void isSufficientGasFee({required double gasFee, required double balance}) {
    if (gasFee < balance) {
      isSufficientGasFeeSink.add(false);
    } else {
      isSufficientGasFeeSink.add(true);
    }
  }

}
