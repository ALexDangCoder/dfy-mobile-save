import 'dart:async';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/pawn/crypto_collateral.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/pawn/select_crypto_collateral/ui/select_crypto.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/bloc/send_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/check_tab_bar.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CryptoCurrency extends StatefulWidget {
  const CryptoCurrency({
    Key? key,
    required this.cubit,
    required this.walletAddress,
    required this.packageId,
    required this.hasEmail,
    required this.pawnshopType,
  }) : super(key: key);

  final SendLoanRequestCubit cubit;
  final String walletAddress;
  final String packageId;
  final String pawnshopType;
  final bool hasEmail;

  @override
  _CryptoCurrencyState createState() => _CryptoCurrencyState();
}

class _CryptoCurrencyState extends State<CryptoCurrency>
    with SingleTickerProviderStateMixin {
  late TextEditingController collateralAmount = TextEditingController();
  late TextEditingController message = TextEditingController();
  late TextEditingController durationController = TextEditingController();
  late ModelToken item;
  late ModelToken loanToken;
  late String duration;
  bool checkEmail = true;
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
    collateralAmount.text = widget.cubit.collateralCached ?? '';
    message.text = widget.cubit.messageCached ?? '';
    durationController.text = widget.cubit.durationCached ?? '';
    loanToken = widget.cubit.loanTokenCached ?? widget.cubit.checkShow[0];
    duration = widget.cubit.durationCachedType ?? S.current.week;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 21.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                            widget.cubit.errorCollateral
                                .add('Collateral amount not null');
                          } else {
                            widget.cubit.collateralCached = value;
                            if (double.parse(value.replaceAll(',', '')) >
                                widget.cubit
                                    .getMaxBalance(item.nameShortToken)) {
                              widget.cubit.errorCollateral.add(
                                'Max amount '
                                '${widget.cubit.getMaxBalance(item.nameShortToken)}',
                              );
                            } else if (double.parse(
                                    value.replaceAll(',', '')) <=
                                0) {
                              widget.cubit.errorCollateral
                                  .add('Invalid amount');
                            } else {
                              widget.cubit.errorCollateral.add('');
                            }
                          }
                          widget.cubit.enableButtonRequest();
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
                        Visibility(
                          visible: enable,
                          child: InkWell(
                            onTap: () {
                              collateralAmount.text = widget.cubit
                                  .getMax(item.nameShortToken)
                                  .replaceAll(',', '');
                              widget.cubit.errorCollateral.add('');
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
                        widget.cubit.errorMessage.add('Message not null');
                      } else {
                        widget.cubit.messageCached = value;
                        widget.cubit.errorMessage.add('');
                      }
                      widget.cubit.enableButtonRequest();
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
                        enabled: enable,
                        controller: durationController,
                        maxLength: 50,
                        onChanged: (value) {
                          if (value == '') {
                            widget.cubit.errorDuration.add('Duration not null');
                          } else if (value.contains(',') ||
                              value.contains('.')) {
                            widget.cubit.errorDuration
                                .add('Duration must be integer');
                          } else if (double.parse(value.replaceAll(',', '')) <=
                              0) {
                            widget.cubit.errorDuration.add('Invalid amount');
                          } else {
                            widget.cubit.durationCached = value;
                            widget.cubit.errorDuration.add('');
                          }
                          widget.cubit.enableButtonRequest();
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
                          items: [S.current.week, S.current.month]
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
          spaceH10,
          Text(
            'Loan',
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
                    child: DropdownButton2<ModelToken>(
                      buttonDecoration: BoxDecoration(
                        color: AppTheme.getInstance().backgroundBTSColor(),
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      ),
                      items: widget.cubit.checkShow.map((ModelToken model) {
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
                            widget.cubit.loanTokenCached = newValue;
                            loanToken = newValue!;
                          });
                        }
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
                          walletAddress: widget.walletAddress,
                          packageId: widget.packageId,
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
                          widget.cubit.collateralCached =
                              collateralAmount.text;
                          bcCollateralId = select.bcCollateralId.toString();
                          txhChoseCollateral = select.txhHash.toString();
                          message.text = select.name.toString();
                          widget.cubit.messageCached = message.text;
                          durationController.text = select.duration.toString();
                          widget.cubit.durationCached =
                              durationController.text;
                          duration = select.durationType == 0
                              ? S.current.week
                              : S.current.month;
                          widget.cubit.durationCachedType =
                          duration;
                          item =
                              widget.cubit.listTokenFromWalletCore.firstWhere(
                            (element) =>
                                element.nameShortToken ==
                                select.collateralSymbol,
                          );
                          widget.cubit.collateralTokenCached =
                              item;
                          loanToken = widget.cubit.checkShow.firstWhere(
                            (element) =>
                                element.nameShortToken ==
                                select.loanTokenSymbol,
                          );
                          widget.cubit.loanTokenCached =
                              loanToken;
                        }
                      }
                    });
                  } else {
                    collateralAmount.text = '';
                    durationController.text = '';
                    duration = S.current.week;
                    item = widget.cubit.listTokenCollateral[0];
                    loanToken = widget.cubit.checkShow[0];
                    widget.cubit.chooseExisting.add(false);
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
          Visibility(
            visible: !widget.hasEmail,
            child: InkWell(
              onTap: () {
                checkEmail = !checkEmail;
                widget.cubit.emailNotification.add(checkEmail);
                showDialog(
                  context: context,
                  builder: (context) => ConnectWalletDialog(
                    navigationTo: CryptoCurrency(
                      cubit: widget.cubit,
                      walletAddress: widget.walletAddress,
                      packageId: widget.packageId,
                      pawnshopType: widget.pawnshopType,
                      hasEmail: true,
                    ),
                    isRequireLoginEmail: true,
                  ),
                );
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
                      widget.cubit.enableButtonRequest();
                    } else {
                      if (widget.cubit.chooseExisting.value) {
                        unawaited(showLoadingDialog(context));
                        await widget.cubit.pushSendNftToBE(
                          amount: collateralAmount.text,
                          bcPackageId: widget.packageId,
                          collateral: item.nameShortToken,
                          collateralId: bcCollateralId,
                          description: message.text,
                          duration: durationController.text,
                          durationType: duration == S.current.week ? '0' : '1',
                          packageId: widget.packageId,
                          pawnshopType: widget.pawnshopType,
                          txId: txhChoseCollateral,
                          supplyCurrency: loanToken.nameShortToken,
                          walletAddress: widget.walletAddress,
                        );
                        await showLoadSuccess(context).then(
                          (value) => Navigator.of(context)
                            ..pop()
                            ..pop(),
                        );
                      } else {
                        final nav = Navigator.of(context);
                        final hexString =
                            await widget.cubit.getCreateCryptoCollateral(
                          collateralAddress: item.tokenAddress,
                          packageID: '-1',
                          amount: collateralAmount.text,
                          loanToken: loanToken.tokenAddress,
                          durationQty: durationController.text,
                          durationType: duration == S.current.week ? 0 : 1,
                        );
                        unawaited(
                          nav.push(
                            MaterialPageRoute(
                              builder: (context) => Approve(
                                hexString: hexString,
                                payValue: collateralAmount.text,
                                tokenAddress:
                                    Get.find<AppConstants>().contract_defy,
                                needApprove: true,
                                onSuccessSign: (context, data) async {
                                  await widget.cubit.pushSendNftToBE(
                                    amount: collateralAmount.text,
                                    bcPackageId: widget.packageId,
                                    collateral: item.nameShortToken,
                                    collateralId: '',
                                    description: message.text,
                                    duration: durationController.text,
                                    durationType:
                                        duration == S.current.week ? '0' : '1',
                                    packageId: widget.packageId,
                                    pawnshopType: widget.pawnshopType,
                                    txId: data,
                                    supplyCurrency: loanToken.nameShortToken,
                                    walletAddress: widget.walletAddress,
                                  );
                                  await showLoadSuccess(context).then(
                                    (value) => Navigator.of(context)
                                      ..pop()
                                      ..pop()
                                      ..pop(),
                                  );
                                },
                                onErrorSign: (context) {
                                  showLoadFail(context);
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
                                    urlToken: loanToken.iconToken,
                                    value: loanToken.nameShortToken,
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
        ],
      ),
    );
  }
}
