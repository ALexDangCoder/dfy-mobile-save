import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/presentation/main_screen/bloc/main_state.dart';
import 'package:rxdart/rxdart.dart';

class MainCubit extends BaseCubit<MainState> {
  MainCubit() : super(MainStateInitial());

  final BehaviorSubject<int> _index = BehaviorSubject<int>.seeded(0);

  Stream<int> get indexStream => _index.stream;

  Sink<int> get indexSink => _index.sink;

  Future<void> init({dynamic args}) async {}

  @override
  Future<void> close() {
    _index.close();
    return super.close();
  }
}
