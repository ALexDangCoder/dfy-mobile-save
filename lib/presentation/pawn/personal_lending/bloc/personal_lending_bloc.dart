import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/dialog_filter.dart';
import 'package:Dfy/presentation/pawn/personal_lending/bloc/personal_lending_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';

class PersonalLendingBloc extends BaseCubit<PersonalLendingState> {
  PersonalLendingBloc() : super(PersonalLendingInitial());

  BorrowRepository get _repo => Get.find();

  //load more
  final bool _canLoadMore = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 1;

  bool get canLoadMore => _canLoadMore;

  bool get isRefresh => _isRefresh;
  String mess = '';
  List<PersonalLending> list = [];

  //filter
  TypeFilter? typeRating = TypeFilter.HIGH_TO_LOW;
  TypeFilter? typeInterest = TypeFilter.LOW_TO_HIGH;
  TypeFilter? typeSigned = TypeFilter.HIGH_TO_LOW;

  Future<void> refreshPosts() async {
    if (!_isLoading) {
      page = 1;
      _isRefresh = true;
      _isLoading = true;
      await getPersonLendingResult();
    }
  }

  void loadMorePosts() {
    if (!_isLoading) {
      page += 1;
      _isRefresh = false;
      _isLoading = true;
      getPersonLendingResult();
    }
  }

  //
  Future<void> getPersonLendingResult({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
    String? page,
  }) async {
    final Result<List<PersonalLending>> result =
        await _repo.getListPersonalLending(
      collateralAmount: collateralAmount,
      collateralSymbols: collateralSymbols,
      name: name,
      interestRanges: interestRanges,
      loanToValueRanges: loanToValueRanges,
      loanSymbols: loanSymbols,
      loanType: loanType,
      page: '0',
    );
    result.when(
      success: (res) {
        showContent();
        emit(
          PersonalLendingSuccess(
            CompleteType.SUCCESS,
            listPersonal: res,
          ),
        );
      },
      error: (error) {
        emit(
          PersonalLendingSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
      },
    );
  }
}
