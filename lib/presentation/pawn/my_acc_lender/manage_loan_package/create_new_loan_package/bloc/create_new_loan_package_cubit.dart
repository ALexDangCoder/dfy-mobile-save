import 'package:Dfy/data/request/pawn/lender/create_new_loan_package_request.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

part 'create_new_loan_package_state.dart';

class CreateNewLoanPackageCubit extends Cubit<CreateNewLoanPackageState> {
  CreateNewLoanPackageCubit() : super(CreateNewLoanPackageInitial());

  BehaviorSubject<String> txtWarningMess = BehaviorSubject.seeded('');
  BehaviorSubject<String> txtWarningLoanMinAmount = BehaviorSubject.seeded('');
  BehaviorSubject<String> txtWarningLoanMaxAmount = BehaviorSubject.seeded('');
  BehaviorSubject<String> txtWarningInterestRate = BehaviorSubject.seeded('');
  BehaviorSubject<String> txtWarningLoanToValue = BehaviorSubject.seeded('');
  BehaviorSubject<String> txtWarningLTVThresHold = BehaviorSubject.seeded('');
  BehaviorSubject<String> txtWarningDuration = BehaviorSubject.seeded('');
  BehaviorSubject<String> valueRecurringInterest = BehaviorSubject();

  final Web3Utils web3 = Web3Utils();
  static const String AUTO = '0';
  static const String SEMI_AUTO = '1';

  List<Tuple2<String, String>> typeCreate = [
    Tuple2<String, String>('AUTO', AUTO),
    Tuple2<String, String>('SEMI AUTO', SEMI_AUTO),
  ];

  CreateNewLoanPackageRequest loanPackageRequest = CreateNewLoanPackageRequest(
    associatedWalletAddress: PrefsService.getCurrentBEWallet(),
    type: AUTO,
    repaymentTokens: RepaymentTokensRequest(repaymentTokens: ['DFY']),
    collateralAcceptances: CollateralAcceptancesRequest(),
  );

  List<String> recurringInterest = [
    'monthly',
    'weekly',
  ];

  Map<String, bool> mapValidate = {
    'message': false,
    'loanMin': false,
    'loanMax': false,
    'interestRate': false,
    'duration': false,
    'collateral': false,
    'loanToValue': false,
    'ltv': false,
  };

  void checkIsSelectedCollateralsToken() {
    bool _flag = false;
    Set<String> collaterals = {};
    for (final element in listCollateralToken) {
      if (element.isSelect ?? false) {
        _flag = true;
        collaterals.add(element.symbol ?? '');
        mapValidate['collateral'] = true;
      }
    }
    loanPackageRequest.collateralAcceptances?.collaterals?.clear();
    loanPackageRequest.collateralAcceptances?.collaterals =
        collaterals.toList();
    validateAll();
  }

  bool checkValidateCollateral() {
    bool _flagCollateral = false;
    for (final element in listCollateralToken) {
      if (element.isSelect ?? false) {
        _flagCollateral = true;
        break;
      }
    }
    return _flagCollateral;
  }

  BehaviorSubject<bool> nextBtnBHVSJ = BehaviorSubject.seeded(false);

  void validateAll() {
    if (mapValidate.containsValue(false) || !checkValidateCollateral()) {
      nextBtnBHVSJ.sink.add(false);
    } else {
      nextBtnBHVSJ.sink.add(true);
    }
  }

  void validateDuration({required bool isMonthly, String? value}) {
    if (isMonthly) {
      if (regexJustNumber.hasMatch(value ?? '') && (value ?? '').isNotEmpty) {
        if (int.parse(value ?? '0') == 0) {
          mapValidate['duration'] = false;
          txtWarningDuration.sink.add('Duration must be greater than 0 month');
        } else if (int.parse(value ?? '') > 1200) {
          mapValidate['duration'] = false;
          txtWarningDuration.sink
              .add('Duration by month can not greater than 1200');
        } else {
          loanPackageRequest.durationQtyMin = '1';
          loanPackageRequest.durationQtyMax = value;
          loanPackageRequest.durationQtyType = '1';
          loanPackageRequest.recurringInterest = '1';
          mapValidate['duration'] = true;
          txtWarningDuration.sink.add('');
        }
      } else {
        loanPackageRequest.durationQtyMin = '1';
        loanPackageRequest.durationQtyMax = value;
        loanPackageRequest.durationQtyType = '1';
        loanPackageRequest.recurringInterest = '1';
        mapValidate['duration'] = false;
        txtWarningDuration.sink.add('Invalid Duration');
      }
    } else {
      if (regexJustNumber.hasMatch(value ?? '') && (value ?? '').isNotEmpty) {
        if (int.parse(value ?? '0') == 0) {
          mapValidate['duration'] = false;
          txtWarningDuration.sink.add('Duration must be greater than 0 week');
        } else if (int.parse(value ?? '') > 5200) {
          mapValidate['duration'] = false;
          txtWarningDuration.sink
              .add('Duration week day can not greater than 5200');
        } else {
          loanPackageRequest.durationQtyMin = '1';
          loanPackageRequest.durationQtyMax = value;
          loanPackageRequest.durationQtyType = '0';
          loanPackageRequest.recurringInterest = '0';
          mapValidate['duration'] = true;
          txtWarningDuration.sink.add('');
        }
      } else {
        loanPackageRequest.durationQtyMin = '1';
        loanPackageRequest.durationQtyMax = value;
        loanPackageRequest.durationQtyType = '0';
        loanPackageRequest.recurringInterest = '0';
        mapValidate['duration'] = false;
        txtWarningDuration.sink.add('Invalid Duration');
      }
    }
  }

