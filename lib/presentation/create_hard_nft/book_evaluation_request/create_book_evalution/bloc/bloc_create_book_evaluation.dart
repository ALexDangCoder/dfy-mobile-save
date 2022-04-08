import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/market_place/create_evaluation_model.dart';
import 'package:Dfy/domain/model/market_place/detail_asset_hard_nft.dart';
import 'package:Dfy/domain/model/market_place/evaluation_fee.dart';
import 'package:Dfy/domain/model/market_place/evaluator_detail.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class BlocCreateBookEvaluation {
  CreateHardNFTRepository get _createHardNFTRepository => Get.find();
  BehaviorSubject<EvaluatorsDetailModel> objDetail = BehaviorSubject();
  BehaviorSubject<bool> isCheckBtn = BehaviorSubject.seeded(false);
  final Web3Utils web3Client = Web3Utils();

  static const MONDAY = 1;
  static const TUESDAY = 2;
  static const WEDNESDAY = 3;
  static const THURSDAY = 4;
  static const FRIDAY = 5;
  static const SATURDAY = 6;
  static const SUNDAY = 7;

  static const JEWELRY = 0;
  static const ARTWORK = 2;
  static const CAR = 4;
  static const WATCH = 1;
  static const HOUSE = 3;
  static const OTHERS = 5;

  static const JANUARY = 1;
  static const FEBRUARY = 2;
  static const MARCH = 3;
  static const APRIL = 4;
  static const MAY = 5;
  static const JUNE = 6;
  static const JULY = 7;
  static const AUGUST = 8;
  static const SEPTEMBER = 9;
  static const OCTOBER = 10;
  static const NOVEMBER = 11;
  static const DECEMBER = 12;

  static final String MON = S.current.mon;
  static final String TUE = S.current.tue;
  static final String WED = S.current.wed;
  static final String THU = S.current.thu;
  static final String FRI = S.current.fri;
  static final String SAT = S.current.sat;
  static final String SUN = S.current.sun;

  static const String MINTING_FEE = '1';
  static const String EVALUATION_FEE = '2';
  static const String DFY_ADDRESS =
      '0x20f1dE452e9057fe863b99d33CF82DBeE0C45B14';

  BehaviorSubject<String> dateStream = BehaviorSubject.seeded('');
  BehaviorSubject<String> timeStream = BehaviorSubject.seeded('');
  String textValidateDate = '';
  String textValidateTime = '';
  BehaviorSubject<bool> isCheckTextValidateDate = BehaviorSubject.seeded(true);
  BehaviorSubject<bool> isCheckTextValidateTime = BehaviorSubject.seeded(false);
  double balanceCheck = 0;
  late double locationLong;
  late double locationLat;
  String? hourMy;
  String? minMy;
  String? dateMy;
  String? minuteMy;
  List<String> list = [];
  DateTime? dateTimeDay;
  EvaluationFee? evaluationFee;
  bool isDate = false;
  String? hexString;
  String? scanString;
  String? assetId;
  String? bcAssetId;
  String? typeNFT;
  String appointmentTime = '0';
  int appointmentTimeBE = 0;
  int? cityId;

  final Web3Utils web3utils = Web3Utils();

  void getDateStringToInt() {
    final DateTime dateTimeCreate = DateFormat(
      DateTimeFormat.CREATE_STRING_TO_DATE,
    ).parse(
      '${dateStream.value} '
      '${timeStream.value}',
    );
    appointmentTimeBE = dateTimeCreate.millisecondsSinceEpoch;
    double myDate = appointmentTimeBE / 1000;
    int secondInt = myDate.toInt();
    appointmentTime = secondInt.toString();
  }

  Future<double> getBalanceToken({
    required String ofAddress,
    required String tokenAddress,
  }) async {
    late final double balance;
    try {
      balance = await web3Client.getBalanceOfToken(
        ofAddress: ofAddress,
        tokenAddress: tokenAddress,
      );
      balanceCheck = balance;
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
    return balance;
  }

  Future<void> getHexString({
    required String assetId,
    required String appointmentTime,
    required String evaluationFeeAddress,
    required String evaluator,
  }) async {
    hexString = await web3utils.getCreateAppointmentData(
      assetId: assetId,
      appointmentTime: appointmentTime,
      evaluationFeeAddress: evaluationFeeAddress,
      evaluator: evaluator,
    );
  }

  Future<void> getDetailAssetHardNFT({
    required String assetId,
  }) async {
    final Result<DetailAssetHardNft> result =
        await _createHardNFTRepository.getDetailAssetHardNFT(
      assetId,
    );
    result.when(
      success: (res) {
        if (res.isBlank ?? false) {
        } else {
          bcAssetId = res.bcAssetId.toString();
          typeNFT = res.assetType?.name;
        }
      },
      error: (error) {},
    );
  }

  bool checkValidateDay(String day) {
    bool isDay = false;
    for (int i = 0; i < (objDetail.value.workingDays?.length ?? 0); i++) {
      if (day.toUpperCase() ==
          (checkWorkingDay(objDetail.value.workingDays?[i] ?? 0))
              .toUpperCase()) {
        isDay = true;
        break;
      } else {
        isDay = false;
      }
    }
    return isDay;
  }

  void checkButton() {
    if (isCheckTextValidateDate.value && !isCheckTextValidateTime.value) {
      isCheckBtn.add(true);
    } else {
      isCheckBtn.add(false);
    }
  }

  void getValidateDay(String day) {
    if (dateStream.value == '') {
      isCheckTextValidateDate.add(false);
      textValidateDate = S.current.date_is_required;
    } else if (!checkValidateDay(day)) {
      isCheckTextValidateDate.add(false);
      textValidateDate = S.current.chosen_date;
    } else {
      isCheckTextValidateDate.add(true);
      textValidateDate = '';
    }
    checkButton();
  }

  Future<void> createEvaluation({
    required int appointmentTime,
    required String assetId,
    required String bcTxnHash,
    required String evaluatorAddress,
    required String evaluatorId,
  }) async {
    final Result<CreateEvaluationModel> result =
        await _createHardNFTRepository.createEvaluation(
      appointmentTime,
      assetId,
      bcTxnHash,
      evaluatorAddress,
      evaluatorId,
    );
    result.when(
      success: (res) {
        if (res.isBlank ?? false) {
        } else {}
      },
      error: (error) {},
    );
  }

  void getValidate(String hour, String minute) {
    final int hourInt = int.parse(hour);
    final int minuteInt = int.parse(minute);
    if (timeStream.value == '') {
      isCheckTextValidateTime.add(true);
      textValidateTime = S.current.time_is_required;
    } else if (checkHourWorking(hourInt, minuteInt)) {
      isCheckTextValidateTime.add(true);
      textValidateTime = S.current.chosen_time;
    } else {
      isCheckTextValidateTime.add(false);
      textValidateTime = '';
    }
    checkButton();
  }

  bool checkHourWorking(int hour, int minute) {
    //working hour
    final workingHour = DateTime.fromMillisecondsSinceEpoch(
      objDetail.value.workingTimeFrom ?? 0,
    );
    final String hourWorking =
        DateFormat(DateTimeFormat.BOOK_HOUR).format(workingHour);
    final int hourWorkingInt = int.parse(hourWorking);
    //working Min
    final workingMin = DateTime.fromMillisecondsSinceEpoch(
      objDetail.value.workingTimeFrom ?? 0,
    );
    final String minWorking =
        DateFormat(DateTimeFormat.BOOK_MIN).format(workingMin);
    final int minWorkingInt = int.parse(minWorking);

    //time now
    final String minNow =
        DateFormat(DateTimeFormat.BOOK_MIN).format(DateTime.now());
    final int minNowInt = int.parse(minNow);

    final String hourNow =
        DateFormat(DateTimeFormat.BOOK_HOUR).format(DateTime.now());
    final int hourNowInt = int.parse(hourNow);

    // working hour close
    final workingHourClose = DateTime.fromMillisecondsSinceEpoch(
      objDetail.value.workingTimeTo ?? 0,
    );
    final String hourWorkingTo =
        DateFormat(DateTimeFormat.BOOK_HOUR).format(workingHourClose);
    final int hourWorkingIntTo = int.parse(hourWorkingTo);

    //working miu close
    final workingMinClose = DateTime.fromMillisecondsSinceEpoch(
      objDetail.value.workingTimeTo ?? 0,
    );
    final String minWorkingTo =
        DateFormat(DateTimeFormat.BOOK_MIN).format(workingMinClose);
    final int minWorkingIntTo = int.parse(minWorkingTo);

    if (isDate) {
      if (hourNowInt == hour && minNowInt <= minute) {
        return checkDateTime(
          hour: hour,
          hourWorkingInt: hourWorkingInt,
          hourWorkingIntTo: hourWorkingIntTo,
          minute: minute,
          minWorkingInt: minWorkingInt,
          minWorkingIntTo: minWorkingIntTo,
        );
      } else if (hourNowInt < hour) {
        return checkDateTime(
          hour: hour,
          hourWorkingInt: hourWorkingInt,
          hourWorkingIntTo: hourWorkingIntTo,
          minute: minute,
          minWorkingInt: minWorkingInt,
          minWorkingIntTo: minWorkingIntTo,
        );
      } else {
        return true;
      }
    } else {
      return checkDateTime(
        hour: hour,
        hourWorkingInt: hourWorkingInt,
        hourWorkingIntTo: hourWorkingIntTo,
        minute: minute,
        minWorkingInt: minWorkingInt,
        minWorkingIntTo: minWorkingIntTo,
      );
    }
  }

  bool checkDateTime({
    required int hourWorkingIntTo,
    required int hour,
    required int minute,
    required int minWorkingIntTo,
    required int minWorkingInt,
    required int hourWorkingInt,
  }) {
    if (hourWorkingIntTo == 0) {
      hourWorkingIntTo = 24;
    }
    if (hour == 0) {
      hour = 24;
    }

    if ((hourWorkingIntTo == hour && minute <= minWorkingIntTo) ||
        (hourWorkingInt == hour && minWorkingInt <= minute)) {
      return false;
    } else if (hourWorkingInt < hour && hourWorkingIntTo > hour) {
      return false;
    } else {
      return true;
    }
  }

  String getTextCreateAt(int dateCreateAt) {
    String textDate = '';
    final dt = DateTime.fromMillisecondsSinceEpoch(dateCreateAt);
    final String mm = DateFormat(DateTimeFormat.BOOK_MONTH).format(dt);
    final String yyyy = DateFormat(DateTimeFormat.BOOK_YEAR).format(dt);
    textDate = '${S.current.joined_in}${getMonth(mm)} $yyyy';
    return textDate;
  }

  void getDataInput(int dateCreate) {
    if (dateCreate != 0) {
      final dt = DateTime.fromMillisecondsSinceEpoch(dateCreate);
      final String time = DateFormat(DateTimeFormat.BOOK_HOURS).format(dt);
      final String day = DateFormat(DateTimeFormat.BOOK_DATE).format(dt);
      dateStream.add(day);
      timeStream.add(time);
    }
  }

  String getMonth(String mm) {
    final int date = int.parse(mm);
    switch (date) {
      case JANUARY:
        return S.current.january;
      case FEBRUARY:
        return S.current.february;
      case MARCH:
        return S.current.march;
      case APRIL:
        return S.current.april;
      case MAY:
        return S.current.may;
      case JUNE:
        return S.current.june;
      case JULY:
        return S.current.july;
      case AUGUST:
        return S.current.august;
      case SEPTEMBER:
        return S.current.september;
      case OCTOBER:
        return S.current.october;
      case NOVEMBER:
        return S.current.november;
      case DECEMBER:
        return S.current.december;
      default:
        return '';
    }
  }

  Future<void> getDetailEvaluation({
    required String evaluationID,
  }) async {
    final Result<EvaluatorsDetailModel> result =
        await _createHardNFTRepository.getEvaluatorsDetail(
      evaluationID,
    );
    result.when(
      success: (res) {
        if (res.isBlank ?? false) {
        } else {
          locationLat = res.locationLat ?? 0;
          locationLong = res.locationLong ?? 0;
          objDetail.add(res);
        }
      },
      error: (error) {},
    );
  }

  Future<void> getEvaluationFee() async {
    final Result<List<EvaluationFee>> result =
        await _createHardNFTRepository.getEvaluationFee();
    result.when(
      success: (res) {
        if (res.isBlank ?? false) {
        } else {
          for (final value in res) {
            if (value.id == EVALUATION_FEE) {
              evaluationFee = value;
            }
          }
        }
      },
      error: (error) {},
    );
  }

  String textWorkingDay(int day) {
    switch (day) {
      case MONDAY:
        return S.current.monday;
      case FRIDAY:
        return S.current.friday;
      case SATURDAY:
        return S.current.saturday;
      case SUNDAY:
        return S.current.sunday;
      case THURSDAY:
        return S.current.thursday;
      case TUESDAY:
        return S.current.tuesday;
      case WEDNESDAY:
        return S.current.wednesday;
      default:
        return '';
    }
  }

  String checkWorkingDay(int day) {
    switch (day) {
      case MONDAY:
        return MON;
      case FRIDAY:
        return FRI;
      case SATURDAY:
        return SAT;
      case SUNDAY:
        return SUN;
      case THURSDAY:
        return THU;
      case TUESDAY:
        return TUE;
      case WEDNESDAY:
        return WED;
      default:
        return '';
    }
  }

  String linkImage(int assetType) {
    switch (assetType) {
      case JEWELRY:
        return ImageAssets.diamond;
      case ARTWORK:
        return ImageAssets.artWork;
      case CAR:
        return ImageAssets.car;
      case WATCH:
        return ImageAssets.watch;
      case HOUSE:
        return ImageAssets.house;
      case OTHERS:
        return ImageAssets.others;
      default:
        return '';
    }
  }

  String addressCheckNull(String address) {
    String addressFormat = '';
    if (address.length > 20) {
      addressFormat = address.formatAddressWalletConfirm();
    } else {
      addressFormat = address;
    }
    return addressFormat;
  }
}
