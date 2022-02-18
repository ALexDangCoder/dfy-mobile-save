import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/int_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseActivity extends StatefulWidget {
  final String urlAvatar;
  final String title;
  final int date;
  final Widget childText;
  final String statusIconActivity;
  final int index;
  final DetailCollectionBloc bloc;

  const BaseActivity({
    Key? key,
    required this.urlAvatar,
    required this.title,
    required this.date,
    required this.childText,
    required this.statusIconActivity,
    required this.index,
    required this.bloc,
  }) : super(key: key);

  @override
  State<BaseActivity> createState() => _BaseActivityState();
}

class _BaseActivityState extends State<BaseActivity> {


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceW12,
        GestureDetector(
          onTap: () {
            final list = widget.bloc.listActivity.value;
            late final MarketType type;
            if (list[widget.index].marketStatus ==
                DetailCollectionBloc.NOT_ON_MARKET) {
              type = MarketType.NOT_ON_MARKET;
            } else if (list[widget.index].marketStatus ==
                DetailCollectionBloc.SALE) {
              type = MarketType.SALE;
            } else if (list[widget.index].marketStatus ==
                DetailCollectionBloc.AUCTION) {
              type = MarketType.AUCTION;
            } else {
              type = MarketType.PAWN;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return NFTDetailScreen(
                    nftId: list[widget.index].nftId ?? '',
                    pawnId: int.parse(list[widget.index].pawnId ?? '0'),
                    key: nftKey,
                    typeMarket: type,
                    marketId: list[widget.index].marketId ?? '',
                  );
                },
              ),
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topLeft,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child:Image.network(
                  '${ApiConstants.BASE_URL_IMAGE}${widget.urlAvatar}',
                  width: 66.w,
                  height: 66.w,
                  fit: BoxFit.fill,
                  errorBuilder: (context, url, error) => Container(
                    color: Colors.yellow,
                    child: SizedBox(
                      width: 66.w,
                      height: 66.w,
                      child: Text(
                        widget.title.isEmpty
                            ? widget.title
                            : widget.title.substring(0, 1),
                        style: textNormalCustom(
                          Colors.black,
                          60,
                          FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -2.h,
                left: -4.w,
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1.w,
                      color: AppTheme.getInstance().bgBtsColor(),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        widget.statusIconActivity,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        spaceW12,
        SizedBox(
          width: MediaQuery.of(context).size.width - 106,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  final list = widget.bloc.listActivity.value;
                  late final MarketType type;
                  if (list[widget.index].marketStatus ==
                      DetailCollectionBloc.NOT_ON_MARKET) {
                    type = MarketType.NOT_ON_MARKET;
                  } else if (list[widget.index].marketStatus ==
                      DetailCollectionBloc.SALE) {
                    type = MarketType.SALE;
                  } else if (list[widget.index].marketStatus ==
                      DetailCollectionBloc.AUCTION) {
                    type = MarketType.AUCTION;
                  } else {
                    type = MarketType.PAWN;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NFTDetailScreen(
                          typeNft: list[widget.index].nftType == SOFT_COLLECTION
                              ? TypeNFT.SOFT_NFT
                              : TypeNFT.HARD_NFT,
                          nftId: list[widget.index].nftId ?? '',
                          pawnId: int.parse(list[widget.index].pawnId ?? '0'),
                          key: nftKey,
                          typeMarket: type,
                          marketId: list[widget.index].marketId ?? '',
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  widget.title,
                  style: textNormalCustom(
                    null,
                    14,
                    FontWeight.w600,
                  ).copyWith(overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                ),
              ),
              widget.childText,
              spaceH6,
              Text(
                0.formatDateTimeMy(
                  widget.date,
                ),
                style: textNormalCustom(
                  AppTheme.getInstance().activityDateColor(),
                  14,
                  null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
