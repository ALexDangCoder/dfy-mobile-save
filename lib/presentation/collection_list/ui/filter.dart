import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:Dfy/presentation/collection_list/ui/check_box/art.dart';
import 'package:Dfy/presentation/collection_list/ui/check_box/cars.dart';
import 'package:Dfy/presentation/collection_list/ui/check_box/collectibles.dart';
import 'package:Dfy/presentation/collection_list/ui/check_box/game.dart';
import 'package:Dfy/presentation/collection_list/ui/check_box/music.dart';
import 'package:Dfy/presentation/collection_list/ui/check_box/my_collection.dart';
import 'package:Dfy/presentation/collection_list/ui/check_box/others.dart';
import 'package:Dfy/presentation/collection_list/ui/check_box/others_category.dart';
import 'package:Dfy/presentation/collection_list/ui/check_box/sports.dart';
import 'package:Dfy/presentation/collection_list/ui/check_box/ultilities.dart';
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
          children: [
            SizedBox(
              height: 9.h,
            ),
            SizedBox(
              height: 5.h,
              width: 109.w,
              child: Center(
                child: Image.asset(
                  ImageAssets.imgRectangle,
                ),
              ),
            ),
            spaceH20,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        S.current.owner,
                        style: textNormalCustom(null, 20.sp, FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: IsMyCollection(
                            title: S.current.my_collection,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                        Expanded(
                          child: IsOthes(
                            title: S.current.others,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        S.current.category,
                        style: textNormalCustom(null, 20.sp, FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: IsArt(
                            title: S.current.art,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                        Expanded(
                          child: IsGame(
                            title: S.current.game,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: IsMusic(
                            title: S.current.music,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                        Expanded(
                          child: IsCollectibles(
                            title: S.current.collectibles,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: IsSport(
                            title: S.current.sports,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                        Expanded(
                          child: IsUltilities(
                            title: S.current.ultilities,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: IsCars(
                            title: S.current.cars,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                        Expanded(
                          child: IsOthesCategory(
                            title: S.current.others,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
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
