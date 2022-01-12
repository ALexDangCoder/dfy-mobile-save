import 'package:Dfy/config/base/base_cubit.dart';
import 'package:rxdart/rxdart.dart';

import 'menu_account_state.dart';

class MenuAccountCubit extends BaseCubit<MenuAccountState> {
  MenuAccountCubit() : super(NoLoginState());

  final BehaviorSubject<int> _index = BehaviorSubject<int>.seeded(-1);

  Stream<int> get indexStream => _index.stream;

  void changeIndex (int index ){
    _index.sink.add(index);
  }
}