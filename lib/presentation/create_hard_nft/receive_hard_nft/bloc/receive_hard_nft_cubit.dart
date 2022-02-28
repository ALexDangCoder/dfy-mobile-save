import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/detail_asset_hard_nft.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/presentation/create_hard_nft/receive_hard_nft/bloc/receive_hard_nft_state.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ReceiveHardNFTCubit extends BaseCubit<ReceiveHardNFTState> {
  final String assetId;

  ReceiveHardNFTCubit(this.assetId) : super(ReceiveHardNFTLoading()) {
    getAssetHardNFT(assetId: assetId);
  }

  NFTRepository get _nftRepo => Get.find();

  Future<void> getDetailNft(DetailAssetHardNft data) async {
    final Result<NftMarket> result = await _nftRepo.getDetailNft(
      data.collection?.collectionAddress ?? '',
      data.nftAssetHard?.bcTokenId.toString() ?? '',
    );
    result.when(
      success: (res) {
        emit(ReceiveHardNFTLoaded(data,nftMarket: res));
      },
      error: (error) {
        emit(ReceiveHardNFTLoadFail());
      },
    );
  }

  Future<void> getAssetHardNFT({
    required String assetId,
  }) async {
    emit(ReceiveHardNFTLoading());
    final CreateHardNFTRepository _client = Get.find();
    final Result<DetailAssetHardNft> result =
        await _client.getDetailAssetHardNFT(
      assetId,
    );
    result.when(
      success: (res) {
        if (res.nftAssetHard == null) {
          emit(ReceiveHardNFTLoadFail());
        } else {
          getDetailNft(res);
        }
      },
      error: (error) {
        emit(ReceiveHardNFTLoadFail());
      },
    );
  }
}
