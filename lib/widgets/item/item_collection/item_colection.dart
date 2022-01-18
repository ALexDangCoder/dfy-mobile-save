import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCollection extends StatelessWidget {
  final String urlBackGround;
  final String urlIcon;
  final String title;
  final String items;
  final String? itemsKey;
  final String owners;
  final String? ownersKey;
  final String text;
  final bool? fixWidth;
  final BoxFit? backgroundFit;

  const ItemCollection({
    Key? key,
    required this.urlBackGround,
    required this.urlIcon,
    required this.title,
    required this.items,
    required this.owners,
    required this.text,
    this.backgroundFit = BoxFit.fitWidth,
    this.fixWidth = true,
    this.itemsKey,
    this.ownersKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: fixWidth ?? true ? 164.w : double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.getInstance().borderItemColor(),
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
            border: Border.all(
              color: AppTheme.getInstance().selectDialogColor(),
              width: 1.w,
            ),
          ),
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: fixWidth ?? true ? 164.w : double.infinity,
                height: 58.h,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().selectDialogColor(),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      urlBackGround,
                    ),
                    fit: backgroundFit ?? BoxFit.fitWidth,
                  ),
                ),
                // child: ,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 8.w,
                  right: 8.w,
                  top: 25.h,
                ),
                child: Text(
                  title,
                  style: textNormalCustom(null, 14.sp, FontWeight.w600),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 8.w,
                  right: 8.w,
                  top: 4.h,
                ),
                child: Text(
                  '$items ${itemsKey ?? S.current.items} • $owners ${ownersKey ?? S.current.owners.toLowerCase()}',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteWithOpacity(),
                    12.sp,
                    FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 8.w,
                  right: 8.w,
                  top: 8.h,
                ),
                child: Text(
                  text,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteWithOpacity(),
                    12.sp,
                    FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              spaceH24,
            ],
          ),
        ),
        Positioned(
          top: 38.h,
          child: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.getInstance().borderItemColor(),
                width: 3.w,
              ),
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: 37.w,
              height: 37.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                urlIcon,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
