import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'is_checkbox.dart';

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
                left: 16.w,
                right: 16.w,
              ),
              child: StreamBuilder<List<bool>>(
                  stream: collectionBloc.listCheckBoxFilterStream,
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Text(
                            S.current.sort_by,
                            style: textNormalCustom(null, 16, FontWeight.w600),
                          ),
                        ),
                        spaceH4,
                        IsBaseCheckBox(
                          index: 0,
                          title: S.current.highest_trading_volume,
                          bloc: collectionBloc,
                        ),
                        IsBaseCheckBox(
                          index: 1,
                          title: S.current.lowest_trading_volume,
                          bloc: collectionBloc,
                        ),
                        IsBaseCheckBox(
                          index: 2,
                          title: S.current.newest,
                          bloc: collectionBloc,
                        ),
                        IsBaseCheckBox(
                          index: 3,
                          title: S.current.oldest,
                          bloc: collectionBloc,
                        ),
                        IsBaseCheckBox(
                          index: 4,
                          title: S.current.owner_from_high_to_low,
                          bloc: collectionBloc,
                        ),
                        IsBaseCheckBox(
                          index: 5,
                          title: S.current.owner_from_low_to_high,
                          bloc: collectionBloc,
                        ),
                        IsBaseCheckBox(
                          index: 6,
                          title: S.current.item_from_high_to_low,
                          bloc: collectionBloc,
                        ),
                        IsBaseCheckBox(
                          index: 7,
                          title: S.current.item_from_low_to_high,
                          bloc: collectionBloc,
                        ),
                      ],
                    );
                  }),
            ),
            spaceH24,
            GestureDetector(
              onTap: () {
                collectionBloc.funFilter(
                  index: collectionBloc.sortFilter + 1,
                );
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
