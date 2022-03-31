import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_filter/is_base_checkbox_activity.dart';
import 'package:Dfy/presentation/pawn/collateral_nft_result/bloc/collateral_result_nft_bloc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/form/from_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_widget_filter.dart';
import 'item_widget_text.dart';

class FilterCollateralNFT extends StatefulWidget {
  const FilterCollateralNFT({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final CollateralResultNFTBloc bloc;

  @override
  _FilterCollateralNFTState createState() => _FilterCollateralNFTState();
}

class _FilterCollateralNFTState extends State<FilterCollateralNFT> {
  late TextEditingController textSearch;
  late TextEditingController textAmountFrom;
  late TextEditingController textAmountTo;

  @override
  void initState() {
    super.initState();
    textSearch = TextEditingController();
    textAmountFrom = TextEditingController();
    textAmountTo = TextEditingController();
    widget.bloc.statusFilterFirst();
    textSearch.text = widget.bloc.searchStatus ?? '';
    textAmountFrom.text = widget.bloc.amountFromStatus ?? '';
    textAmountTo.text = widget.bloc.amountToStatus ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final bloc = widget.bloc;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
      child: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          height: 812.h,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        textSearch.text = '';
                        textAmountTo.text = '';
                        textAmountFrom.text = '';
                        widget.bloc.funReset();
                        final FocusScopeNode currentFocus =
                            FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {});
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
                    )
                  ],
                ),
              ),
              spaceH12,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceH12,
                      FormSearchBase(
                        onChangedFunction: widget.bloc.funOnSearch,
                        onTapFunction: widget.bloc.funOnTapSearch,
                        urlIcon: ImageAssets.ic_search,
                        hint: S.current.search_pawnshop,
                        textSearchStream: widget.bloc.textSearch,
                        textSearch: textSearch,
                      ),
                      spaceH16,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Text(
                          S.current.nft_type,
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.w,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 14,
                              child: IsBaseCheckBox(
                                title: S.current.soft_nft,
                                stream: widget.bloc.isSort,
                                funText: () {},
                                funCheckBox: () {},
                              ),
                            ),
                            Expanded(
                              flex: 15,
                              child: IsBaseCheckBox(
                                title: S.current.hard_NFT,
                                stream: widget.bloc.isHard,
                                funText: () {},
                                funCheckBox: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      spaceH16,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Text(
                          S.current.asset_type,
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                      spaceH16,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: ItemWidgetTextFilter(
                          bloc: widget.bloc,
                          list: widget.bloc.listAssetFilter,
                        ),
                      ),
                      spaceH16,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Text(
                          S.current.loan_token,
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                      spaceH16,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: ItemWidgetFilter(
                          bloc: widget.bloc,
                          list: widget.bloc.listCollateralTokenFilter,
                          type: TypeCheckBox.COLLATERAL,
                        ),
                      ),
                      spaceH16,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Text(
                          S.current.expected_loan_range,
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                      spaceH16,
                      Center(
                        child: SizedBox(
                          width: 343.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 159.w,
                                height: 46.h,
                                padding:
                                    EdgeInsets.only(right: 15.w, left: 15.w),
                                decoration: BoxDecoration(
                                  color: AppTheme.getInstance()
                                      .backgroundBTSColor(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: textAmountFrom,
                                        maxLength: 50,
                                        onChanged: (value) {
                                          bloc.textAmountFrom.add(value);
                                          bloc.funValidateAmount(value);
                                        },
                                        cursorColor:
                                            AppTheme.getInstance().whiteColor(),
                                        style: textNormal(
                                          AppTheme.getInstance().whiteColor(),
                                          16,
                                        ),
                                        keyboardType: const TextInputType
                                            .numberWithOptions(
                                          decimal: true,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          isCollapsed: true,
                                          counterText: '',
                                          hintText: S.current.from,
                                          hintStyle: textNormal(
                                            Colors.white.withOpacity(0.5),
                                            16,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    StreamBuilder(
                                      stream: bloc.textAmountFrom,
                                      builder: (
                                        context,
                                        AsyncSnapshot<String> snapshot,
                                      ) {
                                        return GestureDetector(
                                          onTap: () {
                                            bloc.textAmountFrom.add('');
                                            textAmountFrom.text = '';
                                          },
                                          child:
                                              snapshot.data?.isNotEmpty ?? false
                                                  ? Image.asset(
                                                      ImageAssets.ic_close,
                                                      width: 20.w,
                                                      height: 20.h,
                                                    )
                                                  : SizedBox(
                                                      height: 20.h,
                                                      width: 20.w,
                                                    ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '-',
                                style: textNormal(
                                  null,
                                  26,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                width: 159.w,
                                height: 46.h,
                                padding:
                                    EdgeInsets.only(right: 15.w, left: 15.w),
                                decoration: BoxDecoration(
                                  color: AppTheme.getInstance()
                                      .backgroundBTSColor(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: textAmountTo,
                                        maxLength: 50,
                                        onChanged: (value) {
                                          bloc.textAmountTo.add(value);
                                          bloc.funValidateAmount(value);
                                        },
                                        cursorColor:
                                            AppTheme.getInstance().whiteColor(),
                                        style: textNormal(
                                          AppTheme.getInstance().whiteColor(),
                                          16,
                                        ),
                                        keyboardType: const TextInputType
                                            .numberWithOptions(
                                          decimal: true,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          isCollapsed: true,
                                          counterText: '',
                                          hintText: S.current.to,
                                          hintStyle: textNormal(
                                            Colors.white.withOpacity(0.5),
                                            16,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    StreamBuilder(
                                      stream: bloc.textAmountTo,
                                      builder: (
                                        context,
                                        AsyncSnapshot<String> snapshot,
                                      ) {
                                        return GestureDetector(
                                          onTap: () {
                                            bloc.textAmountTo.add('');
                                            textAmountTo.text = '';
                                          },
                                          child:
                                              snapshot.data?.isNotEmpty ?? false
                                                  ? Image.asset(
                                                      ImageAssets.ic_close,
                                                      width: 20.w,
                                                      height: 20.h,
                                                    )
                                                  : SizedBox(
                                                      height: 20.h,
                                                      width: 20.w,
                                                    ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      spaceH16,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Text(
                          S.current.collection,
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                      spaceH16,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: ItemWidgetFilter(
                          bloc: widget.bloc,
                          list: widget.bloc.listCollection,
                          type: TypeCheckBox.COLLECTION,
                        ),
                      ),
                      spaceH16,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Text(
                          S.current.duration,
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.w,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 14,
                              child: IsBaseCheckBox(
                                title: S.current.week,
                                stream: widget.bloc.isWeek,
                                funText: () {},
                                funCheckBox: () {},
                              ),
                            ),
                            Expanded(
                              flex: 15,
                              child: IsBaseCheckBox(
                                title: S.current.month,
                                stream: widget.bloc.isMonth,
                                funText: () {},
                                funCheckBox: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      spaceH40,
                    ],
                  ),
                ),
              ),
              spaceH8,
              GestureDetector(
                onTap: () {
                  widget.bloc.funFilter();
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
    );
  }
}
