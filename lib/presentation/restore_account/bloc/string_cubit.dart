import 'package:Dfy/presentation/restore_account/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StringCubit extends Cubit<StringState> {
  StringCubit() : super(StringInitial('Seed phrase'));

  void selectSeed(String string) {
    emit(StringSelectSeed(string));
  }

  void selectPrivate(String string) {
    emit(StringSelectPrivate(string));
  }

  void show() => emit(Show());

  void hide() => emit(Hide());
}
