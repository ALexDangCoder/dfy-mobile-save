import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String? collectionId;

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
    this.collectionId,
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
        child: CachedNetworkImage(
          imageUrl: ApiConstants.BASE_URL_IMAGE+(avatarCid??''),
          placeholder: (context, url) => const CircularProgressIndicator(),
        ),
      ),
    };
  }
}
