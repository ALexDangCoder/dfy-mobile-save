import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/bloc/lender_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/send_offfer/bloc/send_offer_loanrq_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/send_offfer/ui/confirm_reject_loan_request.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/cool_drop_down/cool_drop_down.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/text/text_from_field_group/form_group.dart';
import 'package:Dfy/widgets/text/text_from_field_group/text_field_validator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoanSendOffer extends StatefulWidget {
  const LoanSendOffer({Key? key, required this.isCryptoElseNft})
      : super(key: key);
  final bool isCryptoElseNft;

  @override
  _LoanSendOfferState createState() => _LoanSendOfferState();
}

class _LoanSendOfferState extends State<LoanSendOffer> {
  late SendOfferLoanrqCubit bloc;
  late TextEditingController textMessController;
  late TextEditingController textAmountController;
  late TextEditingController textLiquidationThresholdController;
  late TextEditingController textLoanController;
  late TextEditingController durationController;
  late TextEditingController textInterestController;
  String duration = S.current.weeks_pawn;
  late String symbolAmount;

  @override
  void initState() {
    super.initState();
    bloc = SendOfferLoanrqCubit();
    bloc.getTokenInf();
    symbolAmount = 'DFY';
    // bloc.getBalanceToken(
    //   ofAddress: PrefsService.getCurrentBEWallet(),
    //   tokenAddress: ImageAssets.getAddressToken(
    //     symbolAmount,
    //   ),
    // );
    // bloc.collateralAmount = widget.objCollateralDetail.estimatePrice ?? 0;
    textMessController = TextEditingController();
    textLiquidationThresholdController = TextEditingController();
    textAmountController = TextEditingController();
    textLoanController = TextEditingController();
    durationController = TextEditingController();
    textInterestController = TextEditingController();
    textInterestController.addListener(() {
      bloc.checkBtn();
    });
    durationController.addListener(() {
      bloc.checkBtn();
    });
    textLoanController.addListener(() {
      bloc.checkBtn();
    });
    textAmountController.addListener(() {
      bloc.checkBtn();
    });
    textLiquidationThresholdController.addListener(() {
      bloc.checkBtn();
    });
    textMessController.addListener(() {
      bloc.checkBtn();
    });
  }

