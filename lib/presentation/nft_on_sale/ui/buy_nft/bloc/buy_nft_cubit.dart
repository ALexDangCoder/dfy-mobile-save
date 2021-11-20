import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'buy_nft_state.dart';

class BuyNftCubit extends Cubit<BuyNftState> {
  BuyNftCubit() : super(BuyNftInitial());
}
