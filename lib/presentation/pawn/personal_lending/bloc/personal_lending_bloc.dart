import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/presentation/pawn/personal_lending/bloc/personal_lending_state.dart';

class PersonalLendingBloc extends BaseCubit<PersonalLendingState> {
  PersonalLendingBloc() : super(PersonalLendingInitial());
}
