import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/create_wallet_first_time/wallet_add_feat_seedpharse/ui/add_wallet_ft_seedpharse.dart';
import 'package:Dfy/presentation/login/ui/login_screen.dart';
import 'package:Dfy/presentation/market_place/login/bloc/connect_wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//chứa có wallet sẽ chuyển qua tạo wallet. Có rồi sẽ chuyển qua login
class ConnectWalletDialog extends StatefulWidget {
  const ConnectWalletDialog({Key? key}) : super(key: key);

  @override
  State<ConnectWalletDialog> createState() => _ConnectWalletDialogState();
}

class _ConnectWalletDialogState extends State<ConnectWalletDialog> {
  late final ConnectWalletCubit cubit;

  @override
  void initState() {
    cubit = ConnectWalletCubit();
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    cubit.getListWallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: BlocConsumer<ConnectWalletCubit, ConnectWalletState>(
                bloc: cubit,
                listener: (context, state) {},
                builder: (context, state) {
                  return Column(
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
                          state.contentDialog,
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  if (state is HasNoWallet) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AddWalletFtSeedPharse(),
                                      ),
                                    );
                                  } else if (state is NeedLoginToUse) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(
                                          walletCubit: WalletCubit(),
                                          isFromConnectDialog: true,
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
                                    state.contentRightButton,
                                    style: textNormal(
                                      AppTheme.getInstance().fillColor(),
                                      20.sp,
                                    ).copyWith(fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
