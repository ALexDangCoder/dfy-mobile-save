import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/home_pawn/collateral_detail_my_acc_model.dart';
import 'package:Dfy/domain/model/home_pawn/history_detail_collateral_model.dart';
import 'package:Dfy/domain/model/home_pawn/offers_received_model.dart';
import 'package:Dfy/domain/model/home_pawn/send_to_loan_package_model.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/presentation/pawn/collateral_detail_my_acc/bloc/collateral_detail_my_acc_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CollateralDetailMyAccBloc extends BaseCubit<CollateralDetailMyAccState> {
  CollateralDetailMyAccBloc() : super(CollateralDetailMyAccInitial());

  BehaviorSubject<bool> isAddSend = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAdd = BehaviorSubject.seeded(false);
  List<OffersReceivedModel> listOffersReceived = [];
  List<HistoryCollateralModel> listHistoryCollateral = [];
  List<SendToLoanPackageModel> listSendToLoanPackageModel = [];

  BorrowRepository get _pawnService => Get.find();

  Future<void> getDetailCollateralMyAcc({
    String? collateralId,
  }) async {
    showLoading();
    final Result<CollateralDetailMyAcc> response =
        await _pawnService.getDetailCollateralMyAcc(
      collateralId: collateralId,
    );
    response.when(
      success: (response) {
        emit(
          CollateralDetailMyAccSuccess(
            CompleteType.SUCCESS,
            obj: response,
          ),
        );
        getListReceived(collateralId: collateralId);//521
        getListSendToLoanPackage(collateralId: collateralId);//525
        getHistoryDetailCollateralMyAcc(collateralId: collateralId);
      },
      error: (error) {
        emit(
          CollateralDetailMyAccSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
      },
    );
  }

  Future<void> getHistoryDetailCollateralMyAcc({
    String? collateralId,
    String? page,
    String? size,
  }) async {
    final Result<List<HistoryCollateralModel>> response =
        await _pawnService.getHistoryDetailCollateralMyAcc(
      collateralId: collateralId,
      page: '0', //todo
      size: '12',
    );
    response.when(
      success: (response) {
        listHistoryCollateral.addAll(response);
      },
      error: (error) {},
    );
  }

  Future<void> getListReceived({
    String? collateralId,
    String? page,
    String? size,
  }) async {
    final Result<List<OffersReceivedModel>> response =
        await _pawnService.getListReceived(
      collateralId: collateralId,//todo
    );
    response.when(
      success: (response) {
        listOffersReceived.addAll(response);
      },
      error: (error) {},
    );
  }

  Future<void> getListSendToLoanPackage({
    String? collateralId,
    String? page,
    String? size,
  }) async {
    final Result<List<SendToLoanPackageModel>> response =
        await _pawnService.getListSendToLoanPackage(
      collateralId: collateralId,//todo
    );
    response.when(
      success: (response) {
        listSendToLoanPackageModel.addAll(response);
      },
      error: (error) {},
    );
  }
}
