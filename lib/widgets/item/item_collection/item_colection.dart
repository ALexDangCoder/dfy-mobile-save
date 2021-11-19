import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCollection extends StatelessWidget {
  final String urlBackGround;
  final String urlIcon;
  final String title;
  final String items;
  final String owners;
  final String text;

  const ItemCollection({
    Key? key,
    required this.urlBackGround,
    required this.urlIcon,
    required this.title,
    required this.items,
    required this.owners,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 181.h,
          width: 164.w,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.getInstance().selectDialogColor(),
              width: 1.w,
            ),
            color: AppTheme.getInstance().borderItemColor(),
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                urlBackGround,
                width: 164.w,
                height: 58.h,
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 8.w,
                  right: 8.w,
                  top: 25.h,
                ),
                child: Text(
                  title,
                  style: textNormalCustom(null, 14, FontWeight.w600),
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
                  '$items ${S.current.items} • $owners ${S.current.owners}',
                  style: textNormalCustom(
                    Colors.white.withOpacity(0.7),
                    12,
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
                    Colors.white.withOpacity(0.7),
                    12,
                    FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 38.h,
          child: SizedBox(
            height: 40.h,
            width: 40.w,
            child: AvatarView(
              borderWidth: 3,
              borderColor: AppTheme.getInstance().borderItemColor(),
              imagePath: urlIcon,
            ),
          ),
        ),
      ],
    );
  }
}
