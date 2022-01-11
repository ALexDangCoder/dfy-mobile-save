import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/ui/collection_list.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/ui/collection_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/error_nft_collection_explore/error_load_collection.dart';
import 'package:Dfy/widgets/skeleton/skeleton_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOutstandingCollection extends StatelessWidget {
  const ListOutstandingCollection({
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
        //text outstanding feat button arrow
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isLoading
                    ? S.current.loading_text
                    : (isLoadFail
                        ? S.current.error_text
                        : S.current.outstanding_collection),
                style: textNormalCustom(
                  Colors.white,
                  20.sp,
                  FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  isLoading
                      ? () {}
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => CollectionList(
                              query: '',
                              title: '',
                            ),
                          ),
                        );
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 16.w,
                  ),
                  child: Image(
                    height: 32.h,
                    width: 32.w,
                    image: const AssetImage(
                      ImageAssets.img_push,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        //list outstanding collection
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 147.h,
            child: isLoadFail
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          ErrorLoadCollection(
                            callback: () {
                              cubit.getListNftCollectionExplore();
                            },
                          ),
                          spaceW20,
                        ],
                      );
                    },
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: isLoading
                        ? 6
                        : (cubit.outstandingCollection.length > 6)
                            ? 6
                            : cubit.outstandingCollection.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return isLoading
                          ? Row(
                              children: [
                                const SkeletonCollection(),
                                spaceW20,
                              ],
                            )
                          : CollectionItem(
                              collectionAddress: cubit
                                  .outstandingCollection[index]
                                  .collectionAddress,
                              typeCollection: cubit
                                  .outstandingCollection[index].collectionType,
                              urlIcon: cubit
                                      .outstandingCollection[index].avatarCid ??
                                  '',
                              title: cubit.outstandingCollection[index].name ??
                                  'error',
                              urlBackGround:
                                  cubit.outstandingCollection[index].coverCid ??
                                      '',
                              idCollection:
                                  cubit.outstandingCollection[index].id ?? '',
                            );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
