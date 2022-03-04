import 'package:Dfy/config/base/base_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_crypto_state.dart';

class SelectCryptoCubit extends BaseCubit<SelectCryptoState> {
  SelectCryptoCubit() : super(SelectCryptoInitial());

  String message = '';
}
