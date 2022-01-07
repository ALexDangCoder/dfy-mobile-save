import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/bloc/connect_wallet_dialog_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectWalletDialog extends StatefulWidget {
  final Widget navigationTo;

  const ConnectWalletDialog({
    Key? key,
    required this.navigationTo,
  }) : super(key: key);

  @override
  State<ConnectWalletDialog> createState() => _ConnectWalletDialogState();
}

class _ConnectWalletDialogState extends State<ConnectWalletDialog> {
  late final ConnectWalletDialogCubit cubit;

  @override
  void initState() {
    cubit = ConnectWalletDialogCubit();
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    cubit.checkLoginStatus();
    cubit.getListWallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (cubit.isLogin.value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget.navigationTo),
      );
    }
    bool isHaveAccount = false;
    String contentDialog = '';
    String contentRightBtn = '';
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              constraints: BoxConstraints(minHeight: 177.h),
              width: 312.w,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                borderRadius: const BorderRadius.all(Radius.circular(36)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 32,
                      right: 42.5,
                      bottom: 24,
                      left: 41.5,
                    ),
                    child: BlocConsumer<ConnectWalletDialogCubit,
                        ConnectWalletDialogState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is NeedLoginToUse) {
                          contentDialog = state.contentDialog;
                        }
                        if (state is HasNoWallet) {
                          contentDialog = state.contentDialog;
                        }
                      },
                      builder: (context, state) {
                        return Text(
                          contentDialog,
                          textAlign: TextAlign.center,
                          style: textNormal(
                            AppTheme.getInstance().whiteColor(),
                            20.sp,
                          ).copyWith(fontWeight: FontWeight.w600),
                        );
                      },
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1.w,
                                color: AppTheme.getInstance()
                                    .whiteBackgroundButtonColor(),
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 19,
                                top: 17,
                              ),
                              child: Text(
                                S.current.cancel,
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  20.sp,
                                ).copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1.w,
                                color: AppTheme.getInstance()
                                    .whiteBackgroundButtonColor(),
                              ),
                              left: BorderSide(
                                width: 1.w,
                                color: AppTheme.getInstance()
                                    .whiteBackgroundButtonColor(),
                              ),
                            ),
                          ),
                          child: BlocConsumer<ConnectWalletDialogCubit,
                              ConnectWalletDialogState>(
                            bloc: cubit,
                            listener: (context, state) {
                              if (state is NeedLoginToUse) {
                                isHaveAccount = true;
                              }
                              if (state is HasNoWallet) {
                                isHaveAccount = false;
                              }
                            },
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  if (isHaveAccount) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MainScreen(
                                          index: 2,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MainScreen(
                                          index: 3,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 19,
                                    top: 17,
                                  ),
                                  child: BlocConsumer<ConnectWalletDialogCubit,
                                      ConnectWalletDialogState>(
                                    bloc: cubit,
                                    listener: (context, state) {
                                      if (state is NeedLoginToUse) {
                                        contentRightBtn =
                                            state.contentRightButton;
                                      }
                                      if (state is HasNoWallet) {
                                        contentRightBtn =
                                            state.contentRightButton;
                                      }
                                    },
                                    builder: (context, state) {
                                      return Text(
                                        contentRightBtn,
                                        style: textNormal(
                                          AppTheme.getInstance().fillColor(),
                                          20.sp,
                                        ).copyWith(fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
