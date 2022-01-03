import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cancel_sale_state.dart';

class CancelSaleCubit extends Cubit<CancelSaleState> {
  CancelSaleCubit() : super(CancelSaleInitial());
}
