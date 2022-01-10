import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionDetailError extends StatelessWidget {
  const CollectionDetailError({
    Key? key,
    required this.cubit,
    required this.collectionAddress,
  }) : super(key: key);
  final DetailCollectionBloc cubit;
  final String collectionAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        color: AppTheme.getInstance().bgErrorLoad(),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(16.w),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    ImageAssets.img_back,
                    width: 32.h,
                    height: 32.h,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 100.h,
            ),
            height: 140.h,
            width: 140.w,
            child: Image.asset(
              ImageAssets.err_load_category,
              fit: BoxFit.fill,
            ),
          ),
          spaceH24,
          Flexible(
            child: Text(
              S.current.could_not_load_data,
              style: textNormalCustom(
                const Color(0xffE6E6E6),
                26.sp,
                FontWeight.w400,
              ),
            ),
          ),
          spaceH24,
          InkWell(
            onTap: () {
              cubit.getCollection(collectionAddress: collectionAddress);
            },
            child: SizedBox(
              height: 60.h,
              width: 60.w,
              child: Image.asset(
                ImageAssets.reload_category,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
