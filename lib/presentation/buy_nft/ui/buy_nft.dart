import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/buy_nft/bloc/buy_nft_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/base_items/base_fail.dart';
import 'package:Dfy/widgets/base_items/base_success.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/form/form_without_prefix.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyNFT extends StatefulWidget {
  const BuyNFT({
    Key? key,
    required this.nftMarket,
    required this.marketId,
  }) : super(key: key);
  final NftMarket nftMarket;
  final String marketId;

  @override
  State<BuyNFT> createState() => _BuyNFTState();
}

class _BuyNFTState extends State<BuyNFT> {
  late final BuyNftCubit cubit;

  @override
  void initState() {
    cubit = BuyNftCubit();
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    getBalance();
    super.initState();
  }

  Future<void> getBalance() async {
    await cubit
        .getBalanceToken(
      ofAddress: PrefsService.getCurrentBEWallet(),
      tokenAddress: widget.nftMarket.token ?? '',
    )
        .then((value) {
      if (widget.nftMarket.nftStandard == ERC_721) {
        if (value > (widget.nftMarket.price ?? 0)) {
          cubit.warnSink.add('');
          cubit.btnSink.add(true);
        } else {
          cubit.warnSink.add(S.current.insufficient_balance);
          cubit.btnSink.add(false);
        }
      }
    });
  }

  void emitValue(String value) {
    if (value.isNotEmpty) {
      if (int.parse(value) <= (widget.nftMarket.totalCopies ?? 1)) {
        cubit.amountSink.add(int.parse(value));
        cubit.warnSink.add('');
        cubit.btnSink.add(true);
      } else {
        cubit.warnSink.add(
          S.current.you_enter_greater,
        );
        cubit.btnSink.add(false);
      }
    } else {
      cubit.amountSink.add(0);
      cubit.warnSink.add(S.current.you_must);
      cubit.btnSink.add(false);
    }
  }

