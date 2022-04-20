import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/create_new_loan_package/bloc/create_new_loan_package_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/create_new_loan_package/ui/collateral_select_create.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/create_new_loan_package/ui/confirm_new_loan_package.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class CreateNewLoanPackage extends StatefulWidget {
  const CreateNewLoanPackage({
    Key? key,
    required this.pawnShopId,
  }) : super(key: key);
  final String pawnShopId;

  @override
  _CreateNewLoanPackageState createState() => _CreateNewLoanPackageState();
}

class _CreateNewLoanPackageState extends State<CreateNewLoanPackage> {
  late TextEditingController _txtMess;
  late TextEditingController _txtLoanAmountMin;
  late TextEditingController _txtLoanAmountMax;
  late TextEditingController _txtInterestRate;
  late TextEditingController _txtDuration;
  late TextEditingController _txtLoanToValue;
  late TextEditingController _txtLTVLiquidThreshold;
  late CreateNewLoanPackageCubit cubit;
  late Tuple2<String, String> typeCreate;
  late TokenInf loanToken;
  late TokenInf loanRepaymentToken;

  // late String repaymentToken;
  late String duration;

  @override
  void initState() {
    super.initState();
    _txtMess = TextEditingController();
    _txtLoanAmountMin = TextEditingController();
    _txtLoanAmountMax = TextEditingController();
    _txtInterestRate = TextEditingController();
    _txtDuration = TextEditingController();
    _txtLoanToValue = TextEditingController();
    _txtLTVLiquidThreshold = TextEditingController();
    cubit = CreateNewLoanPackageCubit();
    cubit.getListTokens();
    duration = S.current.months_pawn;
    typeCreate = cubit.typeCreate[1];
    loanToken = cubit.listToken[0];
    loanRepaymentToken = cubit.listRepaymentToken[0];
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
                                  'New loan package',
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
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                          ),
                          child: Column(
                            children: [
                              spaceH22,
                              _textTitle(title: S.current.type),
                              _formType(),
                              spaceH16,
                              _textTitle(title: S.current.message),
                              _formWithOutDropDown(
                                controller: _txtMess,
                                onChange: (value) {
                                  cubit.validateMess(value);
                                  cubit.validateAll();
                                },
                                hintText: 'Enter message',
                                streamValidateText: cubit.txtWarningMess.stream,
                              ),
                              _textTitle(
                                title: S.current.loan_token,
                              ),
                              _formLoanToken(),
                              spaceH16,
                              _textTitle(title: S.current.loan_amount),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _formWithOutDropDown(
                                      controller: _txtLoanAmountMin,
                                      txtInputType:
                                          const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                      onChange: (value) {
                                        cubit.validateAmount(
                                          value,
                                          _txtLoanAmountMax.text,
                                        );
                                        cubit.validateAmount(
                                          _txtLoanAmountMax.text,
                                          value,
                                          isMinLoan: false,
                                        );
                                        cubit.validateAll();
                                      },
                                      hintText: 'Min',
                                      streamValidateText:
                                          cubit.txtWarningLoanMinAmount.stream,
                                    ),
                                  ),
                                  spaceW16,
                                  Expanded(
                                    child: _formWithOutDropDown(
                                      controller: _txtLoanAmountMax,
                                      txtInputType:
                                          const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                      onChange: (value) {
                                        cubit.validateAmount(
                                          value,
                                          _txtLoanAmountMin.text,
                                          isMinLoan: false,
                                        );
                                        cubit.validateAmount(
                                            _txtLoanAmountMin.text, value);
                                        cubit.validateAll();
                                      },
                                      hintText: 'Max',
                                      streamValidateText:
                                          cubit.txtWarningLoanMaxAmount.stream,
                                    ),
                                  )
                                ],
                              ),
                              // spaceH16,
                              _textTitle(title: S.current.collateral),
                              CollateralSelectCreate(
                                cubit: cubit,
                                listToken: cubit.listCollateralToken,
                              ),
                              spaceH16,
                              _textTitle(title: S.current.interest_rate),
                              _formWithOutDropDown(
                                controller: _txtInterestRate,
                                onChange: (value) {
                                  cubit.validateInterestRate(value);
                                  cubit.validateAll();
                                },
                                hintText: 'Enter interest rate',
                                txtInputType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                streamValidateText:
                                    cubit.txtWarningInterestRate.stream,
                                suffixIcon: SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '%',
                                      style: textNormalCustom(
                                        AppTheme.getInstance().whiteColor(),
                                        16,
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              spaceH16,
                              _textTitle(title: S.current.repayment_token),
                              _formLoanRepaymentToken(),
                              spaceH16,
                              _textTitle(
                                title: S.current.duration,
                              ),
                              _formWithOutDropDown(
                                  controller: _txtDuration,
                                  onChange: (value) {
                                    if (duration == S.current.months_pawn) {
                                      cubit.validateDuration(
                                          isMonthly: true, value: value);
                                    } else {
                                      cubit.validateDuration(
                                          isMonthly: false, value: value);
                                    }
                                    cubit.validateAll();
                                  },
                                  hintText: 'Enter duration',
                                  txtInputType: TextInputType.number,
                                  streamValidateText:
                                      cubit.txtWarningDuration.stream,
                                  suffixIcon: SizedBox(
                                    width: 100.w,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.r)),
                                          dropdownColor: AppTheme.getInstance()
                                              .backgroundBTSColor(),
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
                                            if (newValue ==
                                                S.current.weeks_pawn) {
                                              cubit.valueRecurringInterest.sink
                                                  .add('weekly');
                                              cubit.validateDuration(
                                                  isMonthly: false,
                                                  value: _txtDuration.text);
                                              cubit.validateAll();
                                            } else {
                                              cubit.valueRecurringInterest.sink
                                                  .add('monthly');
                                              cubit.validateDuration(
                                                  isMonthly: true,
                                                  value: _txtDuration.text);
                                              cubit.validateAll();
                                            }
                                            setState(() {
                                              duration = newValue!;
                                            });
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
                                  )),
                              _textTitle(
                                title: S.current.recurring_interest,
                              ),
                              _recurringInterest(),
                              spaceH16,
                              _textTitle(
                                  title: S.current.loan_to_value,
                                  isHaveIcWarning: true,
                                  callBack: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => InfoPopup(
                                        name: S.current.loan_to_value,
                                        content: S.current.mess_loan_to_value,
                                      ),
                                    );
                                  }),
                              _formWithOutDropDown(
                                controller: _txtLoanToValue,
                                onChange: (value) {
                                  cubit.validateLoanToVlFeatLTVThresHold(
                                    value,
                                    _txtLTVLiquidThreshold.text,
                                  );
                                  cubit.validateAll();
                                  cubit.validateLoanToVlFeatLTVThresHold(
                                    _txtLTVLiquidThreshold.text,
                                    value,
                                    isLoanToVL: false,
                                  );
                                  cubit.validateAll();
                                },
                                hintText: 'Enter loan to value',
                                txtInputType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                streamValidateText:
                                    cubit.txtWarningLoanToValue.stream,
                                suffixIcon: SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '%',
                                      style: textNormalCustom(
                                        AppTheme.getInstance().whiteColor(),
                                        16,
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              _textTitle(
                                  title: S.current.ltv_liquid_thres,
                                  isHaveIcWarning: true,
                                  callBack: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => InfoPopup(
                                        name: S.current.liquidation_threshold,
                                        content: S
                                            .current.mess_liquidation_threshold,
                                      ),
                                    );
                                  }),
                              _formWithOutDropDown(
                                controller: _txtLTVLiquidThreshold,
                                onChange: (value) {
                                  cubit.validateLoanToVlFeatLTVThresHold(
                                    value,
                                    _txtLoanToValue.text,
                                    isLoanToVL: false,
                                  );
                                  cubit.validateAll();
                                  cubit.validateLoanToVlFeatLTVThresHold(
                                    _txtLoanToValue.text,
                                    value,
                                  );
                                  cubit.validateAll();
                                },
                                hintText: 'Enter LTV Liquidation threshold',
                                txtInputType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                streamValidateText:
                                    cubit.txtWarningLTVThresHold.stream,
                                suffixIcon: SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '%',
                                      style: textNormalCustom(
                                        AppTheme.getInstance().whiteColor(),
                                        16,
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                child: StreamBuilder<bool>(
                    stream: cubit.nextBtnBHVSJ,
                    builder: (context, snapshot) {
                      return GestureDetector(
                        onTap: () async {
                          if (snapshot.data ?? false) {
                            // goTo(
                            //   context,
                            //   ConfirmNewLoanPackage(),
                            // );
                            final hexString =
                                await Web3Utils().getCreatePackageData(
                              packageType: int.parse(
                                  CreateNewLoanPackageCubit.SEMI_AUTO),
                              loanTokenAddress: ImageAssets.getAddressToken(
                                cubit.loanPackageRequest.loanTokens?.first ??
                                    '',
                              ),
                              loanAmountRange: [
                                (cubit.loanPackageRequest.allowedLoanMin ??
                                    '1'),
                                (cubit.loanPackageRequest.allowedLoanMax ?? '2')
                              ],
                              collateralAcceptance:
                                  cubit.getAddressCollateralAcceptance(),
                              interest: cubit.loanPackageRequest.interest ?? '',
                              durationType:
                                  cubit.loanPackageRequest.durationQtyType ??
                                      '0',
                              durationRange: [
                                cubit.loanPackageRequest.durationQtyMin ?? '1',
                                cubit.loanPackageRequest.durationQtyMax ?? '2'
                              ],
                              repaymentAssetAddress:
                                  ImageAssets.getAddressToken((cubit
                                          .loanPackageRequest
                                          .repaymentTokens
                                          ?.first ??
                                      '')),
                              repaymentCycleType: int.parse(
                                  cubit.loanPackageRequest.durationQtyType ??
                                      '0'),
                              loanToValue:
                                  cubit.loanPackageRequest.loanToValue ?? '1',
                              loanToValueLiquidationThreshold: cubit
                                      .loanPackageRequest
                                      .liquidationThreshold ??
                                  '10',
                            );

                            goTo(
                                context,
                                Approve(
                                  payValue:
                                      cubit.loanPackageRequest.allowedLoanMax,
                                  needApprove: true,
                                  tokenAddress: ImageAssets.getAddressToken(
                                      cubit.loanPackageRequest.loanTokens
                                              ?.first ??
                                          'DFY'),
                                  title: 'Confirm new loan package',
                                  spender: Get.find<AppConstants>()
                                      .crypto_pawn_contract,
                                  textActiveButton: 'Create',
                                  hexString: hexString,
                                  header: Column(
                                    children: [
                                      _rowItem(
                                          title: 'Type',
                                          description: typeCreate.item1),
                                      spaceH16,
                                      _rowItem(
                                        title: 'Message',
                                        description: _txtMess.text,
                                      ),
                                      spaceH16,
                                      _rowItem(
                                        title: 'Loan amount',
                                        description: '',
                                        isCustomDes: true,
                                        widgetCustom: Row(
                                          children: [
                                            SizedBox(
                                              height: 20.h,
                                              width: 20.w,
                                              child: Image.network(
                                                  ImageAssets.getUrlToken(
                                                      loanToken.symbol ??
                                                          'DFY')),
                                            ),
                                            spaceW5,
                                            Text(
                                              '${formatPrice.format(double.parse(cubit.loanPackageRequest.allowedLoanMin ?? '1'))} - ${formatPrice.format(double.parse(cubit.loanPackageRequest.allowedLoanMax ?? '2'))} ${loanToken.symbol ?? 'DFY'}',
                                              style: textNormalCustom(
                                                AppTheme.getInstance()
                                                    .whiteColor(),
                                                16,
                                                FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      spaceH16,
                                      _collateralTokens(),
                                      spaceH16,
                                      _rowItem(
                                          title: 'Interest rate (%APR)',
                                          description:
                                              '${cubit.loanPackageRequest.interest}%'),
                                      spaceH16,
                                      _rowItem(
                                          title: 'Repayment token',
                                          description: '',
                                          isCustomDes: true,
                                          widgetCustom: Row(
                                            children: [
                                              SizedBox(
                                                width: 20.w,
                                                height: 20.h,
                                                child: Image.network(
                                                    ImageAssets.getUrlToken(
                                                        loanRepaymentToken
                                                                .symbol ??
                                                            'DFY')),
                                              ),
                                              spaceW5,
                                              Text(
                                                loanRepaymentToken.symbol ??
                                                    'DFY',
                                                style: textNormalCustom(
                                                  AppTheme.getInstance()
                                                      .whiteColor(),
                                                  16,
                                                  FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          )),
                                      spaceH16,
                                      _rowItem(
                                          title: 'Duration',
                                          description:
                                              '${cubit.loanPackageRequest.durationQtyMin}-${cubit.loanPackageRequest.durationQtyMax} ${cubit.getMonthOrWeek(cubit.loanPackageRequest.durationQtyType)}'),
                                      spaceH16,
                                      _rowItem(
                                          title: 'Loan to value',
                                          description:
                                              '${cubit.loanPackageRequest.loanToValue ?? '0'}%'),
                                      spaceH16,
                                      _rowItem(
                                          title: 'LTV Liquidation threshold',
                                          description:
                                              '${cubit.loanPackageRequest.liquidationThreshold ?? '0'}%')
                                    ],
                                  ),
                                  onSuccessSign: (context, data) async {
                                    Navigator.pop(context);
                                    await cubit.postInfoNewLoanPackageToBe(
                                      pawnShopId: widget.pawnShopId,
                                      txId: data,
                                    );
                                    await showLoadSuccess(context).then(
                                      (value) {
                                        Navigator.pop(context, true);
                                      },
                                    );
                                    Navigator.popUntil(
                                        context,
                                        (route) =>
                                            route.settings.name ==
                                            AppRouter.manage_loan_package);
                                    // await onRefresh();
                                  },
                                  onErrorSign: (context) async {
                                    final nav = Navigator.of(context);
                                    nav.pop();
                                    await showLoadFail(context);
                                  },
                                ));
                          } else {
                            //nothing
                          }
                        },
                        child: Container(
                          color: AppTheme.getInstance().bgBtsColor(),
                          padding: EdgeInsets.only(
                            bottom: 38.h,
                            top: 6.h,
                          ),
                          child: ButtonGold(
                            isEnable: snapshot.data ?? false,
                            title: 'Create new',
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textTitle({
    required String title,
    bool? isHaveIcWarning = false,
    Function()? callBack,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
            spaceW8,
            if (isHaveIcWarning ?? false)
              InkWell(
                onTap: callBack,
                child: SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: Image.asset(
                    ImageAssets.ic_about_2,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(),
          ],
        ),
        spaceH4,
      ],
    );
  }

  Widget _recurringInterest() {
    return StreamBuilder<String>(
        initialData: cubit.recurringInterest[0],
        stream: cubit.valueRecurringInterest.stream,
        builder: (context, snapshot) {
          return Container(
            height: 64.h,
            padding: EdgeInsets.only(right: 15.w, left: 15.w),
            decoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  snapshot.data ?? '',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                )),
          );
        });
  }

  Widget _formType() {
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
          child: DropdownButton2<Tuple2<String, String>>(
            buttonDecoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            items: cubit.typeCreate.map((Tuple2<String, String> value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value.item1,
                  style: textNormal(
                    Colors.white,
                    16,
                  ),
                ),
              );
            }).toList(),
            onChanged: (Tuple2<String, String>? newValue) {
              setState(() {
                typeCreate = newValue!;
                cubit.loanPackageRequest.type = typeCreate.item2;
              });
            },
            dropdownMaxHeight: 110.h,
            dropdownWidth: 343.w,
            dropdownDecoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            scrollbarThickness: 0,
            scrollbarAlwaysShow: false,
            offset: Offset(-16.w, 0),
            value: typeCreate,
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

  Widget _formWithOutDropDown({
    required TextEditingController controller,
    required Function(String value) onChange,
    required String hintText,
    required Stream<String> streamValidateText,
    TextInputType? txtInputType,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 64.h,
          padding: EdgeInsets.only(right: 15.w, left: 15.w),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().backgroundBTSColor(),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              keyboardType: txtInputType,
              controller: controller,
              maxLength: 100,
              onChanged: (value) {
                onChange(value);
              },
              cursorColor: AppTheme.getInstance().whiteColor(),
              style: textNormal(
                AppTheme.getInstance().whiteColor(),
                16,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                counterText: '',
                hintText: hintText,
                hintStyle: textNormal(
                  AppTheme.getInstance().whiteWithOpacityFireZero(),
                  16,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        spaceH4,
        StreamBuilder<String>(
          stream: streamValidateText,
          builder: (context, snapshot) {
            return Text(
              snapshot.data ?? '',
              style: textNormalCustom(
                AppTheme.getInstance().redColor(),
                12,
                FontWeight.w400,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _formLoanToken() {
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
          child: DropdownButton2<TokenInf>(
            buttonDecoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            items: cubit.listToken.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: FadeInImage.assetNetwork(
                        placeholder: ImageAssets.symbol,
                        image: ImageAssets.getSymbolAsset(value.symbol ?? ''),
                      ),
                    ),
                    spaceW5,
                    Text(
                      value.symbol ?? '',
                      style: textNormal(
                        Colors.white,
                        16,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              if(newValue == loanToken) {

              } else {
                setState(() {
                  loanToken = newValue!;
                  cubit.loanPackageRequest.loanTokens = [loanToken.symbol ?? ''];
                  cubit.changeListRepaymentToken(value: newValue);
                });
              }
            },
            dropdownMaxHeight: 200.h,
            dropdownWidth: 343.w,
            dropdownDecoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            scrollbarThickness: 0,
            scrollbarAlwaysShow: false,
            offset: Offset(-16.w, 0),
            value: loanToken,
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

  Widget _formLoanRepaymentToken() {
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
          child: DropdownButton2<TokenInf>(
            buttonDecoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            items: cubit.listRepaymentToken.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: FadeInImage.assetNetwork(
                        placeholder: ImageAssets.symbol,
                        image: ImageAssets.getSymbolAsset(value.symbol ?? ''),
                      ),
                    ),
                    spaceW5,
                    Text(
                      value.symbol ?? '',
                      style: textNormal(
                        Colors.white,
                        16,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue == loanRepaymentToken) {

              } else {
                setState(() {
                  loanRepaymentToken = newValue!;
                  cubit.loanPackageRequest.repaymentTokens = [
                    loanRepaymentToken.symbol ?? ''
                  ];
                  cubit.validateAll();
                });
              }
            },
            dropdownMaxHeight: 200.h,
            dropdownWidth: 343.w,
            dropdownDecoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            scrollbarThickness: 0,
            scrollbarAlwaysShow: false,
            offset: Offset(-16.w, 0),
            value: loanRepaymentToken,
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

  ///UI FOR CONFIRM NEW LOAN PACKAGE
  Row _collateralTokens() {
    return _rowItem(
      title: 'Collateral',
      description: '',
      isCustomDes: true,
      widgetCustom:
          ((cubit.loanPackageRequest.collateralAcceptances ?? []).length <= 5)
              ? SizedBox(
                  height: 20.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        (cubit.loanPackageRequest.collateralAcceptances ?? [])
                            .length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: Image.network(
                              ImageAssets.getUrlToken(
                                (cubit.loanPackageRequest
                                        .collateralAcceptances ??
                                    [])[index],
                              ),
                            ),
                          ),
                          spaceW5,
                        ],
                      );
                    },
                  ),
                )
              : SizedBox(
                  height: 20.h,
                  child: Row(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: Image.network(
                                  ImageAssets.getUrlToken(
                                    (cubit.loanPackageRequest
                                            .collateralAcceptances ??
                                        [])[index],
                                  ),
                                ),
                              ),
                              spaceW5,
                            ],
                          );
                        },
                      ),
                      Text(
                        '& ${(cubit.loanPackageRequest.collateralAcceptances ?? []).length - 5} mores',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          16,
                          FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
    );
  }

  Row _rowItem({
    required String title,
    required String description,
    bool? isCustomDes = false,
    Widget? widgetCustom,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title.withColon(),
            style: textNormalCustom(
              AppTheme.getInstance().pawnItemGray(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        if (isCustomDes ?? false)
          Expanded(flex: 6, child: widgetCustom ?? Container())
        else
          Expanded(
            flex: 6,
            child: Text(
              description,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
          )
      ],
    );
  }
}
