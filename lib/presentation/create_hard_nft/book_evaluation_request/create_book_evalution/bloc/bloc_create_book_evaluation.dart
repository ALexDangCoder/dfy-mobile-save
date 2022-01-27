import 'package:Dfy/data/result/result.dart';
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

  BehaviorSubject<String> dateStream = BehaviorSubject.seeded('');
  BehaviorSubject<String> timeStream = BehaviorSubject.seeded('');
  String textValidateDate = '';
  String textValidateTime = '';
  BehaviorSubject<bool> isCheckTextValidateDate = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckTextValidateTime = BehaviorSubject.seeded(false);
  late double locationLong;
  late double locationLat;

  void getValidate(String hour, String minute) {
    final int hourInt = int.parse(hour);
    final int minuteInt = int.parse(minute);
    if (hourInt == 0) {
      isCheckTextValidateTime.add(true);
      textValidateTime = S.current.time_is_required;
    } else if (checkHourWorking(hourInt, minuteInt)) {
      isCheckTextValidateTime.add(true);
      textValidateTime = S.current.chosen_time;
    } else {
      isCheckTextValidateTime.add(false);
      textValidateTime = '';
    }
  }

  bool checkHourWorking(int hour, int minute) {
    final dtHour = DateTime.fromMillisecondsSinceEpoch(
      objDetail.value.workingTimeFrom ?? 0,
    );
    final String hourWorking = DateFormat('HH').format(dtHour);
    final int hourWorkingInt = int.parse(hourWorking);
    final dtMiu = DateTime.fromMillisecondsSinceEpoch(
      objDetail.value.workingTimeFrom ?? 0,
    );
    final String miuWorking = DateFormat('mm').format(dtMiu);
    final int miuWorkingInt = int.parse(miuWorking);

    final dtHourTo = DateTime.fromMillisecondsSinceEpoch(
      objDetail.value.workingTimeTo ?? 0,
    );
    final String hourWorkingTo = DateFormat('HH').format(dtHourTo);
    final int hourWorkingIntTo = int.parse(hourWorkingTo);
    final dtMiuTo = DateTime.fromMillisecondsSinceEpoch(
      objDetail.value.workingTimeTo ?? 0,
    );
    final String miuWorkingTo = DateFormat('mm').format(dtMiuTo);
    final int miuWorkingIntTo = int.parse(miuWorkingTo);

    if ((hourWorkingInt <= hour) &&
        (hourWorkingIntTo >= hour) &&
        ((hourWorkingIntTo == hour) &&
            ((miuWorkingInt <= minute) && (minute <= miuWorkingIntTo)))) {
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
