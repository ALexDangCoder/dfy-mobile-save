import 'package:Dfy/presentation/categories_detail/ui/categories_detail.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/ui/category.dart';
import 'package:Dfy/widgets/error_nft_collection_explore/error_load_explore.dart';
import 'package:Dfy/widgets/error_nft_collection_explore/error_load_nft.dart';
import 'package:Dfy/widgets/skeleton/skeleton_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListExploreCategory extends StatelessWidget {
  const ListExploreCategory({
    Key? key,
    required this.cubit,
    required this.isLoading,
    required this.isLoadFail,
  }) : super(key: key);
  final MarketplaceCubit cubit;
  final bool isLoading;
  final bool isLoadFail;

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
            child: isLoadFail
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ErrorLoadExplore(
                        callback: () {
                          cubit.getListNftCollectionExplore();
                        },
                      );
                    },
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: isLoading ? 6 : cubit.exploreCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return isLoading
                          ? const SkeletonCategory()
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CategoriesDetail(title: 'Music',),
                                  ),
                                );
                              },
                              child: Category(
                                title: cubit.exploreCategories[index].name ??
                                    'name',
                                url: cubit.exploreCategories[index].avatarCid ??
                                    '',
                              ),
                            );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
