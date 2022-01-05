import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class NFTDetailBloc extends BaseCubit<BaseState> {
  NFTDetailBloc() : super(NFTDetailInitial());
  final _viewSubject = BehaviorSubject.seeded(true);

  Stream<bool> get viewStream => _viewSubject.stream;

  Sink<bool> get viewSink => _viewSubject.sink;

  NFTRepository get _nftRepo => Get.find();


  late NftMarket nftOnSale;

  Future<void> getInForNFT(String marketId, MarketType type) async{
    if(type == MarketType.SALE){
      final Result<NftMarket> result =
          await _nftRepo.getDetailNftOnSale(marketId);
      result.when(
        success: (res) {
         /// nftOnSale = res;
        },
        error: (error) {
          updateStateError();
        },
      );
    }
    if(type == MarketType.AUCTION){
      ///call api Detail onAuction
    }
    if(type == MarketType.PAWN){
      ///call api detail onPawn
    }
  }

}
