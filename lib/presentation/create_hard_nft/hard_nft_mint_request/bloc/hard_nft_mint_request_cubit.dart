import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/hard_nft_mint_request.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'hard_nft_mint_request_state.dart';

class HardNftMintRequestCubit extends BaseCubit<HardNftMintRequestState> {
  HardNftMintRequestCubit() : super(HardNftMintRequestInitial());

  CreateHardNFTRepository get _createHardNFTRepository => Get.find();
  Future<void> getListMintRequest() async {

  }


}
