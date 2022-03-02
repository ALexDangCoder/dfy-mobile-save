import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'borrow_result_state.dart';

class BorrowResultCubit extends BaseCubit<BorrowResultState> {
  BorrowResultCubit() : super(BorrowResultInitial());
}
