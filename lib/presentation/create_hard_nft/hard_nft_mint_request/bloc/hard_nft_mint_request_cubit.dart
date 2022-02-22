import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/hard_nft_mint_request.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'hard_nft_mint_request_state.dart';

class HardNftMintRequestCubit extends BaseCubit<HardNftMintRequestState> {
  HardNftMintRequestCubit() : super(HardNftMintRequestInitial());

  CreateHardNFTRepository get _createHardNFTRepository => Get.find();
  final BehaviorSubject<bool> isVisible = BehaviorSubject<bool>();

  List<TokenInf> listTokenSupport = [];


  void show() {
    isVisible.sink.add(true);
  }

  void hide() {
    isVisible.sink.add(false);
  }

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
  }

  int page = 1;
  bool loadMore = false;
  bool canLoadMoreListNft = true;
  bool refresh = false;

  Future<void> getListMintRequest({
    String? name,
    String? assetTypeId,
    String? status,
  }) async {
    showLoading();
    getTokenInf();
    final Result<List<MintRequestModel>> result =
        await _createHardNFTRepository.getListMintRequestHardNFT(
      name ?? '',
      status ?? '',
      assetTypeId ?? '',
      page.toString(),
    );
    result.when(
      success: (res) {
        for (final element in res) {
          for (int i = 0; i < listTokenSupport.length; i++) {
            if (element.expectingPriceSymbol?.toLowerCase() ==
                listTokenSupport[i].symbol?.toLowerCase()) {
              element.urlToken = listTokenSupport[i].iconUrl;
            }
          }
        }
        emit(ListMintRequestSuccess(res));
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }
}
