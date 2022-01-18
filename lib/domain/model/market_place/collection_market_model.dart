import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionMarketModel {
  String? id;
  String? name;
  String? description;
  int? type;
  String? avatarCid;
  String? coverCid;
  int? totalNft;
  int? nftOwnerCount;
  String? addressCollection;

  CollectionMarketModel({
    this.id,
    this.name,
    this.description,
    this.type,
    this.avatarCid,
    this.coverCid,
    this.totalNft,
    this.nftOwnerCount,
    this.addressCollection,
  });

  Map<String, dynamic> toDropDownMap(){
    return {
      'label': name,
      'value': addressCollection,
      'icon': Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        height: 28.h,
        width: 28.h,
        child: Image.network(ApiConstants.BASE_URL_IMAGE+(avatarCid??'')),
      ),
    };
  }

}
