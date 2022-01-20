import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'provide_hard_nft_state.dart';

class ProvideHardNftCubit extends Cubit<ProvideHardNftState> {
  ProvideHardNftCubit() : super(ProvideHardNftInitial());
}
