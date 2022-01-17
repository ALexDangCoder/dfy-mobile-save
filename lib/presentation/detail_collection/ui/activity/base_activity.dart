import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseActivity extends StatelessWidget {
  final String urlAvatar;
  final String title;
  final String date;
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
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceW12,
        GestureDetector(
          onTap: () {
            final list = bloc.listActivity.value;
            if (list[index].marketStatus ==
                DetailCollectionBloc.NOT_ON_MARKET) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NFTDetailScreen(
                      typeMarket: MarketType.NOT_ON_MARKET,
                      marketId: list[index].marketId ?? '',
                    );
                  },
                ),
              );
            } else if (list[index].marketStatus == DetailCollectionBloc.SALE) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NFTDetailScreen(
                      typeMarket: MarketType.SALE,
                      marketId: list[index].marketId ?? '',
                    );
                  },
                ),
              );
            } else if (list[index].marketStatus ==
                DetailCollectionBloc.AUCTION) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NFTDetailScreen(
                      typeMarket: MarketType.AUCTION,
                      marketId: list[index].marketId ?? '',
                    );
                  },
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NFTDetailScreen(
                      typeMarket: MarketType.PAWN,
                      marketId: list[index].marketId ?? '',
                    );
                  },
                ),
              );
            }
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
                child: CachedNetworkImage(
                  width: 66.w,
                  height: 66.w,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => Container(
                    color: Colors.yellow,
                    child: Text(
                      title.substring(0, 1),
                      style: textNormalCustom(
                        Colors.black,
                        60,
                        FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  imageUrl: urlAvatar,
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
                        statusIconActivity,
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
              //title
              GestureDetector(
                onTap: () {
                  final list = bloc.listActivity.value;
                  if (list[index].marketStatus ==
                      DetailCollectionBloc.NOT_ON_MARKET) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NFTDetailScreen(
                            typeMarket: MarketType.NOT_ON_MARKET,
                            marketId: list[index].marketId ?? '',
                          );
                        },
                      ),
                    );
                  } else if (list[index].marketStatus ==
                      DetailCollectionBloc.SALE) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NFTDetailScreen(
                            typeMarket: MarketType.SALE,
                            marketId: list[index].marketId ?? '',
                          );
                        },
                      ),
                    );
                  } else if (list[index].marketStatus ==
                      DetailCollectionBloc.AUCTION) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NFTDetailScreen(
                            typeMarket: MarketType.AUCTION,
                            marketId: list[index].marketId ?? '',
                          );
                        },
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NFTDetailScreen(
                            typeMarket: MarketType.PAWN,
                            marketId: list[index].marketId ?? '',
                          );
                        },
                      ),
                    );
                  }
                },
                child: Text(
                  title,
                  style: textNormalCustom(
                    null,
                    14,
                    FontWeight.w600,
                  ).copyWith(
                    overflow: TextOverflow.ellipsis
                  ),
                  maxLines: 1,
                ),
              ),
              //content
              childText,
              //date
              spaceH6,
              Text(
                date,
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
