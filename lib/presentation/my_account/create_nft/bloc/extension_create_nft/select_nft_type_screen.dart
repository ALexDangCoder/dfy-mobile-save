import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';

extension SelectNftCubit on CreateNftCubit{
  Future<void> getListTypeNFT() async {
    showLoading();
    final Result<List<TypeNFTModel>> result = await nftRepo.getListTypeNFT();
    result.when(
      success: (res) {
        showContent();
        res.sort((a, b) => (a.standard ?? 0).compareTo(b.standard ?? 0));
        listSoftNft = res.where((element) => element.type == 0).toList();
        emit(
          TypeNFT(listSoftNft: listSoftNft),
        );
      },
      error: (error) {
        showError();
      },
    );
  }

  void changeId(String id) {
    selectedId = id;
    selectIdSubject.sink.add(selectedId);
    selectedNftType =
        listSoftNft.where((element) => element.id == id).toList().first.type ?? 1;
  }
}