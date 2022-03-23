import 'dart:async';

import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/create_new_collateral/bloc/create_new_collateral_bloc.dart';
import 'package:Dfy/presentation/pawn/create_new_collateral/bloc/create_new_collateral_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateNewCollateral extends StatefulWidget {
  const CreateNewCollateral({Key? key}) : super(key: key);

  @override
  _CreateNewCollateralState createState() => _CreateNewCollateralState();
}

class _CreateNewCollateralState extends State<CreateNewCollateral> {
  late TextEditingController collateralAmount;
  late TextEditingController messageController;
  late TextEditingController durationController;
  late CreateNewCollateralBloc bloc;
  String duration = S.current.weeks_pawn;

  @override
  void initState() {
    super.initState();
    collateralAmount = TextEditingController();
    messageController = TextEditingController();
    durationController = TextEditingController();
    bloc = CreateNewCollateralBloc();
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            closeKey();
          },
          child: Stack(
            children: [
              Container(
                height: 764.h,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().bgBtsColor(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.h),
                    topRight: Radius.circular(30.h),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 16.w,
                          ),
                          width: 24.w,
                          height: 24.h,
                        ),
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            S.current.create_new_collateral,
                            style: textNormalCustom(
                              null,
                              20.sp,
                              FontWeight.w700,
                            ).copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 16.w),
                            width: 24.w,
                            height: 24.h,
                            child: Image.asset(ImageAssets.ic_close),
                          ),
                        ),
                      ],
                    ),
                    spaceH20,
                    line,
                    spaceH24,
                    BlocBuilder<CreateNewCollateralBloc,
                        CreateNewCollateralState>(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state is CreateNewCollateralSuccess) {
                          return Container(
                            padding: EdgeInsets.only(
                              right: 16.w,
                              left: 16.w,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                formCollateralAmount(),
                                spaceH16,
                                fromMess(),
                                spaceH16,
                                formDuration(),
                                spaceH16,
                                fromLoanTo(),
                                spaceH20,
                                checkBoxFrom(),
                                spaceH20,
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: 100.h,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 38,
                child: Container(
                  color: AppTheme.getInstance().bgBtsColor(),
                  child: StreamBuilder<bool>(
                    stream: bloc.isCheckBtn,
                    builder: (context, snapshot) {
                      return GestureDetector(
                        onTap: () async {
                          if (snapshot.data ?? false) {
                            final NavigatorState navigator =
                                Navigator.of(context);
                            await bloc.getCreateCryptoCollateralData(
                              loanAsset: ImageAssets.getAddressToken(
                                bloc.textToken.value,
                              ),
                              expectedDurationType:
                                  bloc.textRecurringInterest.value ==
                                          S.current.weeks_pawn
                                      ? WEEK
                                      : MONTH,
                              expectedDurationQty: bloc.textDuration.value,
                              amount: bloc.amountCollateral.value,
                              collateralAddress: ImageAssets.getAddressToken(
                                bloc.item.nameShortToken,
                              ),
                              packageId: '-1',
                            ); //todo packageId
                            unawaited(
                              navigator.push(
                                MaterialPageRoute(
                                  builder: (context) => Approve(
                                    textActiveButton:
                                        S.current.confirm_new_collateral,
                                    spender: Get.find<AppConstants>()
                                        .crypto_pawn_contract,
                                    needApprove: true,
                                    hexString: bloc.hexString,
                                    payValue: bloc.amountCollateral.value,
                                    tokenAddress:
                                        Get.find<AppConstants>().contract_defy,
                                    title: S.current.confirm_send_offer,
                                    listDetail: [
                                      DetailItemApproveModel(
                                        title: '${S.current.message}: ',
                                        value: bloc.textMess.value,
                                      ),
                                      DetailItemApproveModel(
                                        title: '${S.current.collateral}: ',
                                        value: '${bloc.amountCollateral.value} '
                                            '${bloc.item.nameShortToken}',
                                        urlToken: ImageAssets.getSymbolAsset(
                                          bloc.item.nameShortToken,
                                        ),
                                      ),
                                      DetailItemApproveModel(
                                        title: '${S.current.loan_token}: ',
                                        value: bloc.textToken.value,
                                        urlToken: ImageAssets.getSymbolAsset(
                                          bloc.textToken.value,
                                        ),
                                      ),
                                      DetailItemApproveModel(
                                        title: '${S.current.duration_pawn}: ',
                                        value: '${bloc.textDuration.value} '
                                            '${bloc.textRecurringInterest.value}',
                                      ),
                                    ],
                                    onErrorSign: (context) {},
                                    onSuccessSign: (context, data) {
                                      bloc.postCreateNewCollateral(
                                        expectedLoanDurationType:
                                            bloc.textRecurringInterest.value ==
                                                    S.current.weeks_pawn
                                                ? WEEK.toString()
                                                : MONTH.toString(),
                                        expectedLoanDurationTime:
                                            bloc.textDuration.toString(),
                                        description: bloc.textMess.value,
                                        walletAddress:
                                            PrefsService.getCurrentWalletCore(),
                                        status: 1.toString(), //todo status
                                        amount: bloc.amountCollateral.value,
                                        supplyCurrency: bloc.textToken.value,
                                        collateral: bloc.item.nameShortToken,
                                        txid: data,
                                      );
                                      showLoadSuccess(context).then((value) {
                                        Navigator.of(context).popUntil((route) {
                                          return route.settings.name ==
                                              AppRouter.collateral_list_myacc;
                                        });
                                      });
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          color: AppTheme.getInstance().bgBtsColor(),
                          child: ButtonGold(
                            isEnable: snapshot.data ?? false,
                            title: S.current.book_appointment,
                          ),
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

  Widget checkBoxFrom() {
    return RichText(
      text: TextSpan(
        text: '',
        style: textNormalCustom(
          AppTheme.getInstance().whiteColor(),
          16,
          FontWeight.w400,
        ),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: StreamBuilder<bool>(
              initialData: true,
              stream: bloc.isCheckBox,
              builder: (context, snapshot) {
                return SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: Transform.scale(
                    scale: 1.34.sp,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      fillColor: MaterialStateProperty.all(
                        AppTheme.getInstance().fillColor(),
                      ),
                      activeColor: AppTheme.getInstance().activeColor(),
                      // checkColor: const Colors,
                      onChanged: (value) {
                        bloc.isCheckBox.sink.add(value ?? false);
                        bloc.checkButton();
                      },
                      value: snapshot.data ?? false,
                    ),
                  ),
                );
              },
            ),
          ),
          WidgetSpan(
            child: spaceW16,
          ),
          TextSpan(
            text: S.current.login_to_receive_email_notification,
          ),
        ],
      ),
    );
  }

  Widget formCollateralAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.collateral_amount,
          style: textNormalCustom(null, 16, FontWeight.w400),
        ),
        spaceH4,
        StreamBuilder<bool>(
          stream: bloc.chooseExisting,
          builder: (context, snapshot) {
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
                    flex: 2,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,5}'),
                        ),
                      ],
                      enabled: enable,
                      controller: collateralAmount,
                      maxLength: 50,
                      onChanged: (value) {
                        bloc.validateAmount(value);
                        bloc.checkButton();
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
                        hintText: S.current.enter_amount,
                        hintStyle: textNormal(
                          Colors.white.withOpacity(0.5),
                          16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      // Visibility(
                      //   visible: enable,
                      //   child: InkWell(
                      //     onTap: () {
                      //       collateralAmount.text = bloc
                      //           .getMax(bloc.item.nameShortToken)
                      //           .replaceAll(',', '');
                      //       bloc.errorCollateral.add('');
                      //       bloc.validateAmount(collateralAmount.text);
                      //     },
                      //     child: Text(
                      //       S.current.max,
                      //       style: textNormalCustom(
                      //         fillYellowColor,
                      //         16,
                      //         FontWeight.w400,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // spaceW10,
                      DropdownButtonHideUnderline(
                        child: DropdownButton<ModelToken>(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                          dropdownColor:
                              AppTheme.getInstance().backgroundBTSColor(),
                          items:
                              bloc.listTokenCollateral.map((ModelToken model) {
                            return DropdownMenuItem(
                              value: model,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.w,
                                    height: 20.h,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: ImageAssets.symbol,
                                      image: model.iconToken,
                                    ),
                                  ),
                                  spaceW5,
                                  Text(
                                    model.nameShortToken,
                                    style: textNormal(
                                      Colors.white.withOpacity(0.5),
                                      16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (ModelToken? newValue) {
                            if (enable) {
                              setState(() {
                                bloc.item = newValue!;
                                bloc.validateAmount(collateralAmount.text);
                              });
                            }
                          },
                          value: bloc.item,
                          icon: Image.asset(
                            ImageAssets.ic_line_down,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        StreamBuilder<String>(
          stream: bloc.errorCollateral,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return SizedBox(
              child: snapshot.data?.isNotEmpty ?? false
                  ? Text(
                      snapshot.data ?? '',
                      style: textNormal(
                        Colors.red,
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
                  controller: messageController,
                  maxLength: 100,
                  onChanged: (value) {
                    bloc.funCheckMess(value);
                    bloc.checkButton();
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
                      messageController.text = '';
                      bloc.isMess.add(true);
                      bloc.checkButton();
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
                        bloc.checkButton();
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
                              bloc.textRecurringInterest.add(duration);
                              bloc.enableButtonRequest(
                                durationController.text,
                              );
                              bloc.checkButton();
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

  Widget fromLoanTo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.loan_token,
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
                            AppTheme.getInstance().whiteColor(),
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
}
