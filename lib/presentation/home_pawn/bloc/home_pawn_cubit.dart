import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_pawn_state.dart';

enum TYPE_BORROW_OR_LEND {
  BORROW,
  LEND,
}

class HomePawnCubit extends Cubit<HomePawnState> {
  HomePawnCubit() : super(HomePawnInitial());

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
