import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/item/item_collection/item_colection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'filter.dart';

class CollectionList extends StatefulWidget {
  const CollectionList({Key? key}) : super(key: key);

  @override
  _CollectionListState createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 48.h,
            ),
            Container(
              height: 764.h,
              width: 375.w,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.h),
                  topRight: Radius.circular(30.h),
                ),
              ),
              child: Column(
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
                          margin: EdgeInsets.only(left: 16.w),
                          width: 28.w,
                          height: 28.h,
                          child: Image.asset(ImageAssets.ic_back),
                        ),
                      ),
                      Text(
                        S.current.collection_list,
                        style: textNormalCustom(null, 20, FontWeight.w700),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => Filter(),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 16.w),
                          width: 28.w,
                          height: 28.h,
                          child: Image.asset(ImageAssets.ic_filter),
                        ),
                      ),
                    ],
                  ),
                  spaceH20,
                  line,
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        top: 24.h,
                        bottom: 24.h,
                        right: 16.w,
                        left: 16.w,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 20.h,
                        crossAxisCount: 2,
                      ),
                      itemCount: 300,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRouter.detailCollection,
                            );
                          },
                          child: const ItemCollection(
                            items: '1025',
                            text:
                                'Velit magnis praesent sapien etiam. Mattis sit mae...Velit magnis praesent sapien etiam. Mattis sit mae...Velit magnis praesent sapien etiam. Mattis sit mae...Velit magnis praesent sapien etiam. Mattis sit mae...Velit magnis praesent sapien etiam. Mattis sit mae...Velit magnis praesent sapien etiam. Mattis sit mae...Velit magnis praesent sapien etiam. Mattis sit mae...',
                            urlIcon: 'assets/images/pop_image.png',
                            owners: '321',
                            title: 'Artwork collection',
                            urlBackGround: 'assets/images/pop_image.png',
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
