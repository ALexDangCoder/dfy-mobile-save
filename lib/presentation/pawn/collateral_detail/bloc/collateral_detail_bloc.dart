import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/detail_collateral.dart';
import 'package:Dfy/domain/model/pawn/reputation_borrower.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'collateral_detail_state.dart';

class CollateralDetailBloc extends BaseCubit<CollateralDetailState> {
  final String id;

  CollateralDetailBloc(
    this.id,
  ) : super(CollateralDetailInitial()) {
    getDetailCollateral();
  }

  BehaviorSubject<String> rate = BehaviorSubject.seeded('');

  BorrowRepository get _pawnService => Get.find();

  Future<void> getReputation(String addressWallet) async {
    final Result<List<ReputationBorrower>> response =
        await _pawnService.getListReputation(
      addressWallet: addressWallet,
    );
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          rate.add(response.first.reputationBorrower.toString());
        }
      },
      error: (error) {},
    );
  }

  String getTime({
    required int type,
    required int time,
  }) {
    if (type == WEEK) {
      return '$time ${S.current.week}';
    }
    return '$time ${S.current.month}';
  }

  Future<void> getDetailCollateral() async {
    showLoading();
    final Result<CollateralDetail> response =
        await _pawnService.getDetailCollateral(
      id: id,
    );
    response.when(
      success: (response) {
        getReputation(response.walletAddress ?? '');
        emit(
          CollateralDetailSuccess(
            CompleteType.SUCCESS,
            obj: response,
          ),
        );
      },
      error: (error) {
        emit(
          CollateralDetailSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
      },
    );
  }
}
