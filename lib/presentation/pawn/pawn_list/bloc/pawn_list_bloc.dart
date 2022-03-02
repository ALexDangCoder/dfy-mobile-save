import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/pawn_shop_model.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/domain/repository/pawn/pawn_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/dialog_filter.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PawnListBloc {
  TypeFilter? typeRating = TypeFilter.HIGH_TO_LOW;
  TypeFilter? typeInterest = TypeFilter.LOW_TO_HIGH;
  TypeFilter? typeSigned = TypeFilter.HIGH_TO_LOW;
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<List<PawnShopModel>> list = BehaviorSubject.seeded([]);
  List<bool> listFilter = [
    false,
    false,
    false,
    false,
  ];
  BehaviorSubject<List<bool>> listFilterStream = BehaviorSubject.seeded([
    false,
    false,
    false,
    false,
  ]);
  List<TokenModelPawn> listLoanTokenFilter = [
    //1
    TokenModelPawn(id: '1', address: '', symbol: 'DFY'),
    TokenModelPawn(id: '1', address: '', symbol: 'USDT'),
    TokenModelPawn(id: '1', address: '', symbol: 'BNB'),
    TokenModelPawn(id: '1', address: '', symbol: 'BTC'),
  ];

  List<TokenModelPawn> listCollateralTokenFilter = [
    //2
    TokenModelPawn(id: '1', address: '', symbol: 'DFY'),
    TokenModelPawn(id: '1', address: '', symbol: 'USDT'),
    TokenModelPawn(id: '1', address: '', symbol: 'BNB'),
    TokenModelPawn(id: '1', address: '', symbol: 'BTC'),
  ];

  PawnRepository get _pawnService => Get.find();
  static const int ZERO_TO_TEN = 0;
  static const int TEN_TO_TWENTY_FIVE = 1;
  static const int TWENTY_FIVE_TO_FIVETY = 2;
  static const int MORE_THAN_FIVETY = 3;

  //status filter
  String? checkStatus;
  String? searchStatus;
  List<bool>? statusFilterNumber;
  List<TokenModelPawn> statusListLoan=[];
  List<TokenModelPawn> statusListCollateral=[];

  void statusFilterFirst() {
    if (checkStatus == null) {
      checkStatus = 'have';
      searchStatus = '';
      statusFilterNumber = [false, false, false, false];
      statusListLoan=listLoanTokenFilter;
      statusListCollateral=listCollateralTokenFilter;
    } else {
      textSearch.sink.add(searchStatus ?? '');
      listLoanTokenFilter = statusListLoan;
      listCollateralTokenFilter = statusListCollateral ;
      listFilter = statusFilterNumber ?? [];
      listFilterStream.add(listFilter);
      print('--------------checAk${statusListCollateral.length }');
      for (final TokenModelPawn value in statusListLoan) {
        if (value.isCheck) {
          print('--------------checAk${value.symbol}');
        }
      }
    }
  }

  void funOnSearch(String value) {
    textSearch.sink.add(value);
  }

  void funReset() {
    textSearch.sink.add('');
    listFilter = List.filled(4, false);
    listFilterStream.add(listFilter);
    for (final TokenModelPawn value in listLoanTokenFilter) {
      if (value.isCheck) {
        value.isCheck = false;
      }
    }
    for (final TokenModelPawn value in listCollateralTokenFilter) {
      if (value.isCheck) {
        value.isCheck = false;
      }
    }
  }

  String checkStatusFilter() {
    for (int i = 0; i < listFilterStream.value.length; i++) {
      if (listFilterStream.value[i]) {
        if (i == ZERO_TO_TEN) {
          return S.current.zero_to_ten;
        } else if (i == TEN_TO_TWENTY_FIVE) {
          return S.current.ten_twenty;
        } else if (i == TWENTY_FIVE_TO_FIVETY) {
          return S.current.twenty_five;
        } else {
          return S.current.more_than_fifty;
        }
      }
    }
    return '';
  }

  void funFilter() {
    searchStatus = textSearch.value;
    statusFilterNumber = listFilterStream.value;
    statusListLoan = listLoanTokenFilter;
    statusListCollateral = listCollateralTokenFilter;
    print('--------------check${statusListLoan.length}');
    for (final TokenModelPawn value in statusListLoan) {
      if (value.isCheck) {
        print('--------------check${value.symbol}');
      }
    } //todo
    for (final TokenModelPawn value in statusListCollateral) {
      if (value.isCheck) {
        print('--------------${value.symbol}');
      }
    } //todo

    print('-------------${textSearch.value}');
    print('--------------${checkStatusFilter()}');
    for (final TokenModelPawn value in listLoanTokenFilter) {
      if (value.isCheck) {
        print('--------------loan${value.symbol}');
      }
    } //todo
    for (final TokenModelPawn value in listCollateralTokenFilter) {
      if (value.isCheck) {
        print('--------------${value.symbol}');
      }
    } //todo
  }

  void funOnTapSearch() {
    textSearch.sink.add('');
  }

  Future<void> getListPawn() async {
    final Result<List<PawnShopModel>> res =
        await _pawnService.getListPawnShop();
    res.when(
      success: (response) {
        if (response.isNotEmpty) {
          list.add(response);
        } else {}
      },
      error: (error) {},
    );
  }

  void chooseFilter({required int index}) {
    listFilter = List.filled(4, false);
    listFilter[index] = true;
    listFilterStream.sink.add(listFilter);
  }
}