  void validateMess(String value) {
    if (value.isEmpty) {
      txtWarningMess.sink.add('Message is required');
      mapValidate['message'] = false;
    } else if (value.length > 100) {
      txtWarningMess.sink.add('Maximum length allowed is 100 characters');
      mapValidate['message'] = false;
    } else {
      loanPackageRequest.description = value;
      mapValidate['message'] = true;
      txtWarningMess.sink.add('');
    }
  }

  final regexAmount = RegExp(r'^\d+((.)|(.\d{0,5})?)$');
  final regexInterestRate = RegExp(r'^\d+((.)|(.\d{0,2})?)$');
  final regexJustNumber = RegExp(r'^[0-9]*$');

  void validateAmount(String value1, String value2, {bool isMinLoan = true}) {
    if (isMinLoan) {
      if (value1.isEmpty) {
        mapValidate['loanMin'] = false;
        txtWarningLoanMinAmount.sink.add('Minimum loan amount is required');
      } else if (!regexAmount.hasMatch(value1)) {
        mapValidate['loanMin'] = false;
        txtWarningLoanMinAmount.sink.add('Invalid minimum loan amount');
      } else if (double.parse(value1) == 0) {
        mapValidate['loanMin'] = false;
        txtWarningLoanMinAmount.sink
            .add('Minimum loan amount must greater than 0');
      } else if (value1.length > 20) {
        mapValidate['loanMin'] = false;
        txtWarningLoanMinAmount.sink
            .add('Maximum length allowed is 20 characters');
      } else if (regexAmount.hasMatch(value2) && value2.isNotEmpty) {
        if (double.parse(value1) > double.parse(value2)) {
          mapValidate['loanMin'] = false;
          txtWarningLoanMinAmount.sink
              .add('Minimum amount must be smaller than maximum amount');
        } else {
          loanPackageRequest.allowedLoanMin = value1;
          mapValidate['loanMin'] = true;
          txtWarningLoanMinAmount.sink.add('');
        }
      } else {
        loanPackageRequest.allowedLoanMin = value1;
        mapValidate['loanMin'] = true;
        txtWarningLoanMinAmount.sink.add('');
      }
    } else {
      if (value1.isEmpty) {
        mapValidate['loanMax'] = false;
        txtWarningLoanMaxAmount.sink.add('Maximum loan amount is required');
      } else if (!regexAmount.hasMatch(value1)) {
        mapValidate['loanMax'] = false;
        txtWarningLoanMaxAmount.sink.add('Invalid maximum loan amount');
      } else if (double.parse(value1) == 0) {
        mapValidate['loanMax'] = false;
        txtWarningLoanMaxAmount.sink
            .add('Maximum loan amount must greater than 0');
      } else if (value1.length > 20) {
        mapValidate['loanMax'] = false;
        txtWarningLoanMaxAmount.sink
            .add('Maximum length allowed is 20 characters');
      } else if (regexAmount.hasMatch(value2) && value2.isNotEmpty) {
        if (double.parse(value1) < double.parse(value2)) {
          mapValidate['loanMax'] = false;
          txtWarningLoanMaxAmount.sink
              .add('Maximum amount must be greater than minimum amount');
        } else {
          loanPackageRequest.allowedLoanMax = value1;
          mapValidate['loanMax'] = true;
          txtWarningLoanMaxAmount.sink.add('');
        }
      } else {
        loanPackageRequest.allowedLoanMax = value1;
        mapValidate['loanMax'] = true;
        txtWarningLoanMaxAmount.sink.add('');
      }
    }
  }

  void validateInterestRate(String value) {
    if (value.isEmpty) {
      mapValidate['interestRate'] = false;
      txtWarningInterestRate.sink.add('Interest rate is required');
    } else if (!regexInterestRate.hasMatch(value) || double.parse(value) == 0) {
      mapValidate['interestRate'] = false;
      txtWarningInterestRate.sink.add('Invalid interest rate');
    } else if (value.length > 10) {
      mapValidate['interestRate'] = false;
      txtWarningInterestRate.sink
          .add('Maximum length allowed is 10 characters');
    } else {
      loanPackageRequest.interest = value;
      mapValidate['interestRate'] = true;
      txtWarningInterestRate.sink.add('');
    }
  }

