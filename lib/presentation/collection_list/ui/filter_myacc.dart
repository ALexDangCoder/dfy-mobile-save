import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_filter/is_base_checkbox_activity.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = widget.collectionBloc;
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
              bloc.isChooseAcc.sink.add(false);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: SingleChildScrollView(
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 6.h,
                            ),
                            child: Text(
                              S.current.reset,
                              style: textNormalCustom(
                                AppTheme.getInstance().bgBtsColor(),
                                14,
                                null,
                              ),
                            ),
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
                            },
                            child: Container(
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
                              S.current.address,
                              style:
                                  textNormalCustom(null, 16, FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                bloc.isChooseAcc.sink.add(true);
                              },
                              child: StreamBuilder<String>(
                                stream: bloc.textAddressFilter,
                                builder: (context, snapshot) {
                                  final String address =
                                      bloc.checkAddress(snapshot.data ?? '');
                                  return Container(
                                    margin: EdgeInsets.only(
                                      top: 16.h,
                                      bottom: 12.h,
                                      // right: 16.w,
                                      left: 10.w,
                                    ),
                                    height: 46.h,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.5.w,
                                    ),
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
                                                address,
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
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              S.current.collection_type,
                              style:
                                  textNormalCustom(null, 16, FontWeight.w600),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: IsBaseCheckBox(
                                  title: S.current.hard_nft,
                                  stream: bloc.isHardCollection,
                                  funText: () {},
                                  funCheckBox: () {},
                                ),
                              ),
                              Expanded(
                                child: IsBaseCheckBox(
                                  title: S.current.soft_nft,
                                  stream: bloc.isSoftCollection,
                                  funText: () {},
                                  funCheckBox: () {},
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
                        bloc.funFilterMyAcc();
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
          ),
          StreamBuilder<bool>(
            initialData: false,
            stream: bloc.isChooseAcc,
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
                    height: 123.h,
                    child: ListView.builder(
                      itemCount: bloc.listAcc.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            bloc.chooseAddressFilter(bloc.listAcc[index]);
                          },
                          child: Container(
                            height: 54.h,
                            padding: EdgeInsets.only(
                              left: 24.w,
                              top: 15.h,
                            ),
                            color: bloc.listAcc[index] ==
                                    bloc.textAddressFilter.value
                                ? AppTheme.getInstance()
                                    .whiteColor()
                                    .withOpacity(0.3)
                                : Colors.transparent,
                            child: Text(
                              bloc.listAcc[index] == S.current.all
                                  ? S.current.all
                                  : bloc.listAcc[index]
                                      .formatAddressWalletConfirm(),
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
