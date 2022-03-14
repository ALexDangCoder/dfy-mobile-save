import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/detail_collateral.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CollateralDetailBloc {
  final String id;

  CollateralDetailBloc(
    this.id,
  ) {
    getDetailCollateral();
  }

  BehaviorSubject<CollateralDetail> objCollateral =
      BehaviorSubject.seeded(CollateralDetail());

  BorrowRepository get _pawnService => Get.find();

  Future<void> getDetailCollateral() async {
    final Result<CollateralDetail> response =
        await _pawnService.getDetailCollateral(
      id: id,
    );
    response.when(
      success: (response) {
        objCollateral.add(response);
      },
      error: (error) {},
    );
  }
}
