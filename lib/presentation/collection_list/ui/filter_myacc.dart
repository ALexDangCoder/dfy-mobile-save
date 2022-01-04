import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_filter/is_base_checkbox_activity.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/form/from_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterMyAcc extends StatefulWidget {
  final CollectionBloc collectionBloc;

  const FilterMyAcc({
    Key? key,
    required this.collectionBloc,
  }) : super(key: key);

  @override
  _FilterMyAccState createState() => _FilterMyAccState();
}

class _FilterMyAccState extends State<FilterMyAcc> {
  late final TextEditingController searchFilter;

  @override
  void initState() {
    super.initState();
    searchFilter = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final collectionBloc = widget.collectionBloc;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          GestureDetector(
            onTap: () {
              final FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              collectionBloc.isChooseAcc.sink.add(false);
            },
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
                            widget.collectionBloc.resetFilterMyAcc();
                            searchFilter.text = '';
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
                            S.current.NFTs_collateral,
                            style: textNormalCustom(null, 16, FontWeight.w600),
                          ),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              collectionBloc.isChooseAcc.sink.add(true);
                            },
                            child: StreamBuilder<String>(
                                stream: collectionBloc.textAddressFilter,
                                builder: (context, snapshot) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      top: 16.h,
                                      bottom: 12.h,
                                      // right: 16.w,
                                      left: 10.w,
                                    ),
                                    height: 46.h,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.5.w,),
                                    decoration: BoxDecoration(
                                      color: AppTheme.getInstance()
                                          .itemBtsColors(),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.r),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                snapshot.data ?? '',
                                                style: textNormal(
                                                  null,
                                                  16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Image.asset(
                                          ImageAssets.ic_line_down,
                                          height: 20.67.h,
                                          width: 20.14.w,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
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
                                funText: collectionBloc.allCollection,
                                funCheckBox: collectionBloc.allCollection,
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
                                title: S.current.hard_nft,
                                stream: collectionBloc.isHardNft,
                              ),
                            ),
                            Expanded(
                              child: IsBaseCheckBox(
                                title: S.current.soft_nft,
                                stream: collectionBloc.isSoftNft,
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
                        spaceH12,
                      ],
                    ),
                  ),
                  FormSearchBase(
                    onChangedFunction: collectionBloc.funOnSearchCategory,
                    onTapFunction: collectionBloc.funOnTapSearchCategory,
                    urlIcon: ImageAssets.ic_search,
                    hint: S.current.name_of_collection,
                    textSearchStream: collectionBloc.textSearchCategory,
                    textSearch: searchFilter,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 6.w,
                      right: 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: IsBaseCheckBox(
                                funCheckBox: collectionBloc.allCategoryMyAcc,
                                funText: collectionBloc.allCategoryMyAcc,
                                title: S.current.all_category,
                                stream: collectionBloc.isAllCategoryMyAcc,
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
                                title: S.current.all,
                                stream: collectionBloc.isCategoryType1,
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
                                title: S.current.all,
                                stream: collectionBloc.isCategoryType2,
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
                                title: S.current.all,
                                stream: collectionBloc.isCategoryType3,
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
                                title: S.current.all,
                                stream: collectionBloc.isCategoryType4,
                              ),
                            ),
                            const Expanded(
                              child: SizedBox.shrink(),
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
          ),
          StreamBuilder<bool>(
            initialData: false,
            stream: collectionBloc.isChooseAcc,
            builder: (ctx, snapshot) {
              return Visibility(
                visible: snapshot.data ?? false,
                child: Positioned(
                  top: 180.h,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().colorTextReset(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                    ),
                    width: 343.w,
                    height: 177.h,
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        top: 24.h,
                      ),
                      itemCount: collectionBloc.listAcc.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            collectionBloc.textAddressFilter.sink.add(
                              collectionBloc.listAcc[index],
                            );
                            collectionBloc.isChooseAcc.sink.add(false);
                          },
                          child: Container(
                            height: 54.h,
                            padding: EdgeInsets.only(
                              left: 24.w,
                            ),
                            child: Text(
                              collectionBloc.listAcc[index],
                              style: textNormalCustom(null, 16, null),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
