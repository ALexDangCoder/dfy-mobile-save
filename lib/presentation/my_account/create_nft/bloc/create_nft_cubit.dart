import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'create_nft_state.dart';

class CreateNftCubit extends BaseCubit<CreateNftState> {
  CreateNftCubit() : super(CreateNftInitial()) {
    getListTypeNFT();
  }

  NFTRepository get _nftRepo => Get.find();

  List<TypeNFTModel> listNft = [];
  List<TypeNFTModel> listSoftNft = [];
  List<TypeNFTModel> listHardNft = [];

  String selectedType = '';
  
  //Stream
  final BehaviorSubject<String> selectIdSubject = BehaviorSubject();

  Future<void> getListTypeNFT() async {
    showLoading();
    final Result<List<TypeNFTModel>> result = await _nftRepo.getListTypeNFT();
    result.when(
      success: (res) {
        showContent();
        listNft = res;
        res.sort((a, b) => (a.standard ?? 0).compareTo(b.standard ?? 0));
        listSoftNft = res.where((element) => element.type == 0).toList();
        emit(
          TypeNFT(listSoftNft: listSoftNft),
        );
        listHardNft = res.where((element) => element.type == 1).toList();
      },
      error: (error) {
        showError();
      },
    );
  }

  void changeId(String id) {
    selectedType = id;
    selectIdSubject.sink.add(selectedType);
  }
}