  void validateLoanToVlFeatLTVThresHold(
    String value1,
    String value2, {
    bool isLoanToVL = true,
  }) {
    if (isLoanToVL) {
      if (value1.isEmpty) {
        mapValidate['loanToValue'] = false;
        txtWarningLoanToValue.sink.add('Loan to value is required');
      } else if (!regexAmount.hasMatch(value1) || double.parse(value1) == 0) {
        mapValidate['loanToValue'] = false;
        txtWarningLoanToValue.sink.add('Invalid loan to value');
      } else if (value1.length > 20) {
        mapValidate['loanToValue'] = false;
        txtWarningLoanToValue.sink
            .add('Maximum length allowed is 20 characters');
      } else if (double.parse(value1) > double.parse(value2)) {
        mapValidate['loanToValue'] = true;
        loanPackageRequest.loanToValue = value1;
        mapValidate['ltv'] = false;
        txtWarningLoanToValue.sink.add('');
        txtWarningLTVThresHold.sink.add('Invalid liquidation threshold');
      } else if (regexAmount.hasMatch(value1) &&
          regexAmount.hasMatch(value2) &&
          value2.isNotEmpty &&
          value1.isNotEmpty) {
        if (!checkGreaterThan20(value1: value1, value2: value2)) {
          mapValidate['loanToValue'] = true;
          mapValidate['ltv'] = true;
          loanPackageRequest.loanToValue = value1;
          loanPackageRequest.liquidationThreshold = value2;
          txtWarningLoanToValue.sink.add('');
          txtWarningLTVThresHold.sink
              .add('LTV Liquidation threshold should be 20% greater than LTV');
        } else {
          mapValidate['loanToValue'] = true;
          mapValidate['ltv'] = true;
          loanPackageRequest.loanToValue = value1;
          loanPackageRequest.liquidationThreshold = value2;
          txtWarningLoanToValue.sink.add('');
          txtWarningLTVThresHold.sink.add('');
        }
      } else {
        loanPackageRequest.loanToValue = value1;
        mapValidate['loanToValue'] = true;
        txtWarningLoanToValue.sink.add('');
      }
    } else {
      if (value1.isEmpty) {
        mapValidate['ltv'] = false;
        txtWarningLTVThresHold.sink.add('Liquidation threshold is required');
      } else if (!regexAmount.hasMatch(value1) || double.parse(value1) == 0) {
        mapValidate['ltv'] = false;
        txtWarningLTVThresHold.sink.add('Invalid liquidation threshold');
      } else if (value1.length > 20) {
        mapValidate['ltv'] = false;
        txtWarningLTVThresHold.sink
            .add('Maximum length allowed is 20 characters');
      } else if (regexAmount.hasMatch(value1) &&
          regexAmount.hasMatch(value2) &&
          value2.isNotEmpty &&
          value1.isNotEmpty) {
        if (!checkGreaterThan20(value1: value2, value2: value1)) {
          mapValidate['loanToValue'] = true;
          mapValidate['ltv'] = true;
          loanPackageRequest.liquidationThreshold = value1;
          loanPackageRequest.loanToValue = value2;
          txtWarningLTVThresHold.sink
              .add('LTV Liquidation threshold should be 20% greater than LTV');
        } else {
          mapValidate['loanToValue'] = true;
          mapValidate['ltv'] = true;
          loanPackageRequest.liquidationThreshold = value1;
          loanPackageRequest.loanToValue = value2;
          txtWarningLoanToValue.sink.add('');
          txtWarningLTVThresHold.sink.add('');
        }
      } else {
        mapValidate['ltv'] = true;
        loanPackageRequest.liquidationThreshold = value1;
        txtWarningLTVThresHold.sink.add('');
      }
    }
  }

  bool checkGreaterThan20({required String value1, required String value2}) {
    final double num1 = double.parse(value1);
    final double num2 = double.parse(value2);
    if (((num2 - num1) / 100) > 0.2) {
      return true;
    } else {
      return false;
    }
  }

  List<TokenInf> listToken = [];
  List<TokenInf> listRepaymentToken = [];
  List<TokenInf> listCollateralToken = [];

  void getListTokens() {
    final String list = PrefsService.getListTokenSupport();
    final List<TokenInf> listTokenInf = TokenInf.decode(list);
    for (final TokenInf value in listTokenInf) {
      if ((value.symbol ?? '') == 'DFY' ||
          (value.symbol ?? '') == 'BUSD' ||
          (value.symbol ?? '') == 'DAI' ||
          (value.symbol ?? '') == 'USDT' ||
          (value.symbol ?? '') == 'USDC') {
        listToken.add(value);
      }
      if ((value.symbol ?? '') == 'DFY') {
        listRepaymentToken.add(value);
      }
      if ((value.symbol ?? '') == 'ADA' ||
          (value.symbol ?? '') == 'DOT' ||
          (value.symbol ?? '') == 'BNB' ||
          (value.symbol ?? '') == 'BTC' ||
          (value.symbol ?? '') == 'ETH' ||
          (value.symbol ?? '') == 'LTC' ||
          (value.symbol ?? '') == 'XRP') {
        listCollateralToken.add(value);
      }
    }
  }

  void changeListRepaymentToken({required TokenInf value}) {
    if (listRepaymentToken.length == 1) {
      listRepaymentToken.add(value);
    } else {
      listRepaymentToken.removeAt(1);
      if ((value.symbol ?? '') != 'DFY') {
        listRepaymentToken.add(value);
      } else {}
    }
  }
}
