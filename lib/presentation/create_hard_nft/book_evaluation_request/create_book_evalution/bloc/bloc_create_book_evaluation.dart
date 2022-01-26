import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/evaluator_detail.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class BlocCreateBookEvaluation {
  CreateHardNFTRepository get _createHardNFTRepository => Get.find();
  BehaviorSubject<EvaluatorsDetailModel> objDetail = BehaviorSubject();
  BehaviorSubject<bool> isCheckBtn = BehaviorSubject.seeded(false);
  static const MONDAY = 1;
  static const TUESDAY = 2;
  static const WEDNESDAY = 3;
  static const THURSDAY = 4;
  static const FRIDAY = 5;
  static const SATURDAY = 6;
  static const SUNDAY = 0;
  static const JEWELRY = 1;
  static const ARTWORK = 2;
  static const CAR = 3;
  static const WATCH = 4;
  static const HOUSE = 5;
  static const OTHERS = 6;

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

  BehaviorSubject<String> dateStream = BehaviorSubject.seeded('');
  BehaviorSubject<String> timeStream = BehaviorSubject.seeded('');
}
