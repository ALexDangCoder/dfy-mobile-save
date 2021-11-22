import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionItem extends StatelessWidget {
  final String urlBackGround;
  final String urlIcon;
  final String title;

  const CollectionItem({
    Key? key,
    required this.urlBackGround,
    required this.urlIcon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 147.h,
          width: 222.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.getInstance().selectDialogColor(),
              width: 1.w,
            ),
            color: AppTheme.getInstance().borderItemColor(),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    urlBackGround,
                    width: 222.w,
                    height: 77.h,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 34.h,
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 51.h,
                child: SizedBox(
                  height: 42.h,
                  width: 42.w,
                  child: AvatarView(
                    borderWidth: 4,
                    borderColor: AppTheme.getInstance().borderItemColor(),
                    imagePath: urlIcon,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
    );
  }
}
