import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/home_pawn/crypto_pawn_model.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:get/get.dart';

class BorrowListMyAccBloc {
  BorrowRepository get _pawnService => Get.find();
  static const String BORROW_TYPE = '0';
  static const String NFT_TYPE = '1';

  Future<void> getBorrowContract({
    String? type,
    String? borrowerWalletAddress,
  }) async {
    // showLoading();
    final Result<List<CryptoPawnModel>> response =
        await _pawnService.getBorrowContract(
      size: ApiConstants.DEFAULT_NFT_SIZE,
      page: 0.toString(),
      type: type,
      borrowerWalletAddress: '0xa2E3Db206948b93201a8c732bdA8385B77D48002',
      status: '',
    );
    response.when(
      success: (response) {
        // emit(
        //   OfferDetailMyAccSuccess(
        //     CompleteType.SUCCESS,
        //     obj: response,
        //   ),
        // );
      },
      error: (error) {
        // emit(
        //   OfferDetailMyAccSuccess(
        //     CompleteType.ERROR,
        //     message: error.message,
        //   ),
        // );
      },
    );
  }
}
