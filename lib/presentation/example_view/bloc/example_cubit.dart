import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/repository/account_repository.dart';
import 'package:Dfy/presentation/example_view/bloc/example_state.dart';
import 'package:get/get.dart';
class ExampleCubit extends BaseCubit<ExampleState> {
  ExampleCubit() : super(ProductDetailInitial());

  AccountRepository get _accountRepository => Get.find();

  Future<void> login() async {
    emit(LoadingState());
  }
}
