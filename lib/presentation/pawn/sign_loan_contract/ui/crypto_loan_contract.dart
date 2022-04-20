import 'dart:async';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/pawn/crypto_collateral.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/presentation/pawn/select_crypto_collateral/ui/select_crypto.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/check_tab_bar.dart';
import 'package:Dfy/presentation/pawn/sign_loan_contract/bloc/sign_loan_contract_cubit.dart';
import 'package:Dfy/presentation/pawn/sign_loan_contract/ui/sign_loan_contract.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CryptoLoanContract extends StatefulWidget {
  const CryptoLoanContract({
    Key? key,
    required this.cubit,
    required this.pawnshopPackage,
  }) : super(key: key);

  final SignLoanContractCubit cubit;
  final PawnshopPackage pawnshopPackage;

  @override
  _CryptoLoanContractState createState() => _CryptoLoanContractState();
}

class _CryptoLoanContractState extends State<CryptoLoanContract> {
  late TextEditingController collateralAmount = TextEditingController();
  late TextEditingController message = TextEditingController();
  late TextEditingController durationController = TextEditingController();
  late ModelToken item;
  late LoanToken loanToken;
  late String duration;
  bool checkEmail = false;
  String txhChoseCollateral = '';
  String bcCollateralId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.cubit.listTokenCollateral.isNotEmpty) {
      item = widget.cubit.collateralTokenCached ??
          widget.cubit.listTokenCollateral[0];
    } else {
      item = ModelToken.init();
    }
    checkEmail = widget.cubit.hasEmail;
    collateralAmount.text = widget.cubit.collateralCached ?? '';
    message.text = widget.cubit.messageCached ?? '';
    durationController.text = widget.cubit.durationCached ?? '';
    loanToken = widget.pawnshopPackage.loanToken?[0] ?? LoanToken();
    duration = widget.pawnshopPackage.durationQtyType == 0 ? S.current.week : S.current.month;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH24,
          Text(
            'Message',
            style: textNormal(
              AppTheme.getInstance().whiteColor(),
              16,
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
                  flex: 5,
                  child: TextFormField(
                    controller: message,
                    maxLength: 100,
                    onChanged: (value) {
                      widget.cubit.focusTextField.add(value);
                      if (value == '') {
                        widget.cubit.errorMessage.add('Invalid message');
                      } else {
                        widget.cubit.messageCached = value;
                        widget.cubit.errorMessage.add('');
                      }
                      widget.cubit.enableButtonRequest(
                        message.text,
                        collateralAmount.text,
                        durationController.text,
                      );
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
                        Colors.white.withOpacity(0.5),
                        16,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: widget.cubit.focusTextField,
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    return GestureDetector(
                      onTap: () {
                        widget.cubit.focusTextField.add('');
                        message.text = '';
                      },
                      child: (snapshot.data != '')
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
          StreamBuilder<String>(
            stream: widget.cubit.errorMessage,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return SizedBox(
                child: Text(
                  snapshot.data ?? '',
                  style: textNormal(
                    Colors.red,
                    12,
                  ),
                ),
              );
            },
          ),
          spaceH10,
          Text(
            'Collateral',
            style: textNormal(
              AppTheme.getInstance().whiteColor(),
              16,
            ),
          ),
          spaceH4,
          StreamBuilder<bool>(
            stream: widget.cubit.chooseExisting,
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
                        enabled: enable,
                        controller: collateralAmount,
                        maxLength: 50,
                        onChanged: (value) {
                          if (value == '') {
                            widget.cubit.errorCollateral.add('Invalid amount');
                          } else {
                            widget.cubit.collateralCached = value;
                            if (double.parse(
                                  value.replaceAll(',', ''),
                                ) >
                                widget.cubit.getMaxBalance(
                                  item.nameShortToken,
                                )) {
                              widget.cubit.errorCollateral.add(
                                'Max amount '
                                '${widget.cubit.getMaxBalance(item.nameShortToken)}',
                              );
                            } else if (double.parse(
                                  value.replaceAll(',', ''),
                                ) <=
                                0) {
                              widget.cubit.errorCollateral
                                  .add('Invalid amount');
                            } else {
                              widget.cubit.errorCollateral.add('');
                              widget.cubit.loanE(
                                double.parse(value.replaceAll(',', '')),
                                item,
                                widget.pawnshopPackage.loanToValue ?? 0,
                                widget.pawnshopPackage.loanToken?[0].symbol ??
                                    '',
                              );
                              if (durationController.text != '') {
                                widget.cubit.interestE(
                                  double.parse(
                                    widget.cubit.loanEstimation.value
                                        .replaceAll(',', ''),
                                  ),
                                  widget.pawnshopPackage.loanToken?[0].symbol ??
                                      '',
                                  widget.pawnshopPackage.interest ?? 0,
                                  duration,
                                  int.parse(durationController.text),
                                  widget.pawnshopPackage.repaymentToken?[0]
                                          .symbol ??
                                      '',
                                );
                              }
                            }
                          }
                          widget.cubit.enableButtonRequest(
                            message.text,
                            collateralAmount.text,
                            durationController.text,
                          );
                        },
                        cursorColor: AppTheme.getInstance().whiteColor(),
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,5}'),
                          ),
                        ],
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
                        Visibility(
                          visible: enable,
                          child: InkWell(
                            onTap: () {
                              collateralAmount.text = widget.cubit
                                  .getMax(item.nameShortToken)
                                  .replaceAll(',', '');
                              widget.cubit.errorCollateral.add('');
                              widget.cubit.loanE(
                                double.parse(
                                  collateralAmount.text.replaceAll(',', ''),
                                ),
                                item,
                                widget.pawnshopPackage.loanToValue ?? 0,
                                widget.pawnshopPackage.loanToken?[0].symbol ??
                                    '',
                              );
                              widget.cubit.interestE(
                                double.parse(
                                  widget.cubit.loanEstimation.value
                                      .replaceAll(',', ''),
                                ),
                                widget.pawnshopPackage.loanToken?[0].symbol ??
                                    '',
                                widget.pawnshopPackage.interest ?? 0,
                                duration,
                                durationController.text != ''
                                    ? int.parse(durationController.text)
                                    : 0,
                                widget.pawnshopPackage.repaymentToken?[0]
                                        .symbol ??
                                    '',
                              );
                            },
                            child: Text(
                              'Max',
                              style: textNormalCustom(
                                fillYellowColor,
                                16,
                                FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        spaceW10,
                        DropdownButtonHideUnderline(
                          child: DropdownButton<ModelToken>(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
                            dropdownColor:
                                AppTheme.getInstance().backgroundBTSColor(),
                            items: widget.cubit.listTokenCollateral
                                .map((ModelToken model) {
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
                                  widget.cubit.collateralTokenCached = newValue;
                                  item = newValue!;
                                });
                                if ((collateralAmount.text != ''
                                        ? double.parse(
                                            collateralAmount.text
                                                .replaceAll(',', ''),
                                          )
                                        : 0) >
                                    widget.cubit.getMaxBalance(
                                      item.nameShortToken,
                                    )) {
                                  widget.cubit.errorCollateral.add(
                                    'Max amount '
                                    '${widget.cubit.getMaxBalance(item.nameShortToken)}',
                                  );
                                } else {
                                  widget.cubit.errorCollateral.add('');
                                }
                                if (collateralAmount.text != '') {
                                  widget.cubit.loanE(
                                    double.parse(
                                      collateralAmount.text.replaceAll(',', ''),
                                    ),
                                    item,
                                    widget.pawnshopPackage.loanToValue ?? 0,
                                    widget.pawnshopPackage.loanToken?[0]
                                            .symbol ??
                                        '',
                                  );
                                  widget.cubit.interestE(
                                    double.parse(
                                      widget.cubit.loanEstimation.value
                                          .replaceAll(',', ''),
                                    ),
                                    widget.pawnshopPackage.loanToken?[0]
                                            .symbol ??
                                        '',
                                    widget.pawnshopPackage.interest ?? 0,
                                    duration,
                                    durationController.text != ''
                                        ? int.parse(durationController.text)
                                        : 0,
                                    widget.pawnshopPackage.repaymentToken?[0]
                                            .symbol ??
                                        '',
                                  );
                                }
                                widget.cubit.enableButtonRequest(
                                  message.text,
                                  collateralAmount.text,
                                  durationController.text,
                                );
                              }
                            },
                            value: item,
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
            stream: widget.cubit.errorCollateral,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return SizedBox(
                child: Text(
                  snapshot.data ?? '',
                  style: textNormal(
                    Colors.red,
                    12,
                  ),
                ),
              );
            },
          ),
          spaceH10,
          Text(
            'Duration',
            style: textNormal(
              AppTheme.getInstance().whiteColor(),
              16,
            ),
          ),
          spaceH4,
          StreamBuilder<bool>(
            stream: widget.cubit.chooseExisting,
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
                      flex: 3,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d{0,4}'),
                          ),
                        ],
                        enabled: enable,
                        controller: durationController,
                        maxLength: 50,
                        onChanged: (value) {
                          if (value == '') {
                            widget.cubit.errorDuration.add('Invalid amount');
                          } else {
                            widget.cubit.checkDuration(value, duration);
                            widget.cubit.interestE(
                              double.parse(
                                widget.cubit.loanEstimation.value
                                    .replaceAll(',', ''),
                              ),
                              widget.pawnshopPackage.loanToken?[0].symbol ?? '',
                              widget.pawnshopPackage.interest ?? 0,
                              duration,
                              int.parse(value),
                              widget.pawnshopPackage.repaymentToken?[0]
                                      .symbol ??
                                  '',
                            );
                          }
                          widget.cubit.enableButtonRequest(
                            message.text,
                            collateralAmount.text,
                            durationController.text,
                          );
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
                          hintText: 'Duration',
                          hintStyle: textNormal(
                            Colors.white.withOpacity(0.5),
                            16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                          dropdownColor:
                              AppTheme.getInstance().backgroundBTSColor(),
                          items: (widget.pawnshopPackage.durationQtyType == 0
                                  ? [S.current.week]
                                  : [S.current.month])
                              .map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    item,
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
                            if (enable) {
                              setState(() {
                                widget.cubit.durationCachedType = newValue;
                                duration = newValue!;
                              });
                              if (durationController.text != '') {
                                widget.cubit.checkDuration(
                                  durationController.text,
                                  duration,
                                );
                                widget.cubit.interestE(
                                  double.parse(
                                    widget.cubit.loanEstimation.value
                                        .replaceAll(',', ''),
                                  ),
                                  widget.pawnshopPackage.loanToken?[0].symbol ??
                                      '',
                                  widget.pawnshopPackage.interest ?? 0,
                                  duration,
                                  int.parse(durationController.text),
                                  widget.pawnshopPackage.repaymentToken?[0]
                                          .symbol ??
                                      '',
                                );
                                widget.cubit.enableButtonRequest(
                                  message.text,
                                  collateralAmount.text,
                                  durationController.text,
                                );
                              }
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
            stream: widget.cubit.errorDuration,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return SizedBox(
                child: Text(
                  snapshot.data ?? '',
                  style: textNormal(
                    Colors.red,
                    12,
                  ),
                ),
              );
            },
          ),
          spaceH16,
          Text(
            'Or',
            style: textNormal(
              AppTheme.getInstance().whiteColor(),
              16,
            ),
          ),
          spaceH4,
          StreamBuilder<bool>(
            stream: widget.cubit.chooseExisting,
            builder: (context, snapshot) {
              return InkWell(
                onTap: () {
                  if (snapshot.data == false) {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => SelectCryptoCollateral(
                          walletAddress: widget.cubit.wallet,
                          packageId: widget.pawnshopPackage.id.toString(),
                          isLoanRequest: false,
                        ),
                      ),
                    )
                        .then((value) {
                      if (value != null) {
                        final CryptoCollateralModel select =
                            value as CryptoCollateralModel;
                        if (select.loanTokenSymbol != '') {
                          widget.cubit.chooseExisting.add(true);
                          collateralAmount.text =
                              select.collateralAmount.toString();
                          widget.cubit.collateralCached = collateralAmount.text;
                          bcCollateralId = select.bcCollateralId.toString();
                          txhChoseCollateral = select.txhHash.toString();
                          message.text = select.name.toString();
                          widget.cubit.messageCached = message.text;
                          durationController.text = select.duration.toString();
                          widget.cubit.durationCached = durationController.text;
                          duration = widget.pawnshopPackage.durationQtyType == 0
                              ? S.current.week
                              : S.current.month;
                          widget.cubit.durationCachedType = duration;
                          item = widget.cubit.listTokenCollateral.firstWhere(
                            (element) =>
                                element.nameShortToken ==
                                select.collateralSymbol,
                          );
                          widget.cubit.collateralTokenCached = item;
                          widget.cubit.loanE(
                            double.parse(
                              collateralAmount.text.replaceAll(',', ''),
                            ),
                            item,
                            widget.pawnshopPackage.loanToValue ?? 0,
                            widget.pawnshopPackage.loanToken?[0].symbol ?? '',
                          );
                          widget.cubit.interestE(
                            double.parse(
                              widget.cubit.loanEstimation.value
                                  .replaceAll(',', ''),
                            ),
                            widget.pawnshopPackage.loanToken?[0].symbol ?? '',
                            widget.pawnshopPackage.interest ?? 0,
                            duration,
                            int.parse(durationController.text),
                            widget.pawnshopPackage.repaymentToken?[0].symbol ??
                                '',
                          );
                          widget.cubit.enableButtonRequest(
                            message.text,
                            collateralAmount.text,
                            durationController.text,
                          );
                        }
                      }
                    });
                  } else {
                    collateralAmount.text = '';
                    durationController.text = '';
                    message.text = '';
                    duration = duration =
                        widget.pawnshopPackage.durationQtyType == 0
                            ? S.current.week
                            : S.current.month;
                    item = widget.cubit.listTokenCollateral[0];
                    widget.cubit.chooseExisting.add(false);
                    widget.cubit.enableButtonRequest(
                      message.text,
                      collateralAmount.text,
                      durationController.text,
                    );
                  }
                },
                child: Container(
                  height: 48.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    border: Border.all(
                      color: (snapshot.data == false)
                          ? fillYellowColor
                          : redMarketColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (snapshot.data == false)
                          ? 'Choose existing collateral'
                          : 'Clear existing collateral',
                      style: textNormalCustom(
                        (snapshot.data == false)
                            ? fillYellowColor
                            : redMarketColor,
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          spaceH24,
          divider,
          spaceH24,
          Text(
            'Loan estimation',
            style: textNormalCustom(
              AppTheme.getInstance().whiteColor(),
              16,
              FontWeight.w600,
            ),
          ),
          spaceH8,
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Interest estimation',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor().withOpacity(0.7),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Image.network(
                        ImageAssets.getUrlToken(
                          widget.pawnshopPackage.repaymentToken?[0].symbol ??
                              '',
                        ),
                      ),
                    ),
                    spaceW8,
                    StreamBuilder<String>(
                      stream: widget.cubit.interestEstimation,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data ?? '',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w400,
                          ),
                        );
                      },
                    ),
                    spaceW8,
                    Text(
                      widget.pawnshopPackage.repaymentToken?[0].symbol ?? '',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          spaceH8,
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Loan estimation',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor().withOpacity(0.7),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Image.network(
                        ImageAssets.getUrlToken(
                          widget.pawnshopPackage.loanToken?[0].symbol ?? '',
                        ),
                      ),
                    ),
                    spaceW8,
                    StreamBuilder<String>(
                      stream: widget.cubit.loanEstimation,
                      builder: (context, snapshot) {
                        return SizedBox(
                          child: Text(
                            snapshot.data ?? '',
                            style: textNormalCustom(
                              AppTheme.getInstance().whiteColor(),
                              16,
                              FontWeight.w400,
                            ),
                          ),
                        );
                      },
                    ),
                    spaceW8,
                    Text(
                      widget.pawnshopPackage.loanToken?[0].symbol ?? '',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          spaceH24,
          Visibility(
            visible: !widget.cubit.hasEmail,
            child: InkWell(
              onTap: () {
                widget.cubit.emailNotification.add(!checkEmail);
                if (!checkEmail) {
                  showDialog(
                    context: context,
                    builder: (context) => ConnectWalletDialog(
                      navigationTo: SignLoanContract(
                        pawnshopPackage: widget.pawnshopPackage,
                      ),
                      isRequireLoginEmail: true,
                      hasFunction: true,
                      function: () {
                        checkEmail = true;
                      },
                    ),
                  );
                }
              },
              child: StreamBuilder<bool>(
                stream: widget.cubit.emailNotification,
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  return CheckboxItemTab(
                    nameCheckbox: S.current.login_to_receive_email_notification,
                    isSelected: snapshot.data ?? true,
                  );
                },
              ),
            ),
          ),
          spaceH35,
          StreamBuilder<bool>(
            stream: widget.cubit.enableButton,
            builder: (context, snapshot) {
              if (snapshot.data ?? false) {
                return ButtonGradient(
                  onPressed: () async {
                    if (collateralAmount.text.isEmpty ||
                        message.text.isEmpty ||
                        durationController.text.isEmpty) {
                      if (collateralAmount.text.isEmpty) {
                        widget.cubit.errorCollateral
                            .add('Collateral amount not null');
                      }
                      if (message.text.isEmpty) {
                        widget.cubit.errorMessage.add('Message not null');
                      }
                      if (durationController.text.isEmpty) {
                        widget.cubit.errorDuration.add('Duration not null');
                      }
                      widget.cubit.enableButtonRequest(
                        message.text,
                        collateralAmount.text,
                        durationController.text,
                      );
                    } else {
                      if (checkEmail) {
                        if (widget.cubit.chooseExisting.value ||
                            item.nameShortToken == 'BNB') {
                          unawaited(showLoadingDialog(context));
                          await widget.cubit
                              .pushSendNftToBE(
                            amount: collateralAmount.text,
                            bcPackageId:
                                widget.pawnshopPackage.bcPackageId.toString(),
                            collateral: item.nameShortToken,
                            collateralId: bcCollateralId,
                            description: message.text,
                            duration: durationController.text,
                            durationType:
                                duration == S.current.week ? '0' : '1',
                            packageId: widget.pawnshopPackage.id.toString(),
                            pawnshopType:
                                widget.pawnshopPackage.type.toString(),
                            txId: txhChoseCollateral,
                            supplyCurrency: loanToken.symbol ?? '',
                            walletAddress: widget.cubit.wallet,
                          )
                              .then((value) async {
                            if (value) {
                              await showLoadSuccess(context).then(
                                (value) => Navigator.of(context)
                                  ..pop()
                                  ..pop(true),
                              );
                            } else {
                              await showLoadFail(context);
                              Navigator.of(context).pop();
                            }
                          });
                        } else {
                          final nav = Navigator.of(context);
                          final hexString =
                              await widget.cubit.getCreateCryptoCollateral(
                            collateralAddress: item.tokenAddress,
                            packageID: '-1',
                            amount: collateralAmount.text,
                            loanToken: loanToken.address ?? '',
                            durationQty: durationController.text,
                            durationType: duration == S.current.week ? 0 : 1,
                          );
                          unawaited(
                            nav.push(
                              MaterialPageRoute(
                                builder: (context) => Approve(
                                  warning: (double.parse(
                                                widget
                                                    .cubit.loanEstimation.value
                                                    .replaceAll(',', ''),
                                              ) >
                                              widget
                                                  .pawnshopPackage.available! &&
                                          widget.pawnshopPackage.type == 0)
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              ImageAssets.img_waning,
                                              height: 20.h,
                                              width: 20.w,
                                              color: failTransactionColor,
                                            ),
                                            spaceW5,
                                            SizedBox(
                                              width: 317.w,
                                              child: Text(
                                                "The pawnshop's balance is currently not sufficient to complete this transaction."
                                                ' You will have to wait. Are your sure you wish to continue?',
                                                style: textNormal(
                                                  failTransactionColor,
                                                  14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  hexString: hexString,
                                  payValue: collateralAmount.text,
                                  tokenAddress: item.tokenAddress,
                                  needApprove: true,
                                  onSuccessSign: (context, data) async {
                                    await widget.cubit
                                        .pushSendNftToBE(
                                      amount: collateralAmount.text,
                                      bcPackageId:
                                          widget.pawnshopPackage.id.toString(),
                                      collateral: item.nameShortToken,
                                      collateralId: '',
                                      description: message.text,
                                      duration: durationController.text,
                                      durationType: duration == S.current.week
                                          ? '0'
                                          : '1',
                                      packageId:
                                          widget.pawnshopPackage.id.toString(),
                                      pawnshopType: widget.pawnshopPackage.type
                                          .toString(),
                                      txId: data,
                                      supplyCurrency: loanToken.symbol ?? '',
                                      walletAddress: widget.cubit.wallet,
                                    )
                                        .then((value) async {
                                      if (value) {
                                        await showLoadSuccess(context).then(
                                          (value) => Navigator.of(context)
                                            ..pop()
                                            ..pop()
                                            ..pop(true),
                                        );
                                      } else {
                                        await showLoadFail(context);
                                      }
                                    });
                                  },
                                  onErrorSign: (context) {
                                    showLoadFail(context);
                                    Navigator.pop(context);
                                  },
                                  listDetail: [
                                    DetailItemApproveModel(
                                      title: S.current.message,
                                      value: message.text,
                                    ),
                                    DetailItemApproveModel(
                                      title: S.current.collateral,
                                      urlToken: item.iconToken,
                                      value:
                                          '${collateralAmount.text} ${item.nameShortToken}',
                                    ),
                                    DetailItemApproveModel(
                                      title: S.current.loan_token,
                                      urlToken: ImageAssets.getUrlToken(
                                          loanToken.symbol ?? ''),
                                      value: loanToken.symbol ?? '',
                                    ),
                                    DetailItemApproveModel(
                                      title: S.current.duration,
                                      value:
                                          '${durationController.text} $duration',
                                    ),
                                  ],
                                  title: 'Confirm loan request',
                                  textActiveButton: S.current.send,
                                  spender: Get.find<AppConstants>()
                                      .crypto_pawn_contract,
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        showDialogSuccess(
                          context,
                          alert: 'Warning',
                          text:
                              'You must be login by email to send loan request',
                          onlyPop: true,
                        );
                      }
                    }
                  },
                  gradient: RadialGradient(
                    center: const Alignment(0.5, -0.5),
                    radius: 4,
                    colors: AppTheme.getInstance().gradientButtonColor(),
                  ),
                  child: Text(
                    S.current.request_loan,
                    style: textNormalCustom(
                      AppTheme.getInstance().textThemeColor(),
                      16,
                      FontWeight.w700,
                    ),
                  ),
                );
              } else {
                return ErrorButton(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      S.current.request_loan,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        16,
                        FontWeight.w700,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          spaceH35,
        ],
      ),
    );
  }
}
