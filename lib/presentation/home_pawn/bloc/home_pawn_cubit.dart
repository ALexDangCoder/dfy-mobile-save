import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/home_pawn/home_pawn_service.dart';
import 'package:Dfy/domain/model/home_pawn/nfts_collateral_pawn_model.dart';
import 'package:Dfy/domain/model/home_pawn/official_pawn_item_model.dart';
import 'package:Dfy/domain/model/home_pawn/official_pawn_with_token_model.dart';
import 'package:Dfy/domain/model/home_pawn/top_rate_model.dart';
import 'package:Dfy/domain/model/home_pawn/top_sale_pawnshop_item_model.dart';
import 'package:Dfy/domain/repository/home_pawn/home_pawn_repository.dart';
import 'package:Dfy/generated/l10n.dart';
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
      listOfficialPawnShopWithToken = res;
    }, error: (error) {
      _flagGetDataSuccess = false;
      showError();
    });
  }

  Future<void> getTopRatedLenders() async {
    final Result<List<TopRateLenderModel>> result =
        await _homePawnRepo.getTopRateLenders();
    result.when(
      success: (res) {
        _flagGetDataSuccess = true;
        topRatedLenders = res;
      },
      error: (error) {
        _flagGetDataSuccess = false;
        showError();
      },
    );
  }

  Future<void> getTopSalePawnPackageShop() async {
    final Result<List<TopSalePawnShopItemModel>> result =
        await _homePawnRepo.getTopSalePawnShopPackage();
    result.when(success: (res) {
      _flagGetDataSuccess = true;
      topSalePawnShop = res;
    }, error: (error) {
      _flagGetDataSuccess = false;
      showError();
    });
  }

  Future<void> getNftsCollateralPawn() async {
    final Result<List<NftsCollateralPawnModel>> result =
        await _homePawnRepo.getNftsCollateralPawn();
    result.when(
      success: (success) {
        _flagGetDataSuccess = true;
      },
      error: (error) {
        _flagGetDataSuccess = false;
        showError();
      },
    );
  }

  Future<void> callAllApi() async {
    // showLoading();
    await getOfficialPawnShopWithToken();
    await getTopRatedLenders();
    await getTopSalePawnPackageShop();
    await getNftsCollateralPawn();
    if (_flagGetDataSuccess) {
      emit(
        HomePawnLoadSuccess(
          [],
          [],
          [],
          [],
        ),
      );
    } else {}
  }

  List<TopRate> fakeTopRate = [
    TopRate(
      'London Pawnshop',
      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
    ),
    TopRate(
      'London Pawnshop',
      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
    ),
    TopRate(
      'London Pawnshop',
      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
    ),
    TopRate(
      'London Pawnshop',
      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
    ),
    TopRate(
      'London Pawnshop',
      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
    ),
  ];

  List<PawnToken> pawnsBannerSlide = [
    PawnToken(ImageAssets.ic_dfy, 'Defi for you (DFY)', ImageAssets.ic_dfy),
    PawnToken(ImageAssets.ic_dfy, 'alpha be (DFY)', ImageAssets.ic_dfy),
    PawnToken(ImageAssets.ic_dfy, 'dep zai (DFY)', ImageAssets.ic_dfy),
    PawnToken(ImageAssets.ic_dfy, 'corona (DFY)', ImageAssets.ic_dfy),
  ];

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

class TopRate {
  String title;
  String img;

  TopRate(this.title, this.img);
}

class PawnToken {
  String avatar;
  String nameOfToken;
  String iconSymbol;

  PawnToken(this.avatar, this.nameOfToken, this.iconSymbol);
}
