import 'package:flutter_bloc/flutter_bloc.dart';

class NewPassCubit extends Cubit<bool> {
  NewPassCubit() : super(true);

  void hide() => emit(true);
  void show() => emit(false);
}
class ConPassCubit extends Cubit<bool> {
  ConPassCubit() : super(true);

  void hide() => emit(true);
  void show() => emit(false);
}
