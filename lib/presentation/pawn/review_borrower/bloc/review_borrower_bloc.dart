import 'package:Dfy/data/request/pawn/review_create_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ReviewBorrowerBloc {
  BehaviorSubject<int> rateNumber = BehaviorSubject.seeded(0);
  BehaviorSubject<bool> isCheckBox = BehaviorSubject.seeded(false);
  BehaviorSubject<String> note = BehaviorSubject.seeded('');
  String? hexString;

  BorrowRepository get _pawnService => Get.find();

  Future<void> postReview({
    required ReviewCreateRequest reviewCreateRequest,
  }) async {
    final Result<String> response =
        await _pawnService.postReview(reviewCreateRequest: reviewCreateRequest);
    response.when(
      success: (response) {},
      error: (error) {},
    );
  }
}
