
import 'dart:ui';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';

import 'estimate_gas_fee.dart';

class PopUpApprove extends StatelessWidget {
  const PopUpApprove({
    Key? key,
    required this.imageAccount,
    required this.accountName,
    required this.addressWallet,
    required this.balanceWallet,
    required this.gasFee,
    required this.purposeText,
    required this.approve,
    required this.cubit,
  }) : super(key: key);

  final int imageAccount;
  final String accountName;
  final String purposeText;
  final String addressWallet;
  final double balanceWallet;
  final double gasFee;
  final Function approve;
  final ApproveCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2,
        sigmaY: 2,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 18),
            SizedBox(
              height: 44,
              width: 44,
              child: Image.asset(ImageAssets.imgTokenDFY),
            ),
            const SizedBox(height: 8),
            Text(
              '• testnet',
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                14,
                FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              purposeText,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                20,
                FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.getInstance().whiteBackgroundButtonColor(),
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            '${ImageAssets.image_avatar}$imageAccount'
                                '.png',
                          ),
                        ),
                      ),
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              accountName,
                              style: textNormal(
                                AppTheme.getInstance().whiteColor(),
                                16,
                              ).copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              addressWallet.formatAddressWallet(),
                              style: textNormal(
                                AppTheme.getInstance()
                                    .currencyDetailTokenColor(),
                                14,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${S.current.balance}: $balanceWallet',
                          style: textNormal(
                            AppTheme.getInstance().whiteColor(),
                            16,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            EstimateGasFee(
              cubit: cubit,
            ),
            const SizedBox(height: 36),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ButtonGold(
                      haveGradient: false,
                      textColor: AppTheme.getInstance().yellowColor(),
                      border: Border.all(
                        color: AppTheme.getInstance().yellowColor(),
                      ),
                      radiusButton: 15,
                      textSize: 16,
                      title: S.current.reject,
                      isEnable: true,
                      fixSize: false,
                      height: 48,
                      haveMargin: false,
                    ),
                  ),
                ),
                const SizedBox(width: 23),
                Expanded(
                  child: GestureDetector(
                    onTap: ()  {
                      approve();
                    },
                    child: ButtonGold(
                      radiusButton: 15,
                      textSize: 16,
                      title: S.current.approve,
                      isEnable: true,
                      height: 48,
                      fixSize: false,
                      haveMargin: false,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 38),
          ],
        ),
      ),
    );
  }
}
