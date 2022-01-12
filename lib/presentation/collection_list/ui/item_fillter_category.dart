import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/fillterCollectionModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCategoryFilter extends StatelessWidget {
  final FilterCollectionModel filterModel;

  const ItemCategoryFilter({
    Key? key,
    required this.filterModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.34.sp,
          child: Checkbox(
            fillColor: MaterialStateProperty.all(
              AppTheme.getInstance().fillColor(),
            ),
            checkColor: AppTheme.getInstance().whiteColor(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            side: BorderSide(
              width: 1.w,
              color: AppTheme.getInstance().whiteColor(),
            ),
            value: filterModel.isCheck ?? false,
            onChanged: (bool? value) {},
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(45.r),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: CachedNetworkImage(
            width: 28,
            height: 28,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => Container(
              color: Colors.yellow,
              child: Text(
                filterModel.name?.substring(0, 1) ?? '',
                style: textNormalCustom(
                  Colors.black,
                  60,
                  FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            imageUrl: filterModel.urlImage ?? '',
          ),
        ),
        spaceW12,
        Wrap(
          children: [
            Text(
              filterModel.name ?? '',
              style: textNormal(
                AppTheme.getInstance().textThemeColor(),
                16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
