import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/pawn_shop_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PawnList extends StatefulWidget {
  const PawnList({Key? key}) : super(key: key);

  @override
  _PawnListState createState() => _PawnListState();
}

class _PawnListState extends State<PawnList> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            height: 764.h,
            decoration: BoxDecoration(
              color: AppTheme.getInstance().bgBtsColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.h),
                topRight: Radius.circular(30.h),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 16.w,
                        ),
                        width: 28.w,
                        height: 28.h,
                        child: Image.asset(
                          ImageAssets.ic_back,
                        ),
                      ),
                    ),
                    Text(
                      S.current.pawnshop_list,
                      style: textNormalCustom(
                        null,
                        20.sp,
                        FontWeight.w700,
                      ).copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(right: 16.w),
                        width: 24.w,
                        height: 24.h,
                        child: Image.asset(ImageAssets.ic_filter),
                      ),
                    ),
                  ],
                ),
                spaceH20,
                line,
                spaceH12,
                //todo
                spaceH24,
                PawnItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
