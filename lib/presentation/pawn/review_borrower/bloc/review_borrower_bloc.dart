import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/request/pawn/review_create_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/contract_detail.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ReviewBorrowerBloc {
  BehaviorSubject<int> rateNumber = BehaviorSubject.seeded(0);
  BehaviorSubject<bool> isCheckBox = BehaviorSubject.seeded(false);
  BehaviorSubject<String> note = BehaviorSubject.seeded('');
  String? hexString;
  final Web3Utils web3Client = Web3Utils();

  BorrowRepository get _pawnService => Get.find();

  Future<void> getHexString({
    required String bcContractId,
    required String bcContractAddress,
    required TypeBorrow typeBorrow,
  }) async {
    try {
      if (typeBorrow == TypeBorrow.NFT_TYPE) {
        hexString = await web3Client.getSubmitNFTContractData(
          contractAddress: bcContractAddress,
          contractId: bcContractId,
          point: rateNumber.value,
        );
      } else {
        hexString = await web3Client.getSubmitCryptoContractData(
          contractAddress: bcContractAddress,
          contractId: bcContractId,
          point: rateNumber.value,
        );
      }
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
  }

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
