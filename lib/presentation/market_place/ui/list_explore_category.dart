import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/ui/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ListExploreCategory extends StatelessWidget {
  const ListExploreCategory({Key? key, required this.cubit}) : super(key: key);
  final MarketplaceCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              S.current.explore_categories,
              style: textNormalCustom(
                Colors.white,
                20.sp,
                FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 130.h,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cubit.categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Category(
                  title: cubit.categories[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
