import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/home_pawn/nfts_collateral_pawn_model.dart';
import 'package:Dfy/domain/model/home_pawn/official_pawn_item_model.dart';
import 'package:Dfy/domain/model/home_pawn/top_rate_model.dart';
import 'package:Dfy/domain/model/home_pawn/top_sale_pawnshop_item_model.dart';
import 'package:Dfy/domain/repository/home_pawn/home_pawn_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'home_pawn_state.dart';

enum TYPE_BORROW_OR_LEND {
  BORROW,
  LEND,
}

class HomePawnCubit extends BaseCubit<HomePawnState> {
  HomePawnCubit() : super(HomePawnInitial());

  HomePawnRepository get _homePawnRepo => Get.find();

  bool _flagGetDataSuccess = false;
  List<OfficialPawnItemModel> listOfficialPawnShopWithToken = [];
  List<TopRateLenderModel> topRatedLenders = [];
  List<TopSalePawnShopItemModel> topSalePawnShop = [];
  List<NftsCollateralPawnModel> nftsCollateralsPawn = [];

  Future<void> getOfficialPawnShopWithToken() async {
    final Result<List<OfficialPawnItemModel>> result =
        await _homePawnRepo.getOfficialPawnShopWithNewToken();
    result.when(success: (res) {
      _flagGetDataSuccess = true;
      listOfficialPawnShopWithToken.clear();
      listOfficialPawnShopWithToken = res;
    }, error: (error) {
      _flagGetDataSuccess = false;
      emit(HomePawnLoadSuccess(completeType: CompleteType.ERROR));
    });
  }

  Future<void> getTopRatedLenders() async {
    final Result<List<TopRateLenderModel>> result =
        await _homePawnRepo.getTopRateLenders();
    result.when(
      success: (res) {
        _flagGetDataSuccess = true;
        topRatedLenders.clear();
        topRatedLenders = res;
      },
      error: (error) {
        _flagGetDataSuccess = false;
        emit(HomePawnLoadSuccess(completeType: CompleteType.ERROR));
      },
    );
  }

  Future<void> getTopSalePawnPackageShop() async {
    final Result<List<TopSalePawnShopItemModel>> result =
        await _homePawnRepo.getTopSalePawnShopPackage();
    result.when(success: (res) {
      _flagGetDataSuccess = true;
      topSalePawnShop.clear();
      topSalePawnShop = res;
    }, error: (error) {
      _flagGetDataSuccess = false;
      emit(HomePawnLoadSuccess(completeType: CompleteType.ERROR));
    });
  }

  Future<void> getNftsCollateralPawn() async {
    final Result<List<NftsCollateralPawnModel>> result =
        await _homePawnRepo.getNftsCollateralPawn();
    result.when(
      success: (res) {
        _flagGetDataSuccess = true;
        nftsCollateralsPawn.clear();
        nftsCollateralsPawn = res;
      },
      error: (error) {
        _flagGetDataSuccess = false;
        emit(HomePawnLoadSuccess(completeType: CompleteType.ERROR));
      },
    );
  }

  bool get getFlagGetDataSuccess => _flagGetDataSuccess;

  Future<void> callAllApi({bool isRefresh = false}) async {
    if (isRefresh) {
      emit(HomePawnLoading());
    }
    await getOfficialPawnShopWithToken();
    await getTopRatedLenders();
    await getTopSalePawnPackageShop();
    await getNftsCollateralPawn();
    if (_flagGetDataSuccess) {
      emit(
        HomePawnLoadSuccess(completeType: CompleteType.SUCCESS),
      );
    } else {
      emit(HomePawnLoadSuccess(completeType: CompleteType.ERROR));
    }
  }

  List<BorrowOrLend> borrowFeatLend = [
    BorrowOrLend(
      S.current.get_an_instant,
      S.current.start_borrow,
      TYPE_BORROW_OR_LEND.BORROW,
      ImageAssets.bgBorrowPawn,
    ),
    BorrowOrLend(
      S.current.earn_periodic,
      S.current.start_lending,
      TYPE_BORROW_OR_LEND.LEND,
      ImageAssets.bgLendingPawn,
    ),
  ];
}

class BorrowOrLend {
  String title;
  String sufTitle;
  String imgBackGround;
  TYPE_BORROW_OR_LEND type;

  BorrowOrLend(
    this.title,
    this.sufTitle,
    this.type,
    this.imgBackGround,
  );
}
