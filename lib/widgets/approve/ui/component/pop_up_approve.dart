import 'dart:ui';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/extension/get_gas_limit_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'estimate_gas_fee.dart';

class PopUpApprove extends StatefulWidget {
  const PopUpApprove({
    Key? key,
    required this.imageAccount,
    required this.accountName,
    required this.purposeText,
    required this.addressWallet,
    required this.balanceWallet,
    required this.gasFee,
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
  _PopUpApproveState createState() => _PopUpApproveState();
}

class _PopUpApproveState extends State<PopUpApprove> {
  GlobalKey bottomKey = GlobalKey();
  double heightOfBottom = 0;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      heightOfBottom = bottomKey.currentContext?.size?.height ?? 0;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      stream: widget.cubit.stateStream,
      error: AppException('', S.current.something_went_wrong),
      retry: () async {
        await widget.cubit.getGasLimitApprove(
          contractAddress: widget.cubit.tokenAddress ?? '',
          context: context,
        );
      },
      textEmpty: '',
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: false,
          right: false,
          left: false,
          bottom: defaultTargetPlatform == TargetPlatform.android,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  final FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.only(top: 48),
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().bgBtsColor(),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 18),
                          SizedBox(
                            height: 44,
                            width: 44,
                            child: Image.asset(ImageAssets.imgTokenDFY),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              text: '• ',
                              style: textNormalCustom(
                                AppTheme.getInstance().blueText(),
                                14,
                                FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Testnet',
                                  style: textNormalCustom(
                                    AppTheme.getInstance().textThemeColor(),
                                    14,
                                    FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            widget.purposeText,
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
                                color: AppTheme.getInstance()
                                    .whiteBackgroundButtonColor(),
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
                                          '${ImageAssets.image_avatar}${widget.imageAccount}'
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
                                            widget.accountName,
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
                                            widget.addressWallet
                                                .formatAddressWallet(),
                                            style: textNormal(
                                              AppTheme.getInstance()
                                                  .currencyDetailTokenColor(),
                                              14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${S.current.balance}: ${widget.balanceWallet}',
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
                            cubit: widget.cubit,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height:
                                MediaQuery.of(context).viewInsets.bottom <= 160
                                    ? heightOfBottom
                                    : 0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: AppTheme.getInstance().bgBtsColor(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    key: bottomKey,
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                                height: 48.h,
                                haveMargin: false,
                              ),
                            ),
                          ),
                          const SizedBox(width: 23),
                          Expanded(
                            child: StreamBuilder<bool>(
                              stream: widget.cubit.canActionStream,
                              builder: (context, snapshot) {
                                final canAction = snapshot.data ?? false;
                                return GestureDetector(
                                  onTap: () {
                                    print(canAction);
                                    if (canAction) {
                                      widget.approve();
                                    }
                                  },
                                  child: ButtonGold(
                                    radiusButton: 15,
                                    textSize: 16,
                                    title: S.current.approve,
                                    isEnable: canAction,
                                    height: 48.h,
                                    fixSize: false,
                                    haveMargin: false,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 38),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
