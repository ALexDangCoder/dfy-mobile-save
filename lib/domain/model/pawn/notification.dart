import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

class NotificationData {
  int? type;
  int? total;

  NotificationData({this.type, this.total});
}

class NotificationDetail {
  int? id;
  int? notiType;
  int? userType;
  int? txType;
  String? metaData;
  bool? isRead;
  bool? isDelete;
  int? createAt;
  int? readAt;
  NotiDTO? notiDTO;

  NotificationDetail({
    this.id,
    this.notiType,
    this.userType,
    this.txType,
    this.metaData,
    this.isRead,
    this.isDelete,
    this.createAt,
    this.readAt,
    this.notiDTO,
  });
}

@JsonSerializable()
class NotiDTO {
  CollateralNotiDTO? collateralNotiDTO;
  OfferNotiDTO? offerNotiDTO;
  PackageNotiDTO? packageNotiDTO;
  ContractNotiDTO? contractNotiDTO;
  RepaymentNotiDTO? repaymentNotiDTO;
  ReviewNotiDTO? reviewNotiDTO;

  NotiDTO({
    this.collateralNotiDTO,
    this.offerNotiDTO,
    this.packageNotiDTO,
    this.contractNotiDTO,
    this.repaymentNotiDTO,
    this.reviewNotiDTO,
  });

  factory NotiDTO.fromJson(Map<String, dynamic> json) =>
      _$NotiDTOFromJson(json);

  Map<String, dynamic> toJson() => _$NotiDTOToJson(this);
}

@JsonSerializable()
class CollateralNotiDTO {
  int? idCollateral;
  String? nameCollateral;
  double? amount;
  double? amountAdd;
  String? cryptoAsset;

  CollateralNotiDTO({
    this.idCollateral,
    this.nameCollateral,
    this.amount,
    this.amountAdd,
    this.cryptoAsset,
  });

  factory CollateralNotiDTO.fromJson(Map<String, dynamic> json) =>
      _$CollateralNotiDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CollateralNotiDTOToJson(this);
}

@JsonSerializable()
class OfferNotiDTO {
  int? idOffer;
  String? nameOffer;
  double? loanAmount;
  String? cryptoAsset;

  OfferNotiDTO({
    this.idOffer,
    this.nameOffer,
    this.loanAmount,
    this.cryptoAsset,
  });

  factory OfferNotiDTO.fromJson(Map<String, dynamic> json) =>
      _$OfferNotiDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OfferNotiDTOToJson(this);
}

@JsonSerializable()
class PackageNotiDTO {
  int? idPackage;
  String? namePackage;
  int? idUser;
  String? nameUser;
  String? addOwner;

  PackageNotiDTO({
    this.idPackage,
    this.namePackage,
    this.idUser,
    this.nameUser,
    this.addOwner,
  });
  factory PackageNotiDTO.fromJson(Map<String, dynamic> json) =>
      _$PackageNotiDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PackageNotiDTOToJson(this);
}

@JsonSerializable()
class ContractNotiDTO {
  int? idContract;
  num? ltvCurrent;
  num? ltvLiquidation;
  String? dueDate;
  num? amountLoan;
  String? cryptoLoan;
  String? reason;
  String? addLender;
  String? txnHash;
  num? amountActuallyReceive;
  num? systemFee;
  num? interest;

  ContractNotiDTO({
    this.idContract,
    this.ltvCurrent,
    this.ltvLiquidation,
    this.dueDate,
    this.amountLoan,
    this.cryptoLoan,
    this.reason,
    this.addLender,
    this.txnHash,
    this.amountActuallyReceive,
    this.systemFee,
    this.interest,
  });

  factory ContractNotiDTO.fromJson(Map<String, dynamic> json) =>
      _$ContractNotiDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ContractNotiDTOToJson(this);
}

@JsonSerializable()
class RepaymentNotiDTO {
  num? amountRepay;
  String? cryptoRepay;
  String? dueDate;
  String? txnHash;
  String? typeRepay;

  RepaymentNotiDTO({
    this.amountRepay,
    this.cryptoRepay,
    this.dueDate,
    this.txnHash,
    this.typeRepay,
  });

  factory RepaymentNotiDTO.fromJson(Map<String, dynamic> json) =>
      _$RepaymentNotiDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RepaymentNotiDTOToJson(this);
}

@JsonSerializable()
class ReviewNotiDTO {
  int? idReviewer;
  int? idContract;
  int? points;
  String? comment;
  String? nameReviewer;
  String? reviewType;

  ReviewNotiDTO({
    this.idReviewer,
    this.idContract,
    this.points,
    this.comment,
    this.nameReviewer,
    this.reviewType,
  });
  factory ReviewNotiDTO.fromJson(Map<String, dynamic> json) =>
      _$ReviewNotiDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewNotiDTOToJson(this);
}
