import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/market_place/login/connect_email_dialog/ui/connect_email_dialog.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/bloc/connect_wallet_dialog_cubit.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/wallet_dialog_when_wallet_logged.dart';
import 'package:Dfy/widgets/stream_consumer/stream_consumer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectWalletDialog extends StatefulWidget {
  /// The screen you want navigator to if user  has login
  final Widget navigationTo;
  final bool isRequireLoginEmail;

  const ConnectWalletDialog({
    Key? key,
    required this.navigationTo,
    required this.isRequireLoginEmail,
  }) : super(key: key);

  @override
  State<ConnectWalletDialog> createState() => _ConnectWalletDialogState();
}

class _ConnectWalletDialogState extends State<ConnectWalletDialog> {
  late final ConnectWalletDialogCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ConnectWalletDialogCubit();
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    cubit.getListWallet();
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamConsumerCustom(
        stream: cubit.isHaveWalletStream,
        listen: (event) async {
          await cubit.checkStatusLogin();
          await cubit.getBalance(
            walletAddress: cubit.wallet?.address ?? '',
            context: context,
          );
        },
        builder: (_, __) {
          return StreamBuilder<LoginStatus>(
            stream: cubit.loginStatusSubject,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  color: Colors.transparent,
                );
              } else {
                final LoginStatus loginStatus = snapshot.data!;
                if (loginStatus == LoginStatus.LOGGED) {
                  Future.delayed(const Duration(milliseconds: 300), () {
                    Navigator.pop(context);
                    if(widget.isRequireLoginEmail){
                      
                    }
                    showDialog(
                      context: context,
                      builder: (context) => ConnectEmailDialog(
                        navigationTo: widget.navigationTo,
                      ),
                    );
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => widget.navigationTo),
                    // );
                  });
                  return Container(
                    color: Colors.transparent,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  );
                } else if (loginStatus == LoginStatus.NEED_REGISTER ||
                    loginStatus == LoginStatus.NEED_LOGIN) {
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(36)),
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
                                  child: Text(
                                    loginStatus.convertToContentDialog(),
                                    textAlign: TextAlign.center,
                                    style: textNormal(
                                      AppTheme.getInstance().whiteColor(),
                                      20.sp,
                                    ).copyWith(fontWeight: FontWeight.w600),
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
                                                AppTheme.getInstance()
                                                    .whiteColor(),
                                                20.sp,
                                              ).copyWith(
                                                  fontWeight: FontWeight.bold),
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
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            if (loginStatus ==
                                                LoginStatus.NEED_LOGIN) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MainScreen(
                                                    isFormConnectWlDialog: true,
                                                    index: 2,
                                                  ),
                                                ),
                                              );
                                            } else if (loginStatus ==
                                                LoginStatus.NEED_REGISTER) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MainScreen(
                                                    index: 3,
                                                    isFormConnectWlDialog: true,
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
                                            child: Text(
                                              loginStatus
                                                  .convertToContentRightButton(),
                                              style: textNormal(
                                                AppTheme.getInstance()
                                                    .fillColor(),
                                                20.sp,
                                              ).copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
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
                } else {
                  return WalletDialogWhenLoggedCore(
                    balance: cubit.balanceSubject.value,
                    cubit: cubit,
                    wallet: cubit.wallet ?? Wallet(),
                    navigationTo: widget.navigationTo,
                  );
                }
              }
            },
          );
        });
  }
}
