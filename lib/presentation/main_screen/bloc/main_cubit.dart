import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/presentation/main_screen/bloc/main_state.dart';
import 'package:rxdart/rxdart.dart';

class MainCubit extends BaseCubit<MainState> {
  MainCubit() : super(MainStateInitial());

  final BehaviorSubject<int> _index = BehaviorSubject<int>.seeded(0);
  final BehaviorSubject<int> _walletIndex = BehaviorSubject<int>();

  Stream<int> get indexStream => _index.stream;

  Sink<int> get indexSink => _index.sink;
  Stream<int> get walletStream  => _walletIndex.stream;

  Sink<int> get walletSink => _walletIndex.sink;

  Future<void> init({dynamic args}) async {}
  bool checkAppLock() {
    if(PrefsService.getAppLockConfig() == 'true') return true;
    return false;
  }
  @override
  Future<void> close() {
    _index.close();
    return super.close();
  }
}
