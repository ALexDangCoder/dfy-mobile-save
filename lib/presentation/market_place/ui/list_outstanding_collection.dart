import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/ui/collection_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOutstandingCollection extends StatelessWidget {
  const ListOutstandingCollection({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final MarketplaceCubit cubit;

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
                S.current.outstanding_collection,
                style: textNormalCustom(
                  Colors.white,
                  20.sp,
                  FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.collectionList,
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cubit.outstandingCollection.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CollectionItem(
                  urlIcon: cubit.outstandingCollection[index].avatarCid ?? '',
                  title: cubit.outstandingCollection[index].name ?? 'error',
                  urlBackGround:
                      cubit.outstandingCollection[index].coverCid ?? '',
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
