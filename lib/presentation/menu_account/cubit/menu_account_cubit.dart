import 'package:Dfy/config/base/base_cubit.dart';

import 'menu_account_state.dart';

class MenuAccountCubit extends BaseCubit<MenuAccountState> {
  MenuAccountCubit() : super(NoLoginState());

}