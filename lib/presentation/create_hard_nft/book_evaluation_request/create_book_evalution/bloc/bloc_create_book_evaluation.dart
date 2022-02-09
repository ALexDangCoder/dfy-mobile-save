import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/market_place/evaluation_fee.dart';
import 'package:Dfy/domain/model/market_place/evaluator_detail.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class BlocCreateBookEvaluation {
  CreateHardNFTRepository get _createHardNFTRepository => Get.find();
  BehaviorSubject<EvaluatorsDetailModel> objDetail = BehaviorSubject();
  BehaviorSubject<bool> isCheckBtn = BehaviorSubject.seeded(false);
  static const MONDAY = 0;
  static const TUESDAY = 1;
  static const WEDNESDAY = 2;
  static const THURSDAY = 3;
  static const FRIDAY = 4;
  static const SATURDAY = 5;
  static const SUNDAY = 6;

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

  static const String MON = 'THỨ HAI';
  static const String TUE = 'THỨ BA';
  static const String WED = 'THỨ TƯ';
  static const String THU = 'THỨ NĂM';
  static const String FRI = 'THỨ SÁU';
  static const String SAT = 'THỨ BẢY';
  static const String SUN = 'CHỦ NHẬT';

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

  final Web3Utils web3utils = Web3Utils();

  Future<void> getHexString() async {
    hexString = await web3utils.getCreateAssetRequestData(
      collectionStandard: 0,
      assetCID:'QmWEXMYLQEWmTK9Z8jkABKsmTY3HLrcR3xCwm3zSRt2x18',
      beAssetId:'6203742c4aec3de4976bbbad',
      collectionAsset:'0xa2E3Db206948b93201a8c732bdA8385B77D48002',
      expectingPrice:'50',
      expectingPriceAddress:DFY_ADDRESS,
    );//todo
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
      (objDetail.value.workingTimeFrom ?? 0) * 1000,
    );
    final String hourWorking = DateFormat('HH').format(workingHour);
    final int hourWorkingInt = int.parse(hourWorking);
    //working Min
    final workingMin = DateTime.fromMillisecondsSinceEpoch(
      (objDetail.value.workingTimeFrom ?? 0) * 1000,
    );
    final String minWorking = DateFormat('mm').format(workingMin);
    final int minWorkingInt = int.parse(minWorking);

    //time now
    final String minNow = DateFormat('mm').format(DateTime.now());
    final int minNowInt = int.parse(minNow);

    final String hourNow = DateFormat('HH').format(DateTime.now());
    final int hourNowInt = int.parse(hourNow);

    // working hour close
    final workingHourClose = DateTime.fromMillisecondsSinceEpoch(
      (objDetail.value.workingTimeTo ?? 0) * 1000,
    );
    final String hourWorkingTo = DateFormat('HH').format(workingHourClose);
    final int hourWorkingIntTo = int.parse(hourWorkingTo);

    //working miu close
    final workingMinClose = DateTime.fromMillisecondsSinceEpoch(
      (objDetail.value.workingTimeTo ?? 0) * 1000,
    );
    final String minWorkingTo = DateFormat('mm').format(workingMinClose);
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
    final String mm = DateFormat('MM').format(dt);
    final String yyyy = DateFormat('yyyy').format(dt);
    textDate = '${S.current.joined_in}${getMonth(mm)}$yyyy';
    return textDate;
  }

  void getDataInput(int dateCreate) {
    if (dateCreate != 0) {
      final dt = DateTime.fromMillisecondsSinceEpoch(dateCreate);
      final String time = DateFormat('HH:mm').format(dt);
      final String day = DateFormat('dd/MM/yyyy').format(dt);
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
        if (res.isBlank ?? false) {} else {
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
        if (res.isBlank ?? false) {} else {
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
        return ImageAssets.img_diamond;
      case ARTWORK:
        return ImageAssets.img_artwork;
      case CAR:
        return ImageAssets.img_car;
      case WATCH:
        return ImageAssets.img_watch;
      case HOUSE:
        return ImageAssets.img_house;
      case OTHERS:
        return ImageAssets.img_other;
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
