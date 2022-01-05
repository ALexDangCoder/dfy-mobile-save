import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/approve/bloc/approve_cubit.dart';
import 'package:Dfy/presentation/put_on_market/approve/ui/component/estimate_gas_fee.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';

class Approve extends StatefulWidget {
  final String title;
  final List<DetailItemApproveModel>? listDetail;
  final Widget? warning;

  const Approve({Key? key, required this.title, this.listDetail, this.warning})
      : super(key: key);

  @override
  _ApproveState createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  ApproveCubit cubit = ApproveCubit();
  GlobalKey scaffoldKey = GlobalKey();
  double? heightScaffold;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      heightScaffold = scaffoldKey.currentContext?.size?.height;
    });
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    cubit.getListWallets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 48),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              header(),
              Divider(
                thickness: 1,
                color: AppTheme.getInstance().divideColor(),
              ),
              Expanded(
                child: Container(
                  height: heightScaffold,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...(widget.listDetail ?? []).map(
                          (item) => Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      item.title,
                                      style: textNormal(
                                        AppTheme.getInstance()
                                            .whiteColor()
                                            .withOpacity(0.7),
                                        14.sp,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      item.value,
                                      style: item.isToken ?? false
                                          ? textNormalCustom(
                                              AppTheme.getInstance()
                                                  .fillColor(),
                                              20.sp,
                                              FontWeight.w600,
                                            )
                                          : textNormal(
                                              AppTheme.getInstance()
                                                  .whiteColor(),
                                              16.sp,
                                            ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 16)
                            ],
                          ),
                        ),
                        if (widget.warning != null)
                          Column(
                            children: [
                              const SizedBox(height: 4),
                              widget.warning ?? const SizedBox(height: 0),
                              const SizedBox(height: 20),
                            ],
                          )
                        else
                          const SizedBox(height: 4),
                        Divider(
                          thickness: 1,
                          color: AppTheme.getInstance().divideColor(),
                        ),
                        const SizedBox(height: 16),
                        walletView(),
                        const SizedBox(height: 16),
                        EstimateGasFee(
                          cubit: cubit,
                          gasLimitStart: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: ButtonGold(
                      title: S.current.continue_s,
                      isEnable: false,
                      fixSize: false,
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: ButtonGold(
                      fixSize: false,
                      title: S.current.continue_s,
                      isEnable: true,
                    ),
                    onTap: () {},
                  ),
                )
              ],
            ),
            const SizedBox (height : 38)
          ],
        ),
      ),
    );
  }

  Container containerWithBorder({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getInstance().whiteBackgroundButtonColor(),
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: child,
    );
  }

  Widget walletView() {
    return containerWithBorder(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // border: Border.all(
                //     color: Colors.teal, width: 10.0, style: BorderStyle.solid),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      '${ImageAssets.image_avatar}${cubit.randomAvatar()}'
                      '.png'),
                ),
              ),
              height: 40,
              width: 40,
            ),
            SizedBox(
              width: 8.w,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StreamBuilder<String>(
                        stream: cubit.nameWalletStream,
                        builder: (context, snapshot) {
                          String data = snapshot.data ?? 'Account';
                          return Text(
                            data,
                            style: textNormal(
                              AppTheme.getInstance().whiteColor(),
                              16.sp,
                            ).copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }),
                    SizedBox(
                      width: 8.w,
                    ),
                    StreamBuilder<String>(
                        stream: cubit.addressWalletCoreStream,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data == null
                                ? ''
                                : snapshot.data!.formatAddressWallet(),
                            style: textNormal(
                              AppTheme.getInstance().currencyDetailTokenColor(),
                              14.sp,
                            ),
                          );
                        }),
                  ],
                ),
                StreamBuilder<double>(
                    stream: cubit.balanceWalletStream,
                    builder: (context, snapshot) {
                      final double data = snapshot.data ?? 0;
                      return Text(
                        '${S.current.balance}: $data',
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16.sp,
                        ),
                      );
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      height: 40,
      // height: 28.h,
      margin: const EdgeInsets.only(
        top: 16,
        // bottom: 20.h,
        left: 16,
        right: 16,
      ),
      // EdgeInsets.only(left: 0),
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.ic_back),
          ),
          Center(
            child: Text(
              widget.title,
              style: textNormal(AppTheme.getInstance().textThemeColor(), 20.sp)
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
