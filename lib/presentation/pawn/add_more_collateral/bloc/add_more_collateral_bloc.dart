import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/add_more_collateral/bloc/add_more_collateral_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class AddMoreCollateralBloc extends BaseCubit<AddMoreCollateralState> {
  AddMoreCollateralBloc() : super(AddMoreCollateralInitial()) {
    showLoading();
  }

  BehaviorSubject<bool> isBtn = BehaviorSubject.seeded(false);
  BehaviorSubject<String> errorCollateral = BehaviorSubject.seeded('');
  BehaviorSubject<String> amount = BehaviorSubject.seeded('');
  BehaviorSubject<double> decimalNext = BehaviorSubject.seeded(0);
  final List<ModelToken> checkShow = [];
  double balanceToken = 0;
  final Web3Utils client = Web3Utils();
  String? hexString;
  final Web3Utils web3Client = Web3Utils();

  BorrowRepository get _pawnService => Get.find();

  Future<void> getIncreaseCollateralData({
    required String bcContractId,
    required String bcCollateralAddress,
    required String bcCollateralId,
  }) async {
    try {
      showLoading();
      hexString = await web3Client.getIncreaseCollateralData(
        amount: amount.value,
        collateralId: bcCollateralId,
        collateralAddress: bcCollateralAddress,
        contractId: bcContractId,
      );
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
  }

  Future<void> putAddMoreCollateral({
    String? id,
    double? amount,
    String? symbol,
    String? txnHash,
  }) async {
    final Result<String> response = await _pawnService.putAddMoreCollateral(
      amount: amount,
      id: id,
      symbol: symbol,
      txnHash: txnHash,
    );
    response.when(
      success: (response) {},
      error: (error) {},
    );
  }

  void validateAmount(String value) {
    if (value.isNotEmpty) {
      if (double.parse(value) > balanceToken) {
        errorCollateral.add(S.current.invalid_amount);
        isBtn.add(false);
      } else if (double.parse(value) == 0) {
        errorCollateral.add(S.current.invalid_amount);
        isBtn.add(false);
      } else {
        amount.add(value);
        errorCollateral.add('');
        isBtn.add(true);
      }
    } else {
      isBtn.add(false);
      errorCollateral.add(S.current.value_is_required);
    }
  }

  Future<void> getBalanceToken({
    required String ofAddress,
    required String tokenAddress,
  }) async {
    late final double balance;
    try {
      balance = await client.getBalanceOfToken(
        ofAddress: ofAddress,
        tokenAddress: tokenAddress,
      );
      balanceToken = balance;
      emit(
        AddMoreCollateralSuccess(CompleteType.SUCCESS, message: ''),
      );
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
  }
}
