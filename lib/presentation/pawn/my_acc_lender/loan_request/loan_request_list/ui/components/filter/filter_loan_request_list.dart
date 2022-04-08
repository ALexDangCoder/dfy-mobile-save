import 'dart:ui';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/bloc/lender_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/filter/filter_collateral.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/ckc_filter/ckc_filter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterLoanRequest extends StatefulWidget {
  const FilterLoanRequest({
    Key? key,
    required this.cubit,
    required this.indexTab,
  }) : super(key: key);
  final LenderLoanRequestCubit cubit;
  final int indexTab;

  @override
  _FilterLoanRequestState createState() => _FilterLoanRequestState();
}

class _FilterLoanRequestState extends State<FilterLoanRequest> {
  late List<Map<String, dynamic>> initValueFilterList;
  late List<Map<String, dynamic>> initNFTFilterList;

  late Map<String, dynamic> currentWallet;

  @override
  void initState() {
    super.initState();
    initValueFilterList = widget.cubit.listFilterStatusOriginal;
    initNFTFilterList = widget.cubit.listFilterNftTypeOriginal;
    widget.cubit.getListWallet();
    if (widget.cubit.tempWalletFilter['label'] == 'null') {
      currentWallet = widget.cubit.walletAddressDropDown[0];
    } else {
      currentWallet = widget.cubit.tempWalletFilter;
    }
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
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headerFtResetBtn(),
                  spaceH20,
                  _dropDownSelectWallet(),
                  spaceH16,
                  if (widget.indexTab == 0)
                    _buildFilterCrypto()
                  else
                    _buildFilterNFT(),
                  spaceH16,
                  Text(
                    S.current.status,
                    style: textNormalCustom(null, 16, FontWeight.w600),
                  ),
                  spaceH16,
                  _buildFilterStatus()
                ],
              ),
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
                    if (widget.indexTab == 0) {
                      widget.cubit.crypoList.clear();
                      widget.cubit.getListCryptoApi();
                    } else {
                      widget.cubit.nftList.clear();
                      widget.cubit.getListNftApi();
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

  StreamBuilder<List<Map<String, dynamic>>> _buildFilterStatus() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      initialData: initValueFilterList,
      stream: widget.cubit.filterListBHVSJ,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    isSelected: (snapshot.data ?? [])[0]['isSelected'],
                    nameCkcFilter: S.current.all.capitalize(),
                  ),
                ),
                Expanded(
                  child: CheckBoxFilterWidget(
                    typeCkc: TYPE_CKC_FILTER.NON_IMG,
                    callBack: (value) {
                      widget.cubit.pickJustOneFilter(value);
                    },
                    index: 1,
                    isSelected: (snapshot.data ?? [])[1]['isSelected'],
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
                    index: 2,
                    isSelected: (snapshot.data ?? [])[2]['isSelected'],
                    nameCkcFilter: S.current.rejected.capitalize(),
                  ),
                ),
                Expanded(
                  child: CheckBoxFilterWidget(
                    typeCkc: TYPE_CKC_FILTER.NON_IMG,
                    callBack: (value) {
                      widget.cubit.pickJustOneFilter(value);
                    },
                    index: 3,
                    isSelected: (snapshot.data ?? [])[3]['isSelected'],
                    nameCkcFilter: S.current.accepted.capitalize(),
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
                    isSelected: (snapshot.data ?? [])[4]['isSelected'],
                    nameCkcFilter: S.current.canceled.capitalize(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
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
        child: StreamBuilder<List<Map<String, dynamic>>>(
            initialData: widget.cubit.walletAddressDropDown,
            stream: widget.cubit.listWalletBHVSJ,
            builder: (context, snapshot) {
              return DropdownButtonHideUnderline(
                child: DropdownButton2<Map<String, dynamic>>(
                  buttonDecoration: BoxDecoration(
                    color: AppTheme.getInstance().backgroundBTSColor(),
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                  ),
                  items: (snapshot.data ?? []).map((element) {
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
                      widget.cubit.tempWalletFilter = newValue;
                      widget.cubit.filterWalletAddress = currentWallet['value'];
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
              );
            }),
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
                  widget.cubit.resetFilter(widget.indexTab);
                  currentWallet = widget.cubit.walletAddressDropDown[0];
                  setState(() {});
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

  Widget _buildFilterCrypto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.collateral.capitalize(),
          style: textNormalCustom(null, 16, FontWeight.w600),
        ),
        spaceH16,
        FilterCollateral(
          key: UniqueKey(),
          cubit: widget.cubit,
          list: widget.cubit.listTokenFilter,
        )
      ],
    );
  }

  Widget _buildFilterNFT() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.nft_type.capitalize(),
          style: textNormalCustom(
            AppTheme.getInstance().whiteColor(),
            16,
            FontWeight.w600,
          ),
        ),
        spaceH16,
        StreamBuilder<List<Map<String, dynamic>>>(
          initialData: initNFTFilterList,
          stream: widget.cubit.filterListNFTBHVSJ,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CheckBoxFilterWidget(
                        typeCkc: TYPE_CKC_FILTER.NON_IMG,
                        callBack: (value) {
                          widget.cubit.pickJustOneFilter(value, isNft: true);
                        },
                        index: 0,
                        isSelected: (snapshot.data ?? [])[0]['isSelected'],
                        nameCkcFilter: S.current.all.capitalize(),
                      ),
                    ),
                    Expanded(
                      child: CheckBoxFilterWidget(
                        typeCkc: TYPE_CKC_FILTER.NON_IMG,
                        callBack: (value) {
                          widget.cubit.pickJustOneFilter(
                            value,
                            isNft: true,
                          );
                        },
                        index: 1,
                        isSelected: (snapshot.data ?? [])[1]['isSelected'],
                        nameCkcFilter: S.current.hard_nft.capitalize(),
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
                          widget.cubit.pickJustOneFilter(
                            value,
                            isNft: true,
                          );
                        },
                        index: 2,
                        isSelected: (snapshot.data ?? [])[2]['isSelected'],
                        nameCkcFilter: S.current.soft_nft.capitalize(),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
