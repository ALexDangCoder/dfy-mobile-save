import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/web3/abi/token.g.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_state.dart';
import 'package:rxdart/rxdart.dart';

enum DurationType { MONTH, WEEK }

class PutOnMarketCubit extends BaseCubit<PutOnMarketState> {
  PutOnMarketCubit() : super(PutOnMarketInitState());

  // tab sale

  Token? tokenSale;
  double? valueTokenInputSale;
  int quantitySale = 1;

  final BehaviorSubject<bool> _canContinueSale = BehaviorSubject<bool>();

  Stream<bool> get canContinueSaleStream => _canContinueSale.stream;

  // tab pawn

  Token? tokenPawn;
  double? valueTokenInputPawn;
  DurationType? typeDuration;
  int? valueDuration;
  int quantityPawn = 1;

  final BehaviorSubject<bool> _canContinuePawn = BehaviorSubject<bool>();

  Stream<bool> get canContinuePawnStream => _canContinuePawn.stream;

  // tab auction

  Token? tokenAuction;
  double? valueTokenInputAuction;

  // function sale
  void changeTokenSale({Token? token, double? value}) {
    tokenSale = token;
    valueTokenInputSale = value;
    updateStreamContinueSale();
  }

  void changeQuantitySale({required int value}) {
    quantitySale = value;
    updateStreamContinueSale();
  }

  void updateStreamContinueSale() {
    if (valueTokenInputSale != null && quantitySale > 0) {
      _canContinueSale.sink.add(true);
    } else {
      _canContinueSale.sink.add(false);
    }
  }

  // function pawn
  void changeTokenPawn({Token? token, double? value}) {
    tokenPawn = token;
    valueTokenInputPawn = value;
    print(valueTokenInputPawn);

    updateStreamContinuePawn();
  }

  void changeDurationPawn({DurationType? type, int? value}) {
    typeDuration = type;
    valueDuration = value;
    print(valueDuration);
    updateStreamContinuePawn();
  }

  void changeQuantityPawn({required int value}) {
    quantityPawn = value;
    print(quantityPawn);
    updateStreamContinuePawn();
  }

  void updateStreamContinuePawn() {
    if (valueTokenInputPawn != null &&
        valueDuration != null &&
        quantityPawn > 0) {
      _canContinuePawn.sink.add(true);
    } else {
      _canContinuePawn.sink.add(false);
    }
  }

  void dispose() {
    _canContinuePawn.close();
    _canContinueSale.close();
  }
}
