import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/buy_nft/bloc/buy_nft_cubit.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_bloc.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/form_without_prefix.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyNFT extends StatelessWidget {
  const BuyNFT({
    Key? key,
    required this.balance,
    required this.nftMarket,
    required this.walletAddress,
  }) : super(key: key);
  final double balance;
  final NftMarket nftMarket;
  final String walletAddress;

  @override
  Widget build(BuildContext context) {
    final cubit = BuyNftCubit();
    final nftDetailCubit = nftKey.currentState?.bloc ?? NFTDetailBloc();
    void emitValue(String value) {
      if (value.isNotEmpty) {
        if (int.parse(value) <= (nftMarket.totalCopies ?? 1)) {
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
      return StreamBuilder<int>(
        stream: cubit.amountStream,
        builder: (context, snapshot) {
          final total = (nftMarket.price ?? 0) * (snapshot.data ?? 0);
          cubit.total = total;
          if (total > balance) {
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
                        child: Image.network(nftMarket.urlToken ?? ''),
                      ),
                      spaceW4,
                      Text(
                        '$total ${nftMarket.symbolToken}',
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
                      child: Image.network(nftMarket.urlToken ?? ''),
                    ),
                    spaceW4,
                    Text(
                      '${nftMarket.price} ${nftMarket.symbolToken}',
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
            orderId: nftMarket.orderId.toString(),
            numberOfCopies: cubit.amountValue.toString(),
            contractAddress: nft_sales_address_dev2,
          )
          .then(
            (hexString) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Approve(
                  needApprove: true,
                  payValue: cubit.total.toString(),
                  tokenAddress: nftMarket.token,
                  title: S.current.buy_nft,
                  header: Column(
                    children: [
                      buildRowCustom(
                        isPadding: false,
                        title: '${S.current.from}:',
                        child: Text(
                          walletAddress.formatAddressWalletConfirm(),
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
                          (nftMarket.owner ?? '').formatAddressWalletConfirm(),
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
                          '${nftMarket.price} ${nftMarket.symbolToken}',
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
                          '${cubit.amountValue.toDouble() * (nftMarket.price ?? 0)} '
                          '${nftMarket.symbolToken}',
                          style: textNormalCustom(
                            AppTheme.getInstance().fillColor(),
                            20,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  textActiveButton: S.current.buy_nft,
                  hexString: hexString,
                  typeApprove: TYPE_CONFIRM_BASE.BUY_NFT,
                ),
              ),
            ),
          );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: StateStreamLayout(
          stream: nftDetailCubit.stateStream,
          error: AppException(S.current.error, S.current.something_went_wrong),
          retry: () {
            refresh();
          },
          textEmpty: '',
          child: BaseBottomSheet(
            isImage: true,
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
                              FormWithOutPrefix(
                                textValue: (value) {
                                  emitValue(value);
                                },
                                hintText: S.current.enter_quantity,
                                typeForm: TypeFormWithoutPrefix.IMAGE_FT_TEXT,
                                cubit: BuyNftCubit,
                                txtController: TextEditingController(),
                                quantityOfAll: nftMarket.totalCopies,
                                imageAsset: nftMarket.urlToken,
                                isTokenOrQuantity: false,
                              ),
                              warningAmount(),
                              spaceH20,
                              pricePerOne(),
                              spaceH12,
                              divider,
                              spaceH12,
                              showTotalPayment(),
                              spaceH4,
                              Text(
                                '${S.current.your_balance} ${balance} '
                                '${nftMarket.symbolToken}',
                                style: textNormalCustom(
                                  Colors.white.withOpacity(0.7),
                                  14,
                                  FontWeight.w400,
                                ),
                              ),
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