  void closeKey() {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().blackColor(),
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 812.h,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                onTap: () {
                  closeKey();
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 64.h,
                      child: SizedBox(
                        height: 28.h,
                        width: 343.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                  height: 30.h,
                                  width: 30.w,
                                  child: Image.asset(ImageAssets.ic_back),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 6,
                              child: Align(
                                child: Text(
                                  S.current.send_offer,
                                  textAlign: TextAlign.center,
                                  style: titleText(
                                    color:
                                    AppTheme.getInstance().textThemeColor(),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  ImageAssets.ic_close,
                                  height: 30.h,
                                  width: 30.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: AppTheme.getInstance().divideColor(),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(
                            16.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              spaceH8,
                              fromMess(),
                              spaceH16,
                              fromLoanTo(),
                              spaceH16,
                              fromAmount(),
                              spaceH16,
                              fromLiquidationThreshold(),
                              spaceH16,
                              fromInterestRate(),
                              spaceH16,
                              formDuration(),
                              spaceH16,
                              formRepaymentToken(),
                              spaceH16,
                              formInterest(),
                              spaceH152,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: GestureDetector(
                  onTap: () async {
                    // if (bloc.checkBtn()) {
                    //   final NavigatorState navigator = Navigator.of(context);
                    //   await bloc.getCreateCryptoOfferDataHexString(
                    //     duration: bloc.textDuration.value,
                    //     collateralId: widget.objCollateralDetail.bcCollateralId
                    //         .toString(),
                    //     loanAmount: bloc.textAmount.value,
                    //     repaymentCycleType:
                    //     duration == S.current.weeks_pawn ? 0 : 1,
                    //     interest: bloc.textInterestRate.value,
                    //     liquidityThreshold: bloc.textLiquidationThreshold.value,
                    //     loanDurationType:
                    //     duration == S.current.weeks_pawn ? 0 : 1,
                    //     repaymentAssetAddress:
                    //     ImageAssets.getAddressToken(symbolAmount),
                    //   );
                    //   unawaited(
                    //     navigator.push(
                    //       MaterialPageRoute(
                    //         builder: (context) => Approve(
                    //           textActiveButton: S.current.send,
                    //           spender:
                    //           Get.find<AppConstants>().crypto_pawn_contract,
                    //           needApprove: true,
                    //           hexString: bloc.hexString,
                    //           payValue: bloc.textAmount.value,
                    //           tokenAddress:
                    //           Get.find<AppConstants>().contract_defy,
                    //           title: S.current.confirm_send_offer,
                    //           listDetail: [
                    //             DetailItemApproveModel(
                    //               title: '${S.current.message}: ',
                    //               value: bloc.textMess.value,
                    //             ),
                    //             DetailItemApproveModel(
                    //               title: '${S.current.interest_rate_pawn}: ',
                    //               value: '${bloc.textInterestRate.value} %APR',
                    //             ),
                    //             DetailItemApproveModel(
                    //               title: '${S.current.duration_pawn}: ',
                    //               value: '${bloc.textDuration.value} $duration',
                    //             ),
                    //             DetailItemApproveModel(
                    //               title: '${S.current.loan_amount}: ',
                    //               value:
                    //               '$symbolAmount ${bloc.textAmount.value}',
                    //               urlToken:
                    //               ImageAssets.getSymbolAsset(symbolAmount),
                    //             ),
                    //           ],
                    //           onErrorSign: (context) {},
                    //           onSuccessSign: (context, data) {
                    //             //Be
                    //             bloc.postSendOfferRequest(
                    //               loanAmount: bloc.textAmount.value,
                    //               collateralId:
                    //               widget.objCollateralDetail.id.toString(),
                    //               duration: bloc.textDuration.value,
                    //               supplyCurrency: symbolAmount,
                    //               repaymentToken: bloc.textToken.value,
                    //               message: bloc.textMess.value,
                    //               loanRequestId: '',
                    //               //todo
                    //               walletAddress:
                    //               PrefsService.getCurrentWalletCore(),
                    //               durationType: duration == S.current.weeks_pawn
                    //                   ? '0'
                    //                   : '1',
                    //               latestBlockchainTxn: data,
                    //               interestRate: bloc.textInterestRate.value,
                    //               liquidationThreshold:
                    //               bloc.textLiquidationThreshold.value,
                    //               loanToValue: bloc.textLoan.value,
                    //             );
                    //             showLoadSuccess(context).then((value) {
                    //               Navigator.of(context).popUntil((route) {
                    //                 return route.settings.name ==
                    //                     AppRouter.collateral_result;
                    //               });
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // }
                  },
                  child: StreamBuilder<bool>(
                    stream: bloc.isBtn,
                    builder: (context, snapshot) {
                      return Container(
                        color: AppTheme.getInstance().bgBtsColor(),
                        padding: EdgeInsets.only(
                          bottom: 38.h,
                          top: 6.h,
                        ),
                        child: ButtonGold(
                          isEnable: snapshot.data ?? false,
                          title: S.current.send_offer,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fromMess() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.message,
          style: textNormalCustom(
            null,
            16,
            FontWeight.w400,
          ),
          textAlign: TextAlign.start,
        ),
        spaceH4,
        Container(
          height: 64.h,
          padding: EdgeInsets.only(right: 15.w, left: 15.w),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().backgroundBTSColor(),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textMessController,
                  maxLength: 100,
                  onChanged: (value) {
                    bloc.funCheckMess(value);
                  },
                  cursorColor: AppTheme.getInstance().whiteColor(),
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                    counterText: '',
                    hintText: S.current.enter_message,
                    hintStyle: textNormal(
                      AppTheme.getInstance().whiteWithOpacityFireZero(),
                      16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              StreamBuilder(
                stream: bloc.textMess,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  return GestureDetector(
                    onTap: () {
                      bloc.textMess.add('');
                      textMessController.text = '';
                      bloc.isMess.add(true);
                      closeKey();
                    },
                    child: snapshot.data?.isNotEmpty ?? false
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
        spaceH4,
        StreamBuilder<bool>(
          stream: bloc.isMess,
          builder: (context, snapshot) {
            return snapshot.data ?? false
                ? Text(
              S.current.invalid_message,
              style: textNormalCustom(
                AppTheme.getInstance().redColor(),
                12,
                FontWeight.w400,
              ),
            )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget fromLoanTo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '',
            style: textNormalCustom(
              null,
              16,
              FontWeight.w400,
            ),
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Text(
                  S.current.loan_to_value,
                  style: textNormalCustom(
                    null,
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => InfoPopup(
                        name: S.current.loan_to_value,
                        content: S.current.mess_loan_to_value,
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 4.w,
                    ),
                    child: Image.asset(
                      ImageAssets.img_waning,
                      height: 20.w,
                      width: 20.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        spaceH4,
        Container(
          height: 64.h,
          padding: EdgeInsets.only(right: 15.w, left: 15.w),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().backgroundBTSColor(),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textLoanController,
                  maxLength: 50,
                  onChanged: (value) {
                    if (bloc.funValidateLoan(value)) {
                      double? totalAmount;
                      totalAmount =
                          bloc.collateralAmount * (double.parse(value) / 100);
                      textAmountController.text =
                          formatPricePawn.format(totalAmount);
                      bloc.funValidateAmount(textAmountController.text);
                    } else {
                      textAmountController.text = '';
                      bloc.funValidateAmount('');
                    }
                  },
                  cursorColor: AppTheme.getInstance().whiteColor(),
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                    counterText: '',
                    hintText: S.current.enter_loan_to_value,
                    hintStyle: textNormal(
                      AppTheme.getInstance().whiteWithOpacityFireZero(),
                      16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Text(
                '%',
                style: textNormalCustom(
                  null,
                  20,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        spaceH4,
        StreamBuilder<String>(
          stream: bloc.isLoan,
          builder: (context, snapshot) {
            return snapshot.data?.isNotEmpty ?? false
                ? Text(
              snapshot.data ?? '',
              style: textNormalCustom(
                AppTheme.getInstance().redColor(),
                12,
                FontWeight.w400,
              ),
            )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget fromAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.just_loan_amount,
          style: textNormalCustom(
            null,
            16,
            FontWeight.w400,
          ),
          textAlign: TextAlign.start,
        ),
        spaceH4,
        Container(
          height: 64.h,
          padding: EdgeInsets.only(right: 15.w, left: 15.w),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().backgroundBTSColor(),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textAmountController,
                  maxLength: 50,
                  onChanged: (value) {
                    if (bloc.funValidateAmount(value)) {
                      double? totalLoan;
                      totalLoan =
                          (double.parse(value) / bloc.collateralAmount) * 100;
                      textLoanController.text =
                          formatPricePawn.format(totalLoan);
                      bloc.funValidateLoan(textLoanController.text);
                    } else {
                      textLoanController.text = '';
                      bloc.funValidateLoan('');
                    }
                  },
                  cursorColor: AppTheme.getInstance().whiteColor(),
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                    counterText: '',
                    hintText: S.current.enter_loan_amount,
                    hintStyle: textNormal(
                      AppTheme.getInstance().whiteWithOpacityFireZero(),
                      16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '',
                  style: textNormalCustom(
                    null,
                    16,
                    FontWeight.w400,
                  ),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        margin: EdgeInsets.only(
                          right: 4.w,
                        ),
                        child: Image.network(
                          ImageAssets.getSymbolAsset(symbolAmount),
                          height: 20.h,
                          width: 20.w,
                          fit: BoxFit.fill,
                          errorBuilder: (
                              context,
                              error,
                              stackTrace,
                              ) =>
                              Container(
                                height: 20.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  color: AppTheme.getInstance().bgBtsColor(),
                                  shape: BoxShape.circle,
                                ),
                              ),
                        ),
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Text(
                        symbolAmount,
                        style: textNormalCustom(
                          null,
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        spaceH4,
        StreamBuilder<String>(
          stream: bloc.isAmount,
          builder: (context, snapshot) {
            return snapshot.data?.isNotEmpty ?? false
                ? Text(
              snapshot.data ?? '',
              style: textNormalCustom(
                AppTheme.getInstance().redColor(),
                12,
                FontWeight.w400,
              ),
            )
                : StreamBuilder<String>(
              stream: bloc.balanceWallet,
              builder: (context, snapshot) {
                return Text(
                  '$symbolAmount'
                      ' ${S.current.balance.toLowerCase()}:'
                      ' ${snapshot.data}',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteWithOpacitySevenZero(),
                    12,
                    FontWeight.w400,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget fromLiquidationThreshold() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '',
            style: textNormalCustom(
              null,
              16,
              FontWeight.w400,
            ),
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Text(
                  S.current.liquidation_threshold,
                  style: textNormalCustom(
                    null,
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => InfoPopup(
                        name: S.current.liquidation_threshold,
                        content: S.current.mess_liquidation_threshold,
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 4.w,
                    ),
                    child: Image.asset(
                      ImageAssets.img_waning,
                      height: 20.w,
                      width: 20.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        spaceH4,
        Container(
          height: 64.h,
          padding: EdgeInsets.only(right: 15.w, left: 15.w),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().backgroundBTSColor(),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textLiquidationThresholdController,
                  maxLength: 50,
                  onChanged: (value) {
                    bloc.funValidateLiquidationThreshold(value);
                  },
                  cursorColor: AppTheme.getInstance().whiteColor(),
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                    counterText: '',
                    hintText: S.current.enter_liquidation_threshold,
                    hintStyle: textNormal(
                      AppTheme.getInstance().whiteWithOpacityFireZero(),
                      16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Text(
                '%',
                style: textNormalCustom(
                  null,
                  20,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        spaceH4,
        StreamBuilder<String>(
          stream: bloc.isLiquidationThreshold,
          builder: (context, snapshot) {
            return snapshot.data?.isNotEmpty ?? false
                ? Text(
              snapshot.data ?? '',
              style: textNormalCustom(
                AppTheme.getInstance().redColor(),
                12,
                FontWeight.w400,
              ),
            )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget fromInterestRate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.interest_rate_apr,
          style: textNormalCustom(
            null,
            16,
            FontWeight.w400,
          ),
          textAlign: TextAlign.start,
        ),
        spaceH4,
        Container(
          height: 64.h,
          padding: EdgeInsets.only(right: 15.w, left: 15.w),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().backgroundBTSColor(),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textInterestController,
                  maxLength: 50,
                  onChanged: (value) {
                    bloc.funInterestRate(value);
                  },
                  cursorColor: AppTheme.getInstance().whiteColor(),
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                    counterText: '',
                    hintText: S.current.enter_interest_rate,
                    hintStyle: textNormal(
                      AppTheme.getInstance().whiteWithOpacityFireZero(),
                      16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Text(
                '%APR',
                style: textNormalCustom(
                  null,
                  16,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        spaceH4,
        StreamBuilder<String>(
          stream: bloc.isInterestRate,
          builder: (context, snapshot) {
            return snapshot.data?.isNotEmpty ?? false
                ? Text(
              snapshot.data ?? '',
              style: textNormalCustom(
                AppTheme.getInstance().redColor(),
                12,
                FontWeight.w400,
              ),
            )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget formDuration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.duration_pawn,
          style: textNormalCustom(
            null,
            16,
            FontWeight.w400,
          ),
        ),
        spaceH4,
        StreamBuilder<bool>(
          stream: bloc.chooseExisting,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            bool enable;
            if (snapshot.hasData) {
              enable = !(snapshot.data ?? false);
            } else {
              enable = true;
            }
            return Container(
              height: 64.h,
              padding: EdgeInsets.only(right: 15.w, left: 15.w),
              decoration: BoxDecoration(
                color: AppTheme.getInstance().backgroundBTSColor(),
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: TextFormField(
                      enabled: enable,
                      controller: durationController,
                      maxLength: 50,
                      onChanged: (value) {
                        bloc.enableButtonRequest(value);
                      },
                      cursorColor: AppTheme.getInstance().whiteColor(),
                      style: textNormal(
                        AppTheme.getInstance().whiteColor(),
                        16,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isCollapsed: true,
                        counterText: '',
                        hintText: S.current.duration_pawn,
                        hintStyle: textNormal(
                          AppTheme.getInstance().whiteWithOpacityFireZero(),
                          16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        dropdownColor:
                        AppTheme.getInstance().backgroundBTSColor(),
                        items: [
                          S.current.weeks_pawn,
                          S.current.months_pawn,
                        ].map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  item,
                                  style: textNormal(
                                    null,
                                    16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (enable) {
                            setState(() {
                              duration = newValue!;
                              if (duration == S.current.weeks_pawn) {
                                bloc.textRecurringInterest
                                    .add(S.current.weekly_pawn);
                              } else {
                                bloc.textRecurringInterest
                                    .add(S.current.monthly_pawn);
                              }
                              bloc.enableButtonRequest(
                                bloc.textDuration.value,
                              );
                            });
                          }
                        },
                        value: duration,
                        icon: Image.asset(
                          ImageAssets.ic_line_down,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        StreamBuilder<String>(
          stream: bloc.isDuration,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return SizedBox(
              child: snapshot.data?.isNotEmpty ?? false
                  ? Text(
                snapshot.data ?? '',
                style: textNormal(
                  AppTheme.getInstance().redColor(),
                  12,
                ),
              )
                  : const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }

  Widget formRepaymentToken() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.repayment_token,
          style: textNormalCustom(
            null,
            16,
            FontWeight.w400,
          ),
        ),
        spaceH4,
        Container(
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
              child: DropdownButton2<String>(
                buttonDecoration: BoxDecoration(
                  color: AppTheme.getInstance().backgroundBTSColor(),
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                items: bloc.listToken.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: FadeInImage.assetNetwork(
                            placeholder: ImageAssets.symbol,
                            image: ImageAssets.getSymbolAsset(value),
                          ),
                        ),
                        spaceW5,
                        Text(
                          value,
                          style: textNormal(
                            Colors.white.withOpacity(0.5),
                            16,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    bloc.textToken.add(newValue ?? '');
                  });
                },
                dropdownMaxHeight: 100.h,
                dropdownWidth: 343.w,
                dropdownDecoration: BoxDecoration(
                  color: AppTheme.getInstance().backgroundBTSColor(),
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                scrollbarThickness: 0,
                scrollbarAlwaysShow: false,
                offset: Offset(-16.w, 0),
                value: bloc.textToken.value,
                icon: Image.asset(
                  ImageAssets.ic_line_down,
                  height: 24.h,
                  width: 24.w,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget formInterest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.recurring_interest_pawn,
          style: textNormalCustom(
            null,
            16,
            FontWeight.w400,
          ),
          textAlign: TextAlign.start,
        ),
        spaceH4,
        Container(
          height: 64.h,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 15.w, left: 15.w),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().backgroundBTSColor(),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: StreamBuilder<String>(
            stream: bloc.textRecurringInterest,
            builder: (context, snapshot) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  snapshot.data ?? '',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteWithOpacityFireZero(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
