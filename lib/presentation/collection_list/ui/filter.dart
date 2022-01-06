import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_filter/is_base_checkbox_activity.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Filter extends StatefulWidget {
  final CollectionBloc collectionBloc;

  const Filter({
    Key? key,
    required this.collectionBloc,
  }) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final collectionBloc = widget.collectionBloc;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 9.h,
            ),
            SizedBox(
              height: 5.h,
              child: Center(
                child: Image.asset(
                  ImageAssets.imgRectangle,
                ),
              ),
            ),
            spaceH20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 65.w,
                  ),
                  Text(
                    S.current.filter,
                    style: textNormalCustom(
                      null,
                      20,
                      FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.collectionBloc.reset();
                    },
                    child: Container(
                      height: 30.h,
                      width: 65.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().colorTextReset(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.r),
                        ),
                      ),
                      child: FittedBox(
                        child: Text(
                          S.current.reset,
                          style: textNormalCustom(
                            null,
                            14,
                            null,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            spaceH24,
            Container(
              padding: EdgeInsets.only(
                left: 6.w,
                right: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      S.current.collection_type,
                      style: textNormalCustom(null, 16, FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          funCheckBox: collectionBloc.allCollection,
                          funText: collectionBloc.allCollection,
                          title: S.current.all,
                          stream: collectionBloc.isAll,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox.shrink(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.soft_nft,
                          stream: collectionBloc.isSoftNft,
                        ),
                      ),
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.hard_nft,
                          stream: collectionBloc.isHardNft,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      S.current.category,
                      style: textNormalCustom(null, 16, FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          funCheckBox: collectionBloc.allCategory,
                          funText: collectionBloc.allCategory,
                          title: S.current.all,
                          stream: collectionBloc.isAllCategory,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox.shrink(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.art,
                          stream: collectionBloc.isArt,
                        ),
                      ),
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.game,
                          stream: collectionBloc.isGame,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.music,
                          stream: collectionBloc.isMusic,
                        ),
                      ),
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.collectibles,
                          stream: collectionBloc.isCollectibles,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.sports,
                          stream: collectionBloc.isSports,
                        ),
                      ),
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.ultilities,
                          stream: collectionBloc.isUltilities,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.cars,
                          stream: collectionBloc.isCars,
                        ),
                      ),
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.others,
                          stream: collectionBloc.isOthersCategory,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            spaceH24,
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: ButtonLuxury(
                title: S.current.apply,
                isEnable: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
