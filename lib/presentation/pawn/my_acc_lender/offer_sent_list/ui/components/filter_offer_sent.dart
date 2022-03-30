import 'dart:ui';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/offer_sent_list_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/ckc_filter/ckc_filter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilerOfferSent extends StatefulWidget {
  const FilerOfferSent({
    Key? key,
    required this.cubit,
    required this.indexTab,
  }) : super(key: key);
  final OfferSentListCubit cubit;
  final int indexTab;

  @override
  _FilerOfferSentState createState() => _FilerOfferSentState();
}

class _FilerOfferSentState extends State<FilerOfferSent> {
  late List<Map<String, dynamic>> initValueFilterList;

  late Map<String, dynamic> currentWallet;

  @override
  void initState() {
    super.initState();
    initValueFilterList = widget.cubit.filterOriginalList;
    currentWallet = widget.cubit.walletAddressDropDown[0];
    // if(widget.indexTab == 0) {
    //   //this is crypto tab
    // } else {
    //   //this is nft tab
    // }
    // print(initValueFilterList);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
      child: Container(
        height: 704.h,
        padding: EdgeInsets.only(
          top: 33.h,
          left: 16.w,
          right: 16.w,
        ),
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerFtResetBtn(),
                spaceH20,
                _dropDownSelectWallet(),
                spaceH16,
                Text(
                  S.current.status.capitalize(),
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w600,
                  ),
                ),
                spaceH16,
                StreamBuilder<List<Map<String, dynamic>>>(
                  initialData: initValueFilterList,
                  stream: widget.cubit.filterListBHVSJ,
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: (value) {
                                  widget.cubit.pickJustOneFilter(value);
                                },
                                index: 0,
                                isSelected: (snapshot.data ?? [])[0]
                                    ['isSelected'],
                                nameCkcFilter: S.current.all.capitalize(),
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: (value) {
                                  widget.cubit.pickJustOneFilter(value);
                                },
                                index: 3,
                                isSelected: (snapshot.data ?? [])[3]
                                    ['isSelected'],
                                nameCkcFilter: S.current.open.capitalize(),
                              ),
                            )
                          ],
                        ),
                        spaceH15,
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: (value) {
                                  widget.cubit.pickJustOneFilter(value);
                                },
                                index: 7,
                                isSelected: (snapshot.data ?? [])[7]
                                    ['isSelected'],
                                nameCkcFilter: S.current.accepted.capitalize(),
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: (value) {
                                  widget.cubit.pickJustOneFilter(value);
                                },
                                index: 8,
                                isSelected: (snapshot.data ?? [])[8]
                                    ['isSelected'],
                                nameCkcFilter: S.current.rejected.capitalize(),
                              ),
                            )
                          ],
                        ),
                        spaceH15,
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: (value) {
                                  widget.cubit.pickJustOneFilter(value);
                                },
                                index: 9,
                                isSelected: (snapshot.data ?? [])[9]
                                    ['isSelected'],
                                nameCkcFilter: S.current.canceled.capitalize(),
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: (value) {
                                  widget.cubit.pickJustOneFilter(value);
                                },
                                index: 1,
                                isSelected: (snapshot.data ?? [])[1]
                                    ['isSelected'],
                                nameCkcFilter:
                                    S.current.process_create.capitalize(),
                              ),
                            )
                          ],
                        ),
                        spaceH15,
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: (value) {
                                  widget.cubit.pickJustOneFilter(value);
                                },
                                index: 4,
                                isSelected: (snapshot.data ?? [])[4]
                                    ['isSelected'],
                                nameCkcFilter:
                                    S.current.processing_accept.capitalize(),
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: (value) {
                                  widget.cubit.pickJustOneFilter(value);
                                },
                                index: 5,
                                isSelected: (snapshot.data ?? [])[5]
                                    ['isSelected'],
                                nameCkcFilter:
                                    S.current.processing_reject.capitalize(),
                              ),
                            )
                          ],
                        ),
                        spaceH15,
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: (value) {
                                  widget.cubit.pickJustOneFilter(value);
                                },
                                index: 6,
                                isSelected: (snapshot.data ?? [])[6]
                                    ['isSelected'],
                                nameCkcFilter:
                                    S.current.processing_cancel.capitalize(),
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: (value) {
                                  widget.cubit.pickJustOneFilter(value);
                                },
                                index: 2,
                                isSelected: (snapshot.data ?? [])[2]
                                    ['isSelected'],
                                nameCkcFilter:
                                    S.current.failed_create.capitalize(),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
            Positioned(
              bottom: 38.h,
              child: SizedBox(
                width: 343.w,
                child: ButtonGradient(
                  gradient: RadialGradient(
                    center: const Alignment(0.5, -0.5),
                    radius: 4,
                    colors: AppTheme.getInstance().gradientButtonColor(),
                  ),
                  child: Text(
                    S.current.apply,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.cubit.listOfferSentCrypto.clear();
                    if (widget.indexTab == 0) {
                      widget.cubit.getListOfferSentCrypto(
                        walletAddress: currentWallet['value'],
                        status: widget.cubit.statusFilter,
                        type: 0.toString(),
                      );
                    } else {
                      widget.cubit.getListOfferSentCrypto(
                        walletAddress: currentWallet['value'],
                        status: widget.cubit.statusFilter,
                        type: 1.toString(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDownSelectWallet() {
    return Container(
      height: 64.h,
      width: double.infinity,
      padding: EdgeInsets.only(right: 15.w, left: 15.w),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().backgroundBTSColor(),
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      child: Theme(
        data: ThemeData(
          hintColor: Colors.white24,
          selectedRowColor: Colors.white24,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<Map<String, dynamic>>(
            buttonDecoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            items: widget.cubit.walletAddressDropDown.map((element) {
              return DropdownMenuItem(
                value: element,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                  ),
                  child: Text(
                    element['label'],
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (Map<String, dynamic>? newValue) {
              setState(() {
                currentWallet = newValue!;
              });
            },
            dropdownMaxHeight: 200,
            dropdownWidth: MediaQuery.of(context).size.width - 32.w,
            dropdownDecoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            scrollbarThickness: 0,
            scrollbarAlwaysShow: false,
            offset: Offset(-16.w, 0),
            value: currentWallet,
            icon: Image.asset(
              ImageAssets.ic_line_down,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerFtResetBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 3,
          child: Container(),
        ),
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.filter,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  20,
                  FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  widget.cubit.resetFilter();
                  setState(() {
                    currentWallet = widget.cubit.walletAddressDropDown[0];
                  });
                },
                child: Container(
                  height: 30,
                  padding: EdgeInsets.symmetric(
                    vertical: 6.h,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.r),
                    ),
                    color: AppTheme.getInstance().skeleton(),
                  ),
                  child: Text(
                    S.current.reset,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
