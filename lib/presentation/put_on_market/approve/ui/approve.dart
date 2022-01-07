import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/approve/bloc/approve_cubit.dart';
import 'package:Dfy/presentation/put_on_market/approve/ui/component/estimate_gas_fee.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';
import 'component/pop_up_approve.dart';

///  Appbar                                   :                  title
///  Body                                     :                  header
///  render list key value from
///  List<DetailItemApproveModel>? listDetail :
///                                                         key  ---    value
///                                                           key -----    value
///                                                           key ----     value
///                                                             .... continue
///    Widget? warning;                       :                 warning
///                                                            Widget account
///                                                      Widget estimate gas fee
///
class Approve extends StatefulWidget {
  final String title;
  final List<DetailItemApproveModel>? listDetail;
  final Widget? warning;
  final Widget? header;
  final bool? isShowTwoButton;
  final String textActiveButton;
  final Function approve;
  final Function action;

  const Approve({
    Key? key,
    required this.title,
    this.listDetail,
    this.warning,
    this.isShowTwoButton = false,
    required this.textActiveButton,
    this.header,
    required this.approve,
    required this.action,
  }) : super(key: key);

  @override
  _ApproveState createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  ApproveCubit cubit = ApproveCubit();
  GlobalKey scaffoldKey = GlobalKey();
  double? heightScaffold;
  bool? enableButtonAction;
  bool isCanAction = false;
  bool isApproved = false;
  late int accountImage;
  double gasFee = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountImage = cubit.randomAvatar();
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
      body: StateStreamLayout(
        stream: cubit.stateStream,
        error: AppException('', S.current.something_went_wrong),
        retry: () async {
          await cubit.getListWallets();
        },
        textEmpty: '',
        child: GestureDetector(
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
                          widget.header ?? const SizedBox(height: 0),
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
                            stateChange: (gasFee) {
                              WidgetsBinding.instance
                                  ?.addPostFrameCallback((timeStamp) {
                                setState(() {
                                  if (cubit.balanceWallet != null) {
                                    isCanAction =
                                        gasFee <= (cubit.balanceWallet ?? 0);
                                  }
                                });
                                this.gasFee = gasFee;
                              });
                            },
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
                SizedBox(width: 16.w),
                if (widget.isShowTwoButton ?? false)
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: ButtonGold(
                              haveGradient: !isApproved,
                              background:
                                  isApproved ? fillApprovedButton : null,
                              textColor: isApproved
                                  ? borderApprovedButton
                                  : isCanAction
                                      ? null
                                      : disableText,
                              border: isApproved
                                  ? Border.all(
                                      color: borderApprovedButton,
                                      width: 2,
                                    )
                                  : null,
                              title: S.current.approve,
                              isEnable: isCanAction,
                              fixSize: false,
                              haveMargin: false,
                            ),
                            onTap: () async {
                              if (isCanAction && !isApproved) {
                                final result = await showModalBottomSheet(
                                  backgroundColor: Colors.black,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (_) {
                                    return PopUpApprove(
                                      approve: widget.approve,
                                      addressWallet: cubit.addressWallet ?? '',
                                      accountName:
                                          cubit.nameWallet ?? 'Account',
                                      imageAccount: accountImage,
                                      balanceWallet: cubit.balanceWallet ?? 0,
                                      gasFee: gasFee,
                                      purposeText:
                                          'Give this site permission to access your NFTs',
                                      approveSuccess: (value) {
                                        isCanAction = true;
                                      },
                                    );
                                  },
                                );
                                if (result ?? false) {
                                  setState(() {
                                    isApproved = result;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 25),
                      ],
                    ),
                  )
                else
                  const SizedBox(height: 0),
                Expanded(
                  child: GestureDetector(
                    child: ButtonGold(
                      textColor: isApproved || !(widget.isShowTwoButton ?? false)
                          ? null
                          : disableText,
                      fixSize: false,
                      haveMargin: false,
                      title: widget.textActiveButton,
                      isEnable:
                          isApproved || !(widget.isShowTwoButton ?? false),
                    ),
                    onTap: () async {
                      if (isApproved){
                        final navigator = Navigator.of(context);
                        cubit.changeLoadingState(isShow: true);
                        await widget.action();
                        cubit.changeLoadingState(isShow: false);
                        navigator.pop();
                      }
                    },
                  ),
                ),
                SizedBox(width: 16.w),
              ],
            ),
            const SizedBox(height: 38)
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
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    '${ImageAssets.image_avatar}$accountImage'
                    '.png',
                  ),
                ),
              ),
              height: 40,
              width: 40,
            ),
            const SizedBox(
              width: 8,
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
                        final data = snapshot.data ?? 'Account';
                        return Text(
                          data,
                          style: textNormal(
                            AppTheme.getInstance().whiteColor(),
                            16.sp,
                          ).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 8,
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
                            14,
                          ),
                        );
                      },
                    ),
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
                        16,
                      ),
                    );
                  },
                )
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
