import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/pawn/crypto_collateral.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/select_crypto_collateral/ui/select_crypto.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/bloc/send_loan_request_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'check_tab_bar.dart';

class CryptoCurrency extends StatefulWidget {
  const CryptoCurrency({Key? key, required this.cubit}) : super(key: key);

  final SendLoanRequestCubit cubit;

  @override
  _CryptoCurrencyState createState() => _CryptoCurrencyState();
}

class _CryptoCurrencyState extends State<CryptoCurrency> {
  TextEditingController collateralAmount = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController durationController = TextEditingController();
  late ModelToken item;
  late ModelToken loanToken;
  late String duration;
  bool checkEmail = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    item = widget.cubit.listTokenFromWalletCore[0];
    loanToken = widget.cubit.checkShow[0];
    duration = S.current.week;
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
                  flex: 2,
                  child: TextFormField(
                    controller: collateralAmount,
                    maxLength: 50,
                    onChanged: (value) {},
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
                    InkWell(
                      onTap: () {
                        collateralAmount.text =
                            widget.cubit.getMax(item.nameShortToken);
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
                    spaceW10,
                    DropdownButtonHideUnderline(
                      child: DropdownButton<ModelToken>(
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        dropdownColor:
                            AppTheme.getInstance().backgroundBTSColor(),
                        items: widget.cubit.listTokenFromWalletCore
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
                          setState(() {
                            item = newValue!;
                          });
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
          ),
          spaceH16,
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
          spaceH16,
          Text(
            'Duration',
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
                  flex: 3,
                  child: TextFormField(
                    controller: durationController,
                    maxLength: 50,
                    onChanged: (value) {},
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
                      items:
                          [S.current.week, S.current.month].map((String item) {
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
              ],
            ),
          ),
          spaceH16,
          Text(
            'Loan',
            style: textNormal(
              AppTheme.getInstance().whiteColor(),
              16,
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
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ModelToken>(
                menuMaxHeight: 100.h,
                elevation: 3,
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
                dropdownColor: AppTheme.getInstance().backgroundBTSColor(),
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
                  setState(() {
                    loanToken = newValue!;
                  });
                },
                value: loanToken,
                icon: Image.asset(
                  ImageAssets.ic_line_down,
                  height: 24.h,
                  width: 24.w,
                ),
              ),
            ),
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
                          builder: (context) => const SelectCryptoCollateral(
                            walletAddress:
                                '0xaB05Ab79C0F440ad982B1405536aBc8094C80AfB',
                            packageId: '205',
                          ),
                        ),
                      )
                          .then((value) {
                        widget.cubit.chooseExisting.add(true);
                        final CryptoCollateralModel select =
                            value as CryptoCollateralModel;
                        collateralAmount.text =
                            select.collateralAmount.toString();
                        durationController.text = select.duration.toString();
                        duration = select.durationType == 0
                            ? S.current.week
                            : S.current.month;
                        item = widget.cubit.listTokenFromWalletCore.firstWhere(
                          (element) =>
                              element.nameShortToken == select.collateralSymbol,
                        );
                        loanToken = widget.cubit.checkShow.firstWhere(
                          (element) =>
                              element.nameShortToken == select.loanTokenSymbol,
                        );
                      });
                    } else {
                      collateralAmount.text = '';
                      durationController.text = '';
                      duration = S.current.week;
                      item = widget.cubit.listTokenFromWalletCore[0];
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
              }),
          spaceH24,
          InkWell(
            onTap: () {
              checkEmail = !checkEmail;
              widget.cubit.emailNotification.add(checkEmail);
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
          spaceH35,
          ButtonGradient(
            onPressed: () {
              /// TODO: Handle if un login => push to login => buy
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
          ),
        ],
      ),
    );
  }
}
