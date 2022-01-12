

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/token_repository.dart';
import 'package:Dfy/presentation/main_screen/bloc/main_state.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';


class MainCubit extends BaseCubit<MainState> {
  MainCubit() : super(MainStateInitial());

  final BehaviorSubject<int> _index = BehaviorSubject<int>.seeded(0);
  final BehaviorSubject<int> _walletIndex = BehaviorSubject<int>();

  Stream<int> get indexStream => _index.stream;

  Sink<int> get indexSink => _index.sink;

  Stream<int> get walletStream => _walletIndex.stream;

  Sink<int> get walletSink => _walletIndex.sink;


  Future<void> init({dynamic args}) async {}

  int checkAppLock() {
    if (PrefsService.getAppLockConfig() == 'true') {
      return 2;
    } else {
      return 1;
    }
  }
  bool checkWalletExist(){
    if (PrefsService.getFirstAppConfig() == 'false') {
      return true;
    } else {
      return false;
    }
  }


  TokenRepository get _tokenRepository => Get.find();

  Future<void> getListTokenSupport() async{
    final Result<List<TokenInf>> result = await _tokenRepository.getListToken();
    result.when(
      success: (res) {
        final String encodeData = TokenInf.encode(res);
        PrefsService.saveListTokenSupport(encodeData);
      },
      error: (error) {

      },
    );
  }

  @override
  Future<void> close() {
    _index.close();
    return super.close();
  }
}
