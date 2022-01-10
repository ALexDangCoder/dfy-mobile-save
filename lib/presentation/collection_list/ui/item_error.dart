import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCollectionError extends StatelessWidget {
  const ItemCollectionError({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final CollectionBloc cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164.w,
      height: 181.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        color: AppTheme.getInstance().bgErrorLoad(),
      ),
      padding: EdgeInsets.only(top: 11.h),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 54.h,
              width: 54.w,
              child: Image.asset(ImageAssets.err_load_category),
            ),
            spaceH24,
            Flexible(
              child: Text(
                S.current.could_not_load_data,
                style: textNormalCustom(
                  const Color(0xffE6E6E6),
                  13.sp,
                  FontWeight.w400,
                ),
              ),
            ),
            spaceH24,
            InkWell(
              onTap: () {
                cubit.getCollection(
                  sortFilter: cubit.sortFilter,
                  name: cubit.textSearch.value,
                );
              },
              child: SizedBox(
                height: 36.h,
                width: 36.w,
                child: Image.asset(ImageAssets.reload_category),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
