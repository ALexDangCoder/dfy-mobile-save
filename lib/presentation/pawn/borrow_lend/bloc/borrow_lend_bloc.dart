import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_lend/ui/select_type.dart';
import 'package:rxdart/rxdart.dart';

class BorrowLendBloc {
  TypeLend typeScreen = TypeLend.CRYPTO;
  final regexAmount = RegExp(r'^\d+((.)|(.\d{0,5})?)$');
  BehaviorSubject<String> textAmount = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isAmount = BehaviorSubject.seeded(false);
  BehaviorSubject<String> tokenSymbol = BehaviorSubject.seeded(S.current.all);
  List<String> listToken = [
    S.current.all,
    'Btc',
    'usdt',
    'bnb',
    'fff',
  ];
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