  @override
  void dispose() {
    cubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget warningAmount() {
      return StreamBuilder<String>(
        initialData: '',
        stream: cubit.warnStream,
        builder: (BuildContext context, snapshot) {
          return Visibility(
            visible: snapshot.data!.isNotEmpty,
            child: Column(
              children: [
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  width: 343.w,
                  // height: 30.h,
                  child: Text(
                    snapshot.data ?? '',
                    style: textNormal(AppTheme.getInstance().wrongColor(), 12)
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Widget showTotalPayment() {
      return widget.nftMarket.nftStandard == ERC_721
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.total_payment_upper,
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor(),
                    16.sp,
                    FontWeight.w600,
                  ),
                ),
                Wrap(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: Image.network(widget.nftMarket.urlToken ?? ''),
                        ),
                        spaceW4,
                        Text(
                          '${widget.nftMarket.price} ${widget.nftMarket.symbolToken}',
                          style: textNormalCustom(
                            AppTheme.getInstance().textThemeColor(),
                            20.sp,
                            FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
          : StreamBuilder<int>(
              stream: cubit.amountStream,
              builder: (context, snapshot) {
                final total =
                    (widget.nftMarket.price ?? 0) * (snapshot.data ?? 0);
                cubit.total = total;
                if (total > cubit.balanceValue) {
                  cubit.warnSink.add(S.current.insufficient_balance);
                  cubit.btnSink.add(false);
                } else {
                  cubit.warnSink.add('');
                  cubit.btnSink.add(true);
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.current.total_payment_upper,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        16.sp,
                        FontWeight.w600,
                      ),
                    ),
                    Wrap(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: Image.network(
                                widget.nftMarket.urlToken ?? '',
                              ),
                            ),
                            spaceW4,
                            Text(
                              '$total ${widget.nftMarket.symbolToken}',
                              style: textNormalCustom(
                                AppTheme.getInstance().textThemeColor(),
                                20.sp,
                                FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              },
            );
    }

    ConstrainedBox pricePerOne() {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 24.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                S.current.item_price,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16.sp,
                  FontWeight.w400,
                ),
              ),
            ),
            Wrap(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Image.network(widget.nftMarket.urlToken ?? ''),
                    ),
                    spaceW4,
                    Text(
                      '${widget.nftMarket.price} ${widget.nftMarket.symbolToken}',
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        16.sp,
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
    }

    Future<void> refresh() async {
      await cubit
          .getBuyNftData(
            context: context,
            orderId: widget.nftMarket.orderId.toString(),
            numberOfCopies: cubit.amountValue.toString(),
            contractAddress: nft_sales_address_dev2,
          )
          .then(
            (hexString) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Approve(
                  needApprove: true,
                  payValue: cubit.total.toString(),
                  tokenAddress: widget.nftMarket.token,
                  title: S.current.buy_nft,
                  header: Column(
                    children: [
                      buildRowCustom(
                        isPadding: false,
                        title: '${S.current.from}:',
                        child: Text(
                          PrefsService.getCurrentBEWallet()
                              .formatAddressWalletConfirm(),
                          style: textNormalCustom(
                            AppTheme.getInstance().textThemeColor(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                      buildRowCustom(
                        isPadding: false,
                        title: '${S.current.to}:',
                        child: Text(
                          (widget.nftMarket.owner ?? '')
                              .formatAddressWalletConfirm(),
                          style: textNormalCustom(
                            AppTheme.getInstance().textThemeColor(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceH20,
                      line,
                      spaceH20,
                      buildRowCustom(
                        isPadding: false,
                        title: S.current.price,
                        child: Text(
                          '${widget.nftMarket.price} ${widget.nftMarket.symbolToken}',
                          style: textNormalCustom(
                            AppTheme.getInstance().textThemeColor(),
                            20,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                      buildRowCustom(
                        isPadding: false,
                        title: '${S.current.total_payment_normal}:',
                        child: Text(
                          '${cubit.amountValue.toDouble() * (widget.nftMarket.price ?? 0)} '
                          '${widget.nftMarket.symbolToken}',
                          style: textNormalCustom(
                            AppTheme.getInstance().fillColor(),
                            20,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onSuccessSign: (context, data) async {
                    Navigator.pop(context);
                    cubit.buyNftReq(
                      BuyNftRequest(
                        widget.marketId,
                        widget.nftMarket.nftStandard == ERC_721
                            ? 1
                            : cubit.amountValue,
                        data,
                      ),
                    );
                    await cubit.importNft(
                      contract: widget.nftMarket.collectionAddress ?? '',
                      id: int.parse(widget.nftMarket.nftTokenId ?? ''),
                      address: PrefsService.getCurrentBEWallet(),
                    );
                    await showLoadSuccess(context)
                        .then((value) => Navigator.pop(context))
                        .then(
                          (value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BaseSuccess(
                                title: S.current.buy_nft,
                                content: S.current.congratulation,
                                callback: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        );
                  },
                  onErrorSign: (context) async {
                    Navigator.pop(context);
                    await showLoadFail(context)
                        .then((_) => Navigator.pop(context))
                        .then(
                          (value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BaseFail(
                                title: S.current.buy_nft,
                                onTapBtn: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        );
                  },
                  textActiveButton: S.current.buy_nft,
                  hexString: hexString,
                  spender: nft_sales_address_dev2,
                ),
              ),
            ),
          );
    }

    Widget form() {
      return widget.nftMarket.nftStandard == ERC_721
          ? Container(
              height: 64.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppTheme.getInstance().itemBtsColors(),
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.nftMarket.totalCopies.toString(),
                    style: textNormalCustom(
                      AppTheme.getInstance().textThemeColor(),
                      16.sp,
                      FontWeight.w400,
                    ),
                  ),
                  Text(
                    '${widget.nftMarket.totalCopies} ${S.current.of_all}'
                    ' ${widget.nftMarket.totalCopies}',
                    style: textNormalCustom(
                      AppTheme.getInstance().textThemeColor(),
                      16.sp,
                      FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          : FormWithOutPrefix(
              textValue: (value) {
                emitValue(value);
              },
              hintText: S.current.enter_quantity,
              typeForm: TypeFormWithoutPrefix.IMAGE_FT_TEXT,
              cubit: BuyNftCubit,
              txtController: TextEditingController(),
              quantityOfAll: widget.nftMarket.totalCopies,
              imageAsset: widget.nftMarket.urlToken,
              isTokenOrQuantity: false,
            );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException(S.current.error, S.current.something_went_wrong),
          retry: () {
            refresh();
          },
          textEmpty: '',
          child: BaseDesignScreen(
            isImage: true,
            onRightClick: () {
              Navigator.popUntil(context, (route) => route.settings.name == AppRouter.listNft);
            },
            text: ImageAssets.ic_close,
            title: '${S.current.buy} NFT',
            child: Column(
              children: [
                spaceH24,
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.current.quantity,
                                style: textNormalCustom(
                                  AppTheme.getInstance().textThemeColor(),
                                  14.sp,
                                  FontWeight.w400,
                                ),
                              ),
                              spaceH4,
                              form(),
                              warningAmount(),
                              spaceH20,
                              pricePerOne(),
                              spaceH12,
                              divider,
                              spaceH12,
                              showTotalPayment(),
                              spaceH4,
                              StreamBuilder<double>(
                                  stream: cubit.balanceStream,
                                  builder: (context, snapshot) {
                                    return Text(
                                      '${S.current.your_balance} ${snapshot.data}'
                                      '${widget.nftMarket.symbolToken}',
                                      style: textNormalCustom(
                                        Colors.white.withOpacity(0.7),
                                        14,
                                        FontWeight.w400,
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 300.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                StreamBuilder<bool>(
                  initialData: false,
                  stream: cubit.btnStream,
                  builder: (ctx, snapshot) {
                    final isEnable = snapshot.data!;
                    if (isEnable) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ButtonGradient(
                          onPressed: () {
                            refresh();
                          },
                          gradient: RadialGradient(
                            center: const Alignment(0.5, -0.5),
                            radius: 4,
                            colors:
                                AppTheme.getInstance().gradientButtonColor(),
                          ),
                          child: Text(
                            S.current.buy_nft,
                            style: textNormal(
                              AppTheme.getInstance().textThemeColor(),
                              20,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ErrorButton(
                          child: Center(
                            child: Text(
                              S.current.buy_nft,
                              style: textNormal(
                                AppTheme.getInstance().textThemeColor(),
                                20,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                spaceH38,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
