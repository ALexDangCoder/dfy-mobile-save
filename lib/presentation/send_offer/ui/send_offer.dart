import 'dart:developer';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/nft_on_pawn.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/send_offer/bloc/send_offer_cubit.dart';
import 'package:Dfy/presentation/send_offer/ui/day_drop_down.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/custom_form_validate.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendOffer extends StatefulWidget {
  const SendOffer({Key? key, required this.nftOnPawn}) : super(key: key);
  final NftOnPawn nftOnPawn;

  @override
  State<SendOffer> createState() => _SendOfferState();
}

class _SendOfferState extends State<SendOffer> {
  final Map<GlobalKey, bool> validator = {};
  final SendOfferCubit _cubit = SendOfferCubit();
  int loanDurationType = 0;
  String duration = '';
  String loanAmount = '';
  int repaymentCycleType = 0;
  String interest = '';
  String repaymentAsset = DFY;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> listValueDuration = [
      {
        'value': ID_MONTH.toString(),
        'label': S.current.month,
      },
      {
        'value': ID_WEEK.toString(),
        'label': S.current.week,
      }
    ];
    final List<Map<String, String>> listValueInterest = [
      {
        'value': ID_MONTH.toString(),
        'label': S.current.monthly,
      },
      {
        'value': ID_WEEK.toString(),
        'label': S.current.weekly,
      }
    ];
    final List<Map<String, dynamic>> listValueToken = [
      {
        'value': ID_MONTH.toString(),
        'label': DFY,
        'icon': SizedBox(
          height: 20.h,
          child: Image.asset(ImageAssets.getSymbolAsset(DFY)),
        )
      },
      {
        'value': ID_WEEK.toString(),
        'label': widget.nftOnPawn.expectedCollateralSymbol ?? '',
        'icon': SizedBox(
          height: 20.h,
          child: Image.asset(
            ImageAssets.getSymbolAsset(
              widget.nftOnPawn.expectedCollateralSymbol ?? '',
            ),
          ),
        )
      }
    ];

    return BaseBottomSheet(
      title: S.current.send_offer,
      isImage: true,
      text: ImageAssets.ic_close,
      bottomBar: Container(
        padding: EdgeInsets.only(bottom: 38.h),
        color: AppTheme.getInstance().bgBtsColor(),
        child: StreamBuilder<bool>(
            initialData: false,
            stream: _cubit.btnStream,
            builder: (context, snapshot) {
              final isEnable = snapshot.data ?? false;
              return GestureDetector(
                onTap: isEnable
                    ? () {
                        _cubit.getPawnHexString(
                          nftCollateralId:
                              widget.nftOnPawn.nftCollateralDetailDTO?.collectionAddress ??
                                  '',
                          repaymentAsset: repaymentAsset,
                          loanAmount: loanAmount,
                          interest: interest,
                          duration: duration,
                          loanDurationType: loanDurationType,
                          repaymentCycleType: repaymentCycleType,
                          context: context,
                        ).then((value) => log(value));
                      }
                    : () {},
                child: ButtonGold(
                  title: S.current.send_offer,
                  isEnable: isEnable,
                ),
              );
            }),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH24,
                    Text(
                      S.current.message,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        14.sp,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH4,
                    CustomFormValidate(
                      hintText: S.current.enter_msg,
                      validator: validator,
                      onChange: (value) {
                        _cubit.btnSink.add(!validator.values.contains(false));
                      },
                      validatorValue: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.current.invalid_message;
                        } else {
                          _cubit.message = value!;
                        }
                        return null;
                      },
                      inputType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      S.current.loan_amount,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        14.sp,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH4,
                    CustomFormValidate(
                      validator: validator,
                      onChange: (value) {
                        _cubit.btnSink.add(!validator.values.contains(false));
                      },
                      validatorValue: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.current.invalid_amount;
                        } else {
                          loanAmount = value!;
                        }
                        return null;
                      },
                      hintText: S.current.enter_loan_amount,
                      inputType: TextInputType.number,
                      suffix: SizedBox(
                        width: 70.w,
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: Image.network(
                                    widget.nftOnPawn.urlToken ?? ''),
                              ),
                              spaceW4,
                              Text(
                                widget.nftOnPawn.expectedCollateralSymbol ?? '',
                                style: textNormalCustom(
                                  AppTheme.getInstance().textThemeColor(),
                                  14.sp,
                                  FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      S.current.interest_rate,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        14.sp,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH4,
                    CustomFormValidate(
                      validator: validator,
                      onChange: (value) {
                        _cubit.btnSink.add(!validator.values.contains(false));
                      },
                      validatorValue: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.current.invalid_interest_rate;
                        } else {
                          interest = value!;
                        }
                        return null;
                      },
                      hintText: S.current.enter_interest_rate,
                      inputType: TextInputType.number,
                      suffix: SizedBox(
                        width: 20.w,
                        child: Center(
                          child: Text(
                            PERCENT,
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              14.sp,
                              FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      S.current.duration,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        14.sp,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH4,
                    CustomFormValidate(
                      validator: validator,
                      validatorValue: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.current.invalid_duration;
                        } else {
                          duration = value!;
                        }
                        return null;
                      },
                      onChange: (value) {
                        _cubit.btnSink.add(!validator.values.contains(false));
                      },
                      hintText: S.current.enter_duration,
                      inputType: TextInputType.number,
                      suffix: SizedBox(
                        width: 100.w,
                        child: Center(
                          child: CustomDropDown(
                            listValue: listValueDuration,
                            onChange: (value) {
                              loanDurationType = int.parse(value['value']!);
                              _cubit.sinkIndex.add(int.parse(value['value']!));
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      S.current.repayment_curr,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        14.sp,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH4,
                    lastContainer(listValueToken, (value) {
                      repaymentAsset = value['label'];
                    }),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      S.current.recurring_interest,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        14.sp,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH4,
                    lastContainer(listValueInterest, (value) {
                      repaymentCycleType = int.parse(value['label']);
                    }),
                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget lastContainer(
    List<Map<String, dynamic>> listValue,
    Function(Map<String, dynamic>) onChange,
  ) {
    return Container(
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: Center(
        child: StreamBuilder<int>(
            stream: _cubit.streamIndex,
            initialData: 0,
            builder: (context, snapshot) {
              return CoolDropdown(
                resultTS: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w400,
                ),
                unselectedItemTS: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w400,
                ),
                selectedItemTS: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w400,
                ),
                dropdownItemReverse: true,
                dropdownBD: BoxDecoration(
                  color: AppTheme.getInstance().colorTextReset(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
                resultIconLeftGap: 0,
                resultMainAxis: MainAxisAlignment.center,
                dropdownItemMainAxis: MainAxisAlignment.center,
                resultBD: BoxDecoration(
                  color: AppTheme.getInstance().itemBtsColors(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
                selectedItemBD: const BoxDecoration(
                  color: Colors.transparent,
                ),
                defaultValue: listValue[snapshot.data!],
                gap: 10.h,
                resultIcon: Image.asset(ImageAssets.ic_expanded),
                isTriangle: false,
                dropdownHeight: 113.h,
                dropdownItemHeight: 54.h,
                dropdownItemAlign: Alignment.center,
                resultWidth: 340.w,
                dropdownWidth: 320.w,
                dropdownPadding: EdgeInsets.symmetric(horizontal: 16.w),
                resultAlign: Alignment.center,
                onChange: (value) {
                  onChange(value);
                },
                dropdownItemBottomGap: 0,
                dropdownItemTopGap: 0,
                dropdownList: listValue,
              );
            }),
      ),
    );
  }
}
