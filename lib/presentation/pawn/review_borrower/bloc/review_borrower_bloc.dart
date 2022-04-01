import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ReviewBorrowerBloc {
  BehaviorSubject<int> rateNumber = BehaviorSubject.seeded(0);
  BehaviorSubject<bool> isCheckBox = BehaviorSubject.seeded(false);
  String? hexString;
  BorrowRepository get _pawnService => Get.find();
  Future<void> postReview() async {
    final Result<String> response =
    await _pawnService.postReview(
     //todo reviewCreateRequest:
    );
    response.when(
      success: (response) {
      },
      error: (error) {},
    );
  }

}
