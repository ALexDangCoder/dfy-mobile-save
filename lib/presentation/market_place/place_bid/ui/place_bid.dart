import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/place_bid/bloc/place_bid_cubit.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_bloc.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/custom_form.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceBid extends StatefulWidget {
  const PlaceBid({Key? key, required this.balance}) : super(key: key);
  final double balance;

  @override
  _PlaceBidState createState() => _PlaceBidState();
}

class _PlaceBidState extends State<PlaceBid> {
  late final NFTDetailBloc nftDetailBloc;
  late final NFTOnAuction nftOnAuction;
  late final PlaceBidCubit cubit;
  String bidValue = '';

  void initData() {
    nftDetailBloc = nftKey.currentState?.bloc ?? NFTDetailBloc();
    nftOnAuction = nftDetailBloc.nftOnAuction;
    cubit = PlaceBidCubit();
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      stream: nftDetailBloc.stateStream,
      error: AppException(S.current.error, S.current.something_went_wrong),
      retry: () async {
        await nftDetailBloc.callWeb3(
          context,
          bidValue,
          MarketType.SALE,
        );
      },
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
                      : S.current.your_bid,
                  nftOnAuction.currentPrice == 0
                      ? nftOnAuction.reservePrice ?? 0
                      : nftOnAuction.currentPrice ?? 0),
              spaceH8,
              _buildRow(S.current.buy_out, nftOnAuction.buyOutPrice ?? 0),
              spaceH8,
              _buildRow(S.current.price_step, nftOnAuction.priceStep ?? 0),
              spaceH16,
              _currentBid(),
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
              Text(
                '${S.current.your_balance} ${widget.balance} '
                '${nftOnAuction.tokenSymbol}',
                style: textNormalCustom(
                  Colors.white.withOpacity(0.7),
                  14,
                  FontWeight.w400,
                ),
              ),
              spaceH344,
              _spaceButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget balance() {
    return Text(
      '${S.current.your_balance} ${widget.balance} '
      '${nftOnAuction.tokenSymbol}',
      style: textNormalCustom(
        Colors.white.withOpacity(0.7),
        14,
        FontWeight.w400,
      ),
    );
  }

  Widget _currentBid() => Align(
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
    return CustomForm(
      textValue: (value) {
        if (value.isNotEmpty) {
          if (widget.balance > double.parse(value) &&
              double.parse(value) > bid) {
            cubit.warnSink.add('');
            bidValue = value;
            cubit.btnSink.add(true);
            nftDetailBloc.bidValue = double.parse(value);
          } else if (widget.balance > double.parse(value) &&
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
        width: 30.w,
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
                onPressed: () {
                  nftDetailBloc.callWeb3(
                    context,
                    bidValue,
                    MarketType.AUCTION,
                  );
                },
                gradient: RadialGradient(
                  center: const Alignment(0.5, -0.5),
                  radius: 4,
                  colors: AppTheme.getInstance().gradientButtonColor(),
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
}
