import 'package:Dfy/presentation/restore_bts/bloc/restore_state.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RestoreCubit extends Cubit<RestoreState> {
  RestoreCubit() : super(RestoreInitial());
  final BehaviorSubject<List<String>> _behaviorSubject =
      BehaviorSubject<List<String>>();
  final BehaviorSubject<String> _stringSubject = BehaviorSubject<String>();
  final BehaviorSubject<bool> _boolSubject = BehaviorSubject<bool>();
  final BehaviorSubject<FormType> _formTypeSubject =
      BehaviorSubject<FormType>();
  final BehaviorSubject<bool> _newPassSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _conPassSubject = BehaviorSubject<bool>();

  Stream<List<String>> get listStringStream => _behaviorSubject.stream;

  Sink<List<String>> get listStringSink => _behaviorSubject.sink;

  Stream<String> get stringStream => _stringSubject.stream;

  Sink<String> get stringSink => _stringSubject.sink;

  Stream<bool> get boolStream => _boolSubject.stream;

  Sink<bool> get boolSink => _boolSubject.sink;

  Stream<FormType> get typeStream => _formTypeSubject.stream;

  Sink<FormType> get typeSink => _formTypeSubject.sink;

  Stream<bool> get newStream => _newPassSubject.stream;

  Sink<bool> get newSink => _newPassSubject.sink;

  Stream<bool> get conStream => _conPassSubject.stream;

  Sink<bool> get conSink => _conPassSubject.sink;

  void dispose() {
    _behaviorSubject.close();
    _stringSubject.close();
    _boolSubject.close();
    _formTypeSubject.close();
    _newPassSubject.close();
    _conPassSubject.close();
    super.close();
  }
}
