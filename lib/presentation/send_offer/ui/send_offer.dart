import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/nft_on_pawn.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/send_offer/bloc/send_offer_cubit.dart';
import 'package:Dfy/presentation/send_offer/ui/day_drop_down.dart';
import 'package:Dfy/presentation/send_offer/ui/token_drop_down.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/custom_form_validate.dart';
import 'package:Dfy/widgets/views/row_description.dart';
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
  String shortName = DFY;
  String repaymentAsset = contract_defy;

  String message = '';

  Future<void> getHexStringThenNav() async {
    final Map<String, dynamic> sendOfferRequest = {
      'bcOfferId': 0,
      'collateralId': widget.nftOnPawn.id ?? 0,
      'message': message,
      'duration': int.parse(duration),
      'durationType': loanDurationType,
      'interestRate': num.parse(interest),
      'loanAmount': num.parse(loanAmount),
      'repaymentCycleType': repaymentCycleType,
      'walletAddress': PrefsService.getCurrentBEWallet(),
      'repaymentToken': shortName,
      'supplyCurrency': widget.nftOnPawn.expectedCollateralSymbol ?? '',
      'liquidationThreshold': 0,
      'loanToValue': 0,
      'pawnShopPackageId': 0
    };
    await _cubit
        .getPawnHexString(
          nftCollateralId: widget.nftOnPawn.bcCollateralId.toString(),
          repaymentAsset: repaymentAsset,
          loanAmount: loanAmount,
          interest: interest,
          duration: duration,
          loanDurationType: loanDurationType,
          repaymentCycleType: repaymentCycleType,
          context: context,
        )
        .then(
          (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Approve(
                request: sendOfferRequest,
                nftOnPawn: widget.nftOnPawn,
                title: S.current.send_offer,
                needApprove: true,
                payValue: loanAmount,
                header: Column(
                  children: [
                    buildRowCustom(
                      title: S.current.from,
                      child: Text(
                        PrefsService.getCurrentBEWallet(),
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    buildRowCustom(
                      title: S.current.to,
                      child: Text(
                        (widget.nftOnPawn.walletAddress ?? '')
                            .formatAddressWalletConfirm(),
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    spaceH20,
                    line,
                    spaceH20,
                    buildRowCustom(
                      title: S.current.loan_amount,
                      child: Text(
                        loanAmount + shortName,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    buildRowCustom(
                      title: S.current.interest_rate,
                      child: Text(
                        '$interest%',
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    buildRowCustom(
                      title: S.current.duration,
                      child: Text(
                        '$duration ${repaymentCycleType == 0 ? S.current.month : S.current.week}',
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    buildRowCustom(
                      title: S.current.repayment_curr,
                      child: Text(
                        shortName,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    buildRowCustom(
                      title: S.current.recurring_interest,
                      child: Text(
                        repaymentCycleType == 0
                            ? S.current.month
                            : S.current.week,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                textActiveButton: S.current.approve,
                tokenAddress: repaymentAsset,
                hexString: value,
                typeApprove: TYPE_CONFIRM_BASE.SEND_OFFER,
              ),
            ),
          ),
        );
  }

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
    final List<Map<String, dynamic>> listValueToken =
        widget.nftOnPawn.expectedCollateralSymbol == DFY
            ? [
                {
                  'value': ID_MONTH.toString(),
                  'label': DFY,
                  'icon': SizedBox(
                    height: 20.h,
                    child: Image.asset(ImageAssets.getSymbolAsset(DFY)),
                  ),
                  'contract': contract_defy
                },
              ]
            : [
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
                  ),
                  'contract': widget.nftOnPawn.repaymentAsset
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
                        getHexStringThenNav();
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
                      maxLength: 100,
                      hintText: S.current.enter_msg,
                      validator: validator,
                      onChange: (value) {
                        _cubit.btnSink.add(!validator.values.contains(false));
                      },
                      validatorValue: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.current.invalid_message;
                        } else {
                          message = value!;
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
                      maxLength: 20,
                      validator: validator,
                      onChange: (value) {
                        _cubit.btnSink.add(!validator.values.contains(false));
                      },
                      validatorValue: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.current.invalid_amount;
                        } else if (!fiveDecimal.hasMatch(value!)) {
                          return S.current.invalid_amount;
                        } else {
                          loanAmount = value;
                        }
                        return null;
                      },
                      hintText: S.current.enter_loan_amount,
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
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
                      maxLength: 10,
                      validator: validator,
                      onChange: (value) {
                        _cubit.btnSink.add(!validator.values.contains(false));
                      },
                      validatorValue: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.current.invalid_interest_rate;
                        } else if (!twoDecimal.hasMatch(value!)) {
                          return S.current.invalid_interest_rate;
                        } else {
                          interest = value;
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
                      maxLength: 4,
                      validator: validator,
                      validatorValue: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.current.invalid_duration;
                        } else if (loanDurationType == ID_WEEK &&
                            int.parse(value!) > 5200) {
                          return S.current.invalid_duration_week;
                        } else if (loanDurationType == ID_MONTH &&
                            int.parse(value!) > 1200) {
                          return S.current.invalid_duration_month;
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
                        child: StreamBuilder<int>(
                          stream: _cubit.streamIndex,
                          initialData: 0,
                          builder: (context, snapshot) {
                            return Center(
                              child: CustomDropDown(
                                index: snapshot.data!,
                                listValue: listValueDuration,
                                onChange: (value) {
                                  loanDurationType = int.parse(value['value']!);
                                  _cubit.sinkIndex
                                      .add(int.parse(value['value']!));
                                },
                              ),
                            );
                          },
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
                    BigDropDown(
                      dropDownHeight:
                          widget.nftOnPawn.expectedCollateralSymbol == DFY
                              ? 56.h
                              : null,
                      listValue: listValueToken,
                      textValue: (value) {
                        shortName = value['label'];
                        repaymentAsset = value['contract'];
                      },
                      index: 0,
                    ),
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
                    StreamBuilder<int>(
                        stream: _cubit.streamIndex,
                        initialData: 0,
                        builder: (context, snapshot) {
                          return BigDropDown(
                            key: UniqueKey(),
                            listValue: listValueInterest,
                            textValue: (value) {
                              _cubit.sinkIndex.add(int.parse(value['value']!));
                              repaymentCycleType = int.parse(value['value']);
                            },
                            index: snapshot.data!,
                          );
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
}
