import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/place_bid/bloc/place_bid_cubit.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_bloc.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/custom_form.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeBid { BUY_OUT, PLACE_BID }

class PlaceBid extends StatelessWidget {
  const PlaceBid({
    Key? key,
    required this.balance,
    required this.nftOnAuction,
    required this.typeBid,
  }) : super(key: key);
  final double balance;
  final NFTOnAuction nftOnAuction;
  final TypeBid typeBid;

  @override
  Widget build(BuildContext context) {
    final NFTDetailBloc nftDetailBloc =
        nftKey.currentState?.bloc ?? NFTDetailBloc();
    final PlaceBidCubit cubit = PlaceBidCubit();
    String bidValue = typeBid == TypeBid.PLACE_BID
        ? ''
        : (nftOnAuction.buyOutPrice ?? 0).toString();
    if (typeBid == TypeBid.BUY_OUT) {
      if (balance < (nftOnAuction.buyOutPrice ?? 0)) {
        cubit.warnSink.add(S.current.insufficient_balance);
        cubit.btnSink.add(false);
      } else {
        if((nftOnAuction.buyOutPrice ?? 0) == 0){
          cubit.btnSink.add(false);
        }
        else{
          cubit.warnSink.add('');
          cubit.btnSink.add(true);
        }
      }
    }
    Widget balanceWidget() {
      return Text(
        '${S.current.your_balance} $balance '
        '${nftOnAuction.tokenSymbol}',
        style: textNormalCustom(
          Colors.white.withOpacity(0.7),
          14,
          FontWeight.w400,
        ),
      );
    }

    Widget _yourBid() => Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.current.your_bid,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w600,
            ),
          ),
        );

    Widget _buildRow(String label, double price) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor().withOpacity(0.7),
              16,
              FontWeight.w400,
            ),
          ),
          Text(
            '$price ${nftOnAuction.tokenSymbol}',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w700,
            ),
          ),
        ],
      );
    }

    Widget _cardCurrentBid(String url, String nameToken, double bid) {
      return typeBid == TypeBid.PLACE_BID
          ? CustomForm(
              textValue: (value) {
                if (value.isNotEmpty) {
                  if (balance > double.parse(value) &&
                      double.parse(value) > bid) {
                    cubit.warnSink.add('');
                    bidValue = value;
                    cubit.btnSink.add(true);
                    nftDetailBloc.bidValue = double.parse(value);
                  } else if (balance > double.parse(value) &&
                      double.parse(value) < bid) {
                    cubit.warnSink.add(S.current.you_must_bid_greater);
                    cubit.btnSink.add(false);
                  } else {
                    cubit.btnSink.add(false);
                    cubit.warnSink.add(S.current.you_enter_balance);
                  }
                } else {
                  cubit.btnSink.add(false);
                  cubit.warnSink.add(S.current.you_must_bid);
                }
              },
              hintText: S.current.your_bid,
              suffix: SizedBox(
                child: Row(
                  children: [
                    SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Image.network(url),
                    ),
                    spaceW2,
                    Text(
                      nameToken,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        14,
                        FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
              inputType: TextInputType.number,
            )
          : Container(
              height: 64.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                  color: AppTheme.getInstance().itemBtsColors(),
                  borderRadius: BorderRadius.all(Radius.circular(20.r))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nftOnAuction.buyOutPrice.toString(),
                    style: textNormalCustom(
                      AppTheme.getInstance().textThemeColor(),
                      16,
                      FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: Image.network(url),
                        ),
                        spaceW2,
                        Text(
                          nameToken,
                          style: textNormalCustom(
                            AppTheme.getInstance().textThemeColor(),
                            14,
                            FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
    }

    Widget _spaceButton(BuildContext context) => StreamBuilder<bool>(
          initialData: false,
          stream: cubit.btnStream,
          builder: (ctx, snapshot) {
            final isEnable = snapshot.data!;
            if (isEnable) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ButtonGradient(
                  onPressed: () {},
                  gradient: RadialGradient(
                    center: const Alignment(0.5, -0.5),
                    radius: 4,
                    colors: AppTheme.getInstance().gradientButtonColor(),
                  ),
                  child: Text(
                    typeBid == TypeBid.PLACE_BID
                        ? S.current.place_a_bid
                        : S.current.buy_out,
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
                      typeBid == TypeBid.PLACE_BID
                          ? S.current.place_a_bid
                          : S.current.buy_out,
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
        );

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

    return StateStreamLayout(
      stream: nftDetailBloc.stateStream,
      error: AppException(S.current.error, S.current.something_went_wrong),
      retry: () async {},
      textEmpty: '',
      child: BaseBottomSheet(
        title: S.current.place_a_bid,
        isImage: true,
        text: ImageAssets.ic_close,
        onRightClick: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH20,
              _buildRow(
                  nftOnAuction.currentPrice == 0
                      ? S.current.reserve_price
                      : S.current.current_price,
                  nftOnAuction.currentPrice == 0
                      ? nftOnAuction.reservePrice ?? 0
                      : nftOnAuction.currentPrice ?? 0),
              spaceH8,
              _buildRow(S.current.buy_out, nftOnAuction.buyOutPrice ?? 0),
              spaceH8,
              _buildRow(S.current.price_step, nftOnAuction.priceStep ?? 0),
              spaceH16,
              _yourBid(),
              spaceH5,
              _cardCurrentBid(
                nftOnAuction.urlToken ?? '',
                nftOnAuction.tokenSymbol ?? '',
                nftOnAuction.currentPrice == 0
                    ? (nftOnAuction.reservePrice ?? 0)
                    : (nftOnAuction.currentPrice ?? 0),
              ),
              spaceH8,
              ...[
                warningAmount(),
                spaceH8,
              ],
              balanceWidget(),
              spaceH344,
              _spaceButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
