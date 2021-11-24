import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IsOnSale extends StatelessWidget {
  final String title;
  final DetailCollectionBloc collectionBloc;

  const IsOnSale({
    Key? key,
    required this.title,
    required this.collectionBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      margin: EdgeInsets.only(left: 4,top: 12.h, bottom: 12.h),
      child: Row(
        children: [
          StreamBuilder(
            stream: collectionBloc.isOnSale,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return Transform.scale(
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
                  value: snapshot.data ?? false,
                  onChanged: (value) {
                    collectionBloc.isOnSale.sink.add(true);
                    if (snapshot.data ?? false) {
                      collectionBloc.isOnSale.sink.add(false);
                    }
                  },
                ),
              );
            },
          ),
          Text(
            title,
            style: textNormal(
              AppTheme.getInstance().textThemeColor(),
              16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
