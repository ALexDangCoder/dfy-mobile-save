import 'dart:async';
import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/market_place/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_bloc.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_fail.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_submit.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_success.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/bloc/approve_state.dart';
import 'package:Dfy/widgets/base_items/base_success.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import 'component/estimate_gas_fee.dart';
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
  final bool? needApprove;
  final int? flexTitle;
  final int? flexContent;
  final String? purposeText;
  final String textActiveButton;

  /// [gasLimitFirst] is min of gas limit
  final double gasLimitInit;
  final bool? showPopUp;
  final TYPE_CONFIRM_BASE typeApprove;
  final CreateCollectionCubit? createCollectionCubit;
  final String? payValue;
  final String? tokenAddress;
  final String? spenderAddress;

  const Approve({
    Key? key,
    required this.title,
    this.listDetail,
    this.warning,
    this.needApprove = false,
    required this.textActiveButton,
    this.header,
    required this.gasLimitInit,
    this.showPopUp = false,
    this.purposeText,
    this.flexTitle,
    this.flexContent,
    required this.typeApprove,
    this.createCollectionCubit,
    this.payValue,
    this.tokenAddress,
    this.spenderAddress,
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
  late final NFTDetailBloc nftDetailBloc;
  bool gasFeeIsFitToSign = false;

  void initData(TYPE_CONFIRM_BASE typeBase) {
    switch (typeBase) {
      case TYPE_CONFIRM_BASE.BUY_NFT:
        nftDetailBloc = nftKey.currentState!.bloc;
        getNonce();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = ApproveCubit();
    cubit.type = widget.typeApprove;
    accountImage = cubit.randomAvatar();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      heightScaffold = scaffoldKey.currentContext?.size?.height;
    });
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);

    /// get wallet information
    cubit.getListWallets();

    if (widget.needApprove ?? false) {
      cubit.checkApprove(
        payValue: widget.payValue ?? '',
        tokenAddress: widget.tokenAddress ?? ' ',
        spenderAddress: widget.spenderAddress ?? '',
      );
    }
    initData(widget.typeApprove);
  }

  Future<void> getNonce() async {
    nonce = await nftDetailBloc.getNonceWeb3();
  }

  /// Function approve

  Future<void> approve() async {
    showLoading();
    /// function approve
    ///

  }

  ///  Action sign (use this base call NamLV)
  ///  [gasLimitFinal] is value of gas limit final
  ///  don't use gas limit was passed into constructor
  ///   [gasPriceFinal] is value of gas price final
  ///  don't use gas price state or gas price from stream
  ///  price in cubit.gasPriceFirstSubject.value can false
  /// user can edit gas limit and gas price so
  /// DON'T USE [gasLimitFirst] AND THE FIRST GAS PRICE
  ///  USE [gasLimitFinal] AND [gasPriceFinal]
  Future<void> signTransaction(
    double gasLimitFinal,
    double gasPriceFinal,
  ) async {
    switch (widget.typeApprove) {
      case TYPE_CONFIRM_BASE.BUY_NFT:
        {
          await cubit.signTransactionWithData(
            walletAddress: nftDetailBloc.walletAddress,
            contractAddress: nft_sales_address_dev2,
            nonce: nonce.toString(),
            chainId: Get.find<AppConstants>().chaninId,
            gasPrice: (cubit.gasPriceFirstSubject.value / 10e8).toStringAsFixed(0),
            gasLimit: nftDetailBloc.gasLimit,
            hexString: nftDetailBloc.hexString,
          );
        }
        break;
      case TYPE_CONFIRM_BASE.PLACE_BID:
        {
          break;
        }
      case TYPE_CONFIRM_BASE.SEND_NFT:
        {
          break;
        }
      case TYPE_CONFIRM_BASE.CREATE_COLLECTION:
        {
          await cubit.signTransactionWithData(
            walletAddress: cubit.addressWallet ?? '',
            contractAddress: nft_sales_address_dev2,
            nonce: (widget.createCollectionCubit?.transactionNonce ?? 0)
                .toString(),
            chainId: Get.find<AppConstants>().chaninId,
            gasPrice: (gasPriceFinal / 10e8).toStringAsFixed(0),
            gasLimit: gasLimitFinal.toString(),
            hexString: widget.createCollectionCubit?.transactionData ?? '',
          );
        }
        break;
      case TYPE_CONFIRM_BASE.PUT_ON_MARKET:
        {
          showLoading();
          Timer(Duration(seconds: 2), () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
        break;
      case TYPE_CONFIRM_BASE.SEND_TOKEN:
        // TODO: Handle this case.
        break;
      case TYPE_CONFIRM_BASE.SEND_OFFER:
        // TODO: Handle this case.
        break;
    }
  }

  /// show dialog loading
  void showLoading() {
    Navigator.push(
      context,
      PageRouteBuilder(
        reverseTransitionDuration: Duration.zero,
        transitionDuration: Duration.zero,
        pageBuilder: (_, animation, ___) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.4),
            body: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
                child: const TransactionSubmit(),
              ),
            ),
          );
        },
        opaque: false,
      ),
    );
  }

  /// show dialog Error
  void showLoadFail() {
    Navigator.push(
      context,
      PageRouteBuilder(
        reverseTransitionDuration: Duration.zero,
        transitionDuration: Duration.zero,
        pageBuilder: (_, animation, ___) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.4),
            body: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
                child: const TransactionSubmitFail(),
              ),
            ),
          );
        },
        opaque: false,
      ),
    );
  }


  /// show dialog success
  void showLoadSuccess() {
    Navigator.push(
      context,
      PageRouteBuilder(
        reverseTransitionDuration: Duration.zero,
        transitionDuration: Duration.zero,
        pageBuilder: (_, animation, ___) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.4),
            body: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
                child: const TransactionSubmitSuccess(),
              ),
            ),
          );
        },
        opaque: false,
      ),
    );
  }


  /// show  BottomSheet approve
  Future<dynamic> showPopupApprove() async {
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
          approve: () async {
            await approve();
          },
          addressWallet: cubit.addressWallet ?? '',
          accountName: cubit.nameWallet ?? 'Account',
          imageAccount: accountImage,
          balanceWallet: cubit.balanceWallet ?? 0,
          gasFee: gasFee,
          purposeText: widget.purposeText ??
              S.current.give_this_site_permission_to_access_your_nft,
        );
      },
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: cubit,
      listener: (context, state) {
        if (state is BuySuccess) {
          cubit.buyNftRequest(
            BuyNftRequest(
              nftDetailBloc.nftMarketId,
              1,
              state.txh,
            ),
          );
          cubit.emitJsonNftToWalletCore(
            contract: cubit.nftMarket.collectionAddress ?? '',
            id: int.parse(cubit.nftMarket.nftTokenId ?? ''),
            address: nftDetailBloc.walletAddress,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BaseSuccess(
                title: S.current.buy_nft,
                content: S.current.congratulation,
                callback: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(
                        index: 1,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        if (state is BuyFail) {
          Fluttertoast.showToast(msg: 'Fail');
        }
      },
      child: Scaffold(
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
                                      gasFeeIsFitToSign =
                                          gasFee <= (cubit.balanceWallet ?? 0);
                                    }
                                  });
                                  this.gasFee = gasFee;
                                });
                              },
                              cubit: cubit,
                              gasLimitStart: widget.gasLimitInit,
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
                  if (widget.needApprove ?? false)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: StreamBuilder<bool>(
                              stream: cubit.isApprovedStream,
                              builder: (context, snapshot) {
                                final isApproved = snapshot.data ?? false;
                                return GestureDetector(
                                  child: ButtonGold(
                                    haveGradient: !isApproved,
                                    background:
                                    isApproved ? fillApprovedButton : null,
                                    textColor: isApproved
                                        ? borderApprovedButton
                                        : gasFeeIsFitToSign
                                        ? null
                                        : disableText,
                                    border: isApproved
                                        ? Border.all(
                                      color: borderApprovedButton,
                                      width: 2,
                                    )
                                        : null,
                                    title: S.current.approve,
                                    isEnable: gasFeeIsFitToSign,
                                    fixSize: false,
                                    haveMargin: false,
                                  ),
                                  onTap: ()  {
                                      showPopupApprove();
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
                    const SizedBox(height: 0),
                  Expanded(
                    child: StreamBuilder<bool>(
                      stream: cubit.isApprovedStream,
                      builder: (context, snapshot) {
                        final isApproved = snapshot.data ?? false;
                        return GestureDetector(
                          child: ButtonGold(
                            textColor:
                                isApproved || !(widget.needApprove ?? false)
                                    ? null
                                    : disableText,
                            fixSize: false,
                            haveMargin: false,
                            title: widget.textActiveButton,
                            isEnable: (isApproved ||
                                    !(widget.needApprove ?? false)) &&
                                gasFeeIsFitToSign,
                          ),
                          onTap: () {
                            if ((isApproved ||
                                    !(widget.needApprove ?? false)) &&
                                gasFeeIsFitToSign) {
                              signTransaction(
                                cubit.gasLimit ?? widget.gasLimitInit,
                                cubit.gasPrice ?? 0,
                              );
                            }
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
