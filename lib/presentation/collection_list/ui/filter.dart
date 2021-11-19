import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
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

import 'check_box/art.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  late final CollectionBloc collectionBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    collectionBloc = CollectionBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Center(
              child: Image.asset(
                ImageAssets.imgRectangle,
              ),
            ),
          ),
          spaceH20,
          Expanded( // todo custom check box
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 25.h,
                          margin: EdgeInsets.only(left: 16.w),
                          child: Text(
                            S.current.owner,
                            style: textNormalCustom(null, 20, FontWeight.w600),
                          ),
                        ),
                        IsMyCollection(
                          title: S.current.my_collection,
                          collectionBloc: collectionBloc,
                        ),
                        Container(
                          height: 25.h,
                          margin: EdgeInsets.only(left: 16.w),
                          child: Text(
                            S.current.category,
                            style: textNormalCustom(null, 20, FontWeight.w600),
                          ),
                        ),
                        IsArt(
                          title: S.current.art,
                          collectionBloc: collectionBloc,
                        ),
                        IsMusic(
                          title: S.current.music,
                          collectionBloc: collectionBloc,
                        ),
                        IsSport(
                          title: S.current.sports,
                          collectionBloc: collectionBloc,
                        ),
                        IsCars(
                          title: S.current.cars,
                          collectionBloc: collectionBloc,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        IsOthes(
                          title: S.current.others,
                          collectionBloc: collectionBloc,
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        IsGame(
                          title: S.current.game,
                          collectionBloc: collectionBloc,
                        ),
                        IsCollectibles(
                          title: S.current.collectibles,
                          collectionBloc: collectionBloc,
                        ),
                        IsUltilities(
                          title: S.current.ultilities,
                          collectionBloc: collectionBloc,
                        ),
                        IsOthesCategory(
                          title: S.current.others,
                          collectionBloc: collectionBloc,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ButtonLuxury(
            title: S.current.apply,
            isEnable: true,
          ),
        ],
      ),
    );
  }
}
