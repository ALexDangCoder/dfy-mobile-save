import 'dart:async';
import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/collection_list/ui/collection_list.dart';
import 'package:Dfy/presentation/put_on_market/model/nft_put_on_market_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/bloc/approve_state.dart';
import 'package:Dfy/widgets/approve/extension/call_api_be.dart';
import 'package:Dfy/widgets/approve/extension/call_core_logic_extention.dart';
import 'package:Dfy/widgets/approve/extension/common_extension.dart';
import 'package:Dfy/widgets/approve/extension/get_gas_limit_extension.dart';
import 'package:Dfy/widgets/approve/ui/component/estimate_gas_fee.dart';
import 'package:Dfy/widgets/base_items/base_fail.dart';
import 'package:Dfy/widgets/base_items/base_success.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'component/pop_up_approve.dart';

class Approve extends StatefulWidget {
  final String title;
  final List<DetailItemApproveModel>? listDetail;
  final Widget? warning;
  final Widget? header;
  final PutOnMarketModel? putOnMarketModel;
  final bool? needApprove;
  final int? flexTitle;
  final String? errorTextSign;
  final int? flexContent;
  final Function(BuildContext)? onErrorSign;
  final Function(BuildContext, String)? onSuccessSign;
  final String? purposeText;
  final String textActiveButton;
  final String? spender;
  final Map<String, dynamic>? createNftMap;
  final int? collectionType;

  /// [gasLimitFirst] is min of gas limit
  final String? hexString;

  final TYPE_CONFIRM_BASE typeApprove;
  final String? payValue;
  final String? tokenAddress;
  final Map<String, dynamic>? request;

  const Approve({
    Key? key,
    required this.title,
    this.listDetail,
    this.spender,
    this.warning,
    this.needApprove = false,
    required this.textActiveButton,
    this.header,
    this.purposeText,
    this.flexTitle,
    this.flexContent,
    required this.typeApprove,
    this.payValue,
    this.tokenAddress,
    this.hexString,
    this.putOnMarketModel,
    this.request,
    this.createNftMap,
    this.collectionType,
    this.errorTextSign,
    this.onErrorSign,
    this.onSuccessSign,
  }) : super(key: key);

  @override
  _ApproveState createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  late final ApproveCubit cubit;
  GlobalKey scaffoldKey = GlobalKey();
  double? heightScaffold;
  late int accountImage;
  double gasFee = 0;
  int nonce = 0;
  GlobalKey bottomKey = GlobalKey();
  double heightOfBottom = 0;
  bool isShowLoading = false;

  void initData(TYPE_CONFIRM_BASE typeBase) {
    cubit.type = widget.typeApprove;
    accountImage = cubit.randomAvatar();
    cubit.context = context;
    cubit.putOnMarketModel = widget.putOnMarketModel;
    cubit.needApprove = widget.needApprove ?? false;
    cubit.payValue = widget.payValue ?? '';
    cubit.tokenAddress = widget.tokenAddress ?? '';
    cubit.spender = widget.spender;
    cubit.hexString = widget.hexString;
    cubit.errorTextSign = widget.errorTextSign ?? '';
  }

