import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PassCubit extends Cubit<bool> {
  PassCubit() : super(true);

  void hidePass();

  void showPass();
}

class NewPassCubit extends PassCubit {
  NewPassCubit() : super();

  @override
  void hidePass() => emit(true);

  @override
  void showPass() => emit(false);
}

class ConPassCubit extends PassCubit {
  ConPassCubit() : super();

  @override
  void hidePass() => emit(true);

  @override
  void showPass() => emit(false);
}

class PrivatePassCubit extends PassCubit {
  PrivatePassCubit() : super();

  @override
  void hidePass() => emit(true);

  @override
  void showPass() => emit(false);
}
