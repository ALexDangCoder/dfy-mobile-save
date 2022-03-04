import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_lend/ui/select_type.dart';
import 'package:rxdart/rxdart.dart';

class BorrowLendBloc {
  BehaviorSubject<TypeLend> typeScreen =
      BehaviorSubject.seeded(TypeLend.CRYPTO);
  final regexAmount = RegExp(r'^\d+((.)|(.\d{0,5})?)$');
  BehaviorSubject<String> textAmount = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isAmount = BehaviorSubject.seeded(false);
  BehaviorSubject<String> tokenSymbol = BehaviorSubject.seeded(S.current.all);
  List<String> listToken = [
    S.current.all,
  ];

  void getTokenInf() {
    final String list = PrefsService.getListTokenSupport();
    final List<TokenInf> listTokenInf = TokenInf.decode(list);
    for (final TokenInf value in listTokenInf) {
      listToken.add(value.symbol ?? '');
    }
  }

  BehaviorSubject<bool> isChooseToken = BehaviorSubject.seeded(false);

  void funValidateAmount(String value) {
    if (!regexAmount.hasMatch(value)) {
      isAmount.add(true);
    } else {
      isAmount.add(false);
    }
  }

  void chooseAddressFilter(String symbol) {
    tokenSymbol.sink.add(
      symbol,
    );
    isChooseToken.sink.add(false);
  }
}