  @override
  void initState() {
    super.initState();
    cubit = ApproveCubit();
    initData(widget.typeApprove);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      heightScaffold = scaffoldKey.currentContext?.size?.height;
      heightOfBottom = bottomKey.currentContext?.size?.height ?? 0;
      setState(() {});
    });

    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);

    /// get wallet information
    cubit.getListWallets();
  }

  /// Function approve

  Future<void> approve() async {
    cubit.checkingApprove = true;
    unawaited(
      cubit.approve(),
    );
    isShowLoading = true;
    await showLoading(context);
    isShowLoading = false;
  }

  Future<void> signTransaction(
    double gasLimitFinal,
    double gasPriceFinal,
  ) async {
    final String gasPriceString = (gasPriceFinal / 1e9).toStringAsFixed(0);
    final String gasLimitString = gasLimitFinal.toStringAsFixed(0);
    unawaited(showLoading(context));
    final nonce = await cubit.getNonce();
    await cubit.signTransactionWithData(
      walletAddress: cubit.addressWallet ?? '',
      contractAddress: widget.spender ?? cubit.getSpender(),
      nonce: nonce.toString(),
      chainId: Get.find<AppConstants>().chaninId,
      gasPrice: gasPriceString,
      gasLimit: gasLimitString,
      hexString: widget.hexString ?? '',
    );
  }

  Future<void> approveFail() async {
    final navigator = Navigator.of(context);
    if (isShowLoading) {
      navigator.pop();
    }
    await showLoadFail(context);
    navigator.pop();
    cubit.checkingApprove = null;
    cubit.emit(ApproveInitState());
  }

  Future<void> approveSuccess() async {
    if (isShowLoading) {
      Navigator.pop(context);
    }
    final navigator = Navigator.of(context);
    unawaited(cubit.gesGasLimitFirst(widget.hexString ?? ''));
    await showLoadSuccess(context);
    navigator.pop();
    cubit.checkingApprove = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: cubit,
      listener: (context, state) {
        if (state is SignSuccess) {
          caseNavigatorSuccess(state.type, state.txh);
        }
        if (state is SignFail) {
          caseNavigatorFail(state.type, state.message);
        }
        if (state is ApproveSuccess) {
          approveSuccess();
        }
        if (state is ApproveFail) {
          approveFail();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException('', S.current.something_went_wrong),
          retry: () async {
            await cubit.getListWallets();
          },
          textEmpty: '',
          child: Stack(
            children: [
              Scaffold(
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  widget.header ?? const SizedBox(height: 0),
                                  ...(widget.listDetail ?? []).map(
                                    (item) => Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: widget.flexTitle ?? 4,
                                              child: Text(
                                                item.title,
                                                style: textNormal(
                                                  AppTheme.getInstance()
                                                      .whiteColor()
                                                      .withOpacity(0.7),
                                                  14,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: widget.flexContent ?? 6,
                                              child: Text(
                                                item.value,
                                                style: item.isToken ?? false
                                                    ? textNormalCustom(
                                                        AppTheme.getInstance()
                                                            .fillColor(),
                                                        20,
                                                        FontWeight.w600,
                                                      )
                                                    : textNormal(
                                                        AppTheme.getInstance()
                                                            .whiteColor(),
                                                        16,
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
                                        widget.warning ??
                                            const SizedBox(height: 0),
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
                                  StreamBuilder<bool>(
                                    stream: cubit.isApprovedStream,
                                    builder: (context, snapshot) {
                                      final data = snapshot.data ?? false;
                                      if (data ||
                                          !(widget.needApprove ?? false)) {
                                        return Column(
                                          children: [
                                            EstimateGasFee(
                                              cubit: cubit,
                                            ),
                                          ],
                                        );
                                      } else {
                                        return const SizedBox(height: 0);
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom <=
                                            160
                                        ? heightOfBottom
                                        : 0,
                                  )
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  key: bottomKey,
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().bgBtsColor(),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 16.w),
                          if (widget.needApprove ?? false)
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: StreamBuilder<bool>(
                                      stream: cubit.isApprovedStream,
                                      builder: (context, snapshot) {
                                        final isApproved =
                                            snapshot.data ?? false;
                                        return GestureDetector(
                                          child: ButtonGold(
                                            haveGradient: !isApproved,
                                            background: isApproved
                                                ? fillApprovedButton
                                                : null,
                                            textColor: isApproved
                                                ? borderApprovedButton
                                                : null,
                                            border: isApproved
                                                ? Border.all(
                                                    color: borderApprovedButton,
                                                    width: 2,
                                                  )
                                                : null,
                                            title: isApproved
                                                ? S.current.approved
                                                : S.current.approve,
                                            isEnable: true,
                                            fixSize: false,
                                            haveMargin: false,
                                          ),
                                          onTap: () {
                                            if (!isApproved) {
                                              cubit.getGasLimitApprove(
                                                context: context,
                                                contractAddress:
                                                    widget.tokenAddress ?? '',
                                              );
                                              showPopupApprove();
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                ],
                              ),
                            )
                          else
                            const SizedBox(
                              height: 0,
                              width: 0,
                            ),
                          Expanded(
                            child: StreamBuilder<bool>(
                              stream: cubit.isApprovedStream,
                              builder: (context, snapshot) {
                                final isApproved = snapshot.data ?? false;
                                return StreamBuilder<bool>(
                                  stream: cubit.canActionStream,
                                  builder: (context, snapshot) {
                                    final isCanAction = snapshot.data ?? false;
                                    return GestureDetector(
                                      child: ButtonGold(
                                        textColor: (isApproved ||
                                                    !(widget.needApprove ??
                                                        false)) &&
                                                isCanAction
                                            ? null
                                            : disableText,
                                        fixSize: false,
                                        haveMargin: false,
                                        title: widget.textActiveButton,
                                        isEnable: (isApproved ||
                                                !(widget.needApprove ??
                                                    false)) &&
                                            isCanAction,
                                      ),
                                      onTap: () {
                                        if ((isApproved ||
                                                !(widget.needApprove ??
                                                    false)) &&
                                            isCanAction) {
                                          signTransaction(
                                            cubit.gasLimit ??
                                                cubit.gasLimitFirst ??
                                                0,
                                            cubit.gasPrice ?? 1e9,
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> caseNavigatorSuccess(TYPE_CONFIRM_BASE type, String data) async {
    final navigator = Navigator.of(context);
    if (widget.onSuccessSign != null) {
      widget.onSuccessSign!(context, data);
    } else {
      switch (type) {
        case TYPE_CONFIRM_BASE.CREATE_COLLECTION:
          unawaited(showLoading(context));
          await cubit.createCollection(
            type: widget.collectionType ?? 0,
            mapRawData: widget.createNftMap ?? {},
            txhHash: data,
          );
          await showLoadSuccess(context)
              .then((value) => navigator.popUntil((route) => route.isFirst))
              .then(
                (value) => navigator.push(
                  MaterialPageRoute(
                    builder: (_) => BaseSuccess(
                      title: S.current.create_collection,
                      content: S.current.create_collection_successfully,
                      callback: () {
                        navigator.pop();
                        navigator.push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => CollectionList(
                              typeScreen: PageRouter.MY_ACC,
                              addressWallet: cubit.addressWallet,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
          break;
        case TYPE_CONFIRM_BASE.CREATE_SOFT_NFT:
          unawaited(showLoading(context));
          await cubit.createSoftNft(
            txhHash: data,
            mapRawData: widget.createNftMap ?? {},
          );
          await showLoadSuccess(context)
              .then((value) => navigator.popUntil((route) => route.isFirst))
              .then(
                (value) => navigator.push(
                  MaterialPageRoute(
                    builder: (_) => BaseSuccess(
                      title: S.current.create_nft,
                      content: S.current.create_nft_successfully,
                      callback: () {
                        navigator.pop();
                        navigator.push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => CollectionList(
                              typeScreen: PageRouter.MY_ACC,
                              addressWallet: cubit.addressWallet,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
          break;
      }
    }
  }

  Future<void> caseNavigatorFail(TYPE_CONFIRM_BASE type, String data) async {
    final navigator = Navigator.of(context);
    if (widget.onErrorSign != null) {
      widget.onErrorSign!(context);
    } else {
      switch (type) {
        case TYPE_CONFIRM_BASE.BUY_NFT:
          break;
        case TYPE_CONFIRM_BASE.PLACE_BID:
          break;
        case TYPE_CONFIRM_BASE.SEND_OFFER:
          break;
        case TYPE_CONFIRM_BASE.CANCEL_PAWN:
          break;

        ///handle when get create collection txhHash in BC failed
        case TYPE_CONFIRM_BASE.CREATE_COLLECTION:
          unawaited(showLoadFail(context));
          navigator.popUntil((route) => route.isFirst);
          break;
        case TYPE_CONFIRM_BASE.CANCEL_AUCTION:
          unawaited(
            navigator.pushReplacement(
              MaterialPageRoute(
                builder: (context) => BaseFail(
                  title: S.current.cancel_aution,
                  content: S.current.failed,
                  onTapBtn: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          );
          break;
      }
    }
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

extension PopUpApproveExtension on _ApproveState {
  /// show  BottomSheet approve
  void showPopupApprove() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PopUpApprove(
          approve: () {
            approve();
          },
          addressWallet: cubit.addressWallet ?? '',
          accountName: cubit.nameWallet ?? 'Account',
          imageAccount: accountImage,
          balanceWallet: cubit.balanceWallet ?? 0,
          gasFee: gasFee,
          purposeText: widget.purposeText ??
              S.current.give_this_site_permission_to_access_your_nft,
          cubit: cubit,
        ),
      ),
    );
  }
}
