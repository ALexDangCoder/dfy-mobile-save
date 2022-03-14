import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/activity_collection_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/base_activity.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/base_text_bsc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListActivity extends StatelessWidget {
  final ActivityCollectionModel objActivity;
  final int index;
  final DetailCollectionBloc bloc;

  const ListActivity({
    Key? key,
    required this.index,
    required this.bloc,
    required this.objActivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemActivity(
      objActivity: objActivity,
      index: index,
      bloc: bloc,
      context: context,
    );
  }

  Widget itemActivity(
      {required ActivityCollectionModel objActivity,
      required int index,
      required DetailCollectionBloc bloc,
      required BuildContext context}) {
    final String myCopy = bloc.funCheckCopy(
      copy: objActivity.numberOfCopies.toString(),
      nftType: objActivity.nftType ?? 0,
    );
    final String market = bloc
        .funGetMarket(
          objActivity.marketStatus ?? 0,
        )
        .toLowerCase();
    final String each = bloc.funCheckEach(
      nftType: objActivity.nftType ?? 0,
    );
    final String urlSymbol =
        ImageAssets.getSymbolAsset(objActivity.priceSymbol ?? '');
    final String? urlAvatar;
    final String fromAddress = objActivity.fromAddress ?? '';
    final String priceSymbol = objActivity.priceSymbol ?? '';
    final double price = objActivity.price ?? 0;
    final String nftName = objActivity.nftName ?? '';
    final int date = objActivity.eventDateTime ?? 0;
    final String toAddress = objActivity.toAddress ?? '';
    final double widthActivity = MediaQuery.of(context).size.width - 106;
    if ((objActivity.fileType ?? '') == VIDEO_ACTIVITY) {
      urlAvatar = objActivity.coverCid ?? '';
    } else {
      urlAvatar = objActivity.avatarCid ?? '';
    }
    switch (objActivity.activityType) {
      case DetailCollectionBloc.PUT_ON_MARKET:
        return BaseActivity(
          urlAvatar: urlAvatar,
          title: nftName,
          date: date,
          index: index,
          statusIconActivity: ImageAssets.img_activity_put_on_market,
          bloc: bloc,
          childText: SizedBox(
            width: widthActivity,
            child: RichText(
              text: TextSpan(
                text: '${S.current.activity_put} ',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteWithOpacitySevenZero(),
                  14,
                  FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: myCopy.isEmpty
                        ? ''
                        : '${S.current.activity_copied} '
                            '$myCopy ${S.current.activity_on} ',
                  ),
                  TextSpan(
                    text: '$market ${S.current.activity_by} ',
                  ),
                  baseTextBSC(fromAddress),
                  TextSpan(
                    text: ' ${S.current.activity_for} ',
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: urlSymbol.isNotEmpty
                        ? Image.network(
                            urlSymbol,
                            width: 14.w,
                            height: 14.w,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.all(
                                Radius.circular(45.r),
                              ),
                            ),
                            width: 14.w,
                            height: 14.w,
                            child: FittedBox(
                              child: Text(
                                priceSymbol.substring(0, 1),
                              ),
                            ),
                          ),
                  ),
                  TextSpan(
                    text: ' $price $priceSymbol',
                    style: textNormalCustom(
                      AppTheme.getInstance().amountTextColor(),
                      14,
                      FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: each.isEmpty ? null : ' ${S.current.activity_each}',
                    style: textNormalCustom(
                      null,
                      14,
                      null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      case DetailCollectionBloc.TRANSFER_ACTIVITY:
        return BaseActivity(
          urlAvatar: urlAvatar,
          title: nftName,
          date: date,
          statusIconActivity: ImageAssets.img_activity_transfer,
          index: index,
          bloc: bloc,
          childText: SizedBox(
            width: widthActivity,
            child: RichText(
              text: TextSpan(
                text: '${S.current.activity_transferred} ',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteWithOpacitySevenZero(),
                  14,
                  FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: myCopy.isEmpty
                        ? '${S.current.activity_by} '
                        : '${S.current.activity_copied} '
                            '$myCopy ${S.current.activity_by} ',
                  ),
                  baseTextBSC(fromAddress),
                  TextSpan(
                    text: ' ${S.current.activity_from_to} ',
                  ),
                  baseTextBSC(toAddress),
                ],
              ),
            ),
          ),
        );
      case DetailCollectionBloc.BURN:
        return BaseActivity(
          urlAvatar: urlAvatar,
          title: nftName,
          date: date,
          statusIconActivity: ImageAssets.img_activity_burn,
          index: index,
          bloc: bloc,
          childText: SizedBox(
            width: widthActivity,
            child: RichText(
              text: TextSpan(
                text: '${S.current.activity_burned} ',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteWithOpacitySevenZero(),
                  14,
                  FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: myCopy.isEmpty
                        ? '${S.current.activity_by} '
                        : '${S.current.activity_copied} $myCopy '
                            '${S.current.activity_by} ',
                  ),
                  baseTextBSC(fromAddress),
                ],
              ),
            ),
          ),
        );
      case DetailCollectionBloc.CANCEL:
        return BaseActivity(
          urlAvatar: urlAvatar,
          title: nftName,
          date: date,
          index: index,
          bloc: bloc,
          statusIconActivity: ImageAssets.img_activity_cancel,
          childText: SizedBox(
            width: widthActivity,
            child: RichText(
              text: TextSpan(
                text: '${S.current.activity_cancelled} ',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteWithOpacitySevenZero(),
                  14,
                  FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: myCopy.isEmpty
                        ? ''
                        : '${S.current.activity_copied} $myCopy '
                            '${S.current.activity_on} ',
                  ),
                  TextSpan(
                    text: '$market ${S.current.activity_by} ',
                  ),
                  baseTextBSC(fromAddress),
                ],
              ),
            ),
          ),
        );
      case DetailCollectionBloc.LIKE:
        return BaseActivity(
          urlAvatar: urlAvatar,
          title: nftName,
          date: date,
          bloc: bloc,
          statusIconActivity: ImageAssets.img_activity_like,
          index: index,
          childText: SizedBox(
            width: widthActivity,
            child: RichText(
              text: TextSpan(
                text: '${S.current.activity_liked_by} ',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteWithOpacitySevenZero(),
                  14,
                  FontWeight.w400,
                ),
                children: [
                  baseTextBSC(fromAddress),
                ],
              ),
            ),
          ),
        );
      case DetailCollectionBloc.REPORT:
        return BaseActivity(
          urlAvatar: urlAvatar,
          title: nftName,
          date: date,
          index: index,
          bloc: bloc,
          statusIconActivity: ImageAssets.img_activity_report,
          childText: SizedBox(
            width: widthActivity,
            child: RichText(
              text: TextSpan(
                text: '${S.current.activity_reported_by} ',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteWithOpacitySevenZero(),
                  14,
                  FontWeight.w400,
                ),
                children: [
                  baseTextBSC(fromAddress),
                ],
              ),
            ),
          ),
        );
      case DetailCollectionBloc.BUY:
        return BaseActivity(
          urlAvatar: urlAvatar,
          title: nftName,
          date: date,
          statusIconActivity: ImageAssets.img_activity_buy,
          index: index,
          bloc: bloc,
          childText: SizedBox(
            width: widthActivity,
            child: RichText(
              text: TextSpan(
                text: '${S.current.activity_bought} ',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteWithOpacitySevenZero(),
                  14,
                  FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: myCopy.isEmpty
                        ? ''
                        : '${S.current.activity_copied} '
                            '$myCopy ${S.current.activity_for} ',
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: urlSymbol.isNotEmpty
                        ? Image.network(
                            urlSymbol,
                            width: 14.w,
                            height: 14.w,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.all(
                                Radius.circular(45.r),
                              ),
                            ),
                            width: 14.w,
                            height: 14.w,
                            child: FittedBox(
                              child: Text(
                                priceSymbol.substring(0, 1),
                              ),
                            ),
                          ),
                  ),
                  TextSpan(
                    text: ' $price $priceSymbol',
                    style: textNormalCustom(
                      AppTheme.getInstance().amountTextColor(),
                      14,
                      FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ' ${S.current.activity_by} ',
                  ),
                  baseTextBSC(fromAddress),
                ],
              ),
            ),
          ),
        );
      case DetailCollectionBloc.BID_BUY_OUT:
        if (objActivity.auctionType == 0) {
          return BaseActivity(
            urlAvatar: urlAvatar,
            title: nftName,
            date: date,
            statusIconActivity: ImageAssets.img_activity_bid,
            index: index,
            bloc: bloc,
            childText: SizedBox(
              width: widthActivity,
              child: RichText(
                text: TextSpan(
                  text: '${S.current.activity_bid} ',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteWithOpacitySevenZero(),
                    14,
                    FontWeight.w400,
                  ),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: urlSymbol.isNotEmpty
                          ? Image.network(
                              urlSymbol,
                              width: 14.w,
                              height: 14.w,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(45.r),
                                ),
                              ),
                              width: 14.w,
                              height: 14.w,
                              child: FittedBox(
                                child: Text(
                                  priceSymbol.substring(0, 1),
                                ),
                              ),
                            ),
                    ),
                    TextSpan(
                      text: ' $price $priceSymbol',
                      style: textNormalCustom(
                        AppTheme.getInstance().amountTextColor(),
                        14,
                        FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' ${S.current.activity_by} ',
                    ),
                    baseTextBSC(fromAddress),
                  ],
                ),
              ),
            ),
          );
        } else {
          return BaseActivity(
            urlAvatar: urlAvatar,
            title: nftName,
            date: date,
            statusIconActivity: ImageAssets.img_activity_bid,
            index: index,
            bloc: bloc,
            childText: SizedBox(
              width: widthActivity,
              child: RichText(
                text: TextSpan(
                  text: '${S.current.activity_bought_out} ',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteWithOpacitySevenZero(),
                    14,
                    FontWeight.w400,
                  ),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: urlSymbol.isNotEmpty
                          ? Image.network(
                              urlSymbol,
                              width: 14.w,
                              height: 14.w,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(45.r),
                                ),
                              ),
                              width: 14.w,
                              height: 14.w,
                              child: FittedBox(
                                child: Text(
                                  priceSymbol.substring(0, 1),
                                ),
                              ),
                            ),
                    ),
                    TextSpan(
                      text: ' $price $priceSymbol',
                      style: textNormalCustom(
                        AppTheme.getInstance().amountTextColor(),
                        14,
                        FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' ${S.current.activity_by} ',
                    ),
                    baseTextBSC(fromAddress),
                  ],
                ),
              ),
            ),
          );
        }
      case DetailCollectionBloc.RECEIVE_OFFER:
        return BaseActivity(
          urlAvatar: urlAvatar,
          title: nftName,
          date: date,
          statusIconActivity: ImageAssets.img_activity_receive_offer,
          bloc: bloc,
          index: index,
          childText: SizedBox(
            width: widthActivity,
            child: RichText(
              text: TextSpan(
                text: '${S.current.activity_received_an_offer_worth} ',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteWithOpacitySevenZero(),
                  14,
                  FontWeight.w400,
                ),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: urlSymbol.isNotEmpty
                        ? Image.network(
                            urlSymbol,
                            width: 14.w,
                            height: 14.w,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.all(
                                Radius.circular(45.r),
                              ),
                            ),
                            width: 14.w,
                            height: 14.w,
                            child: FittedBox(
                              child: Text(
                                priceSymbol.substring(0, 1),
                              ),
                            ),
                          ),
                  ),
                  TextSpan(
                    text: ' $price $priceSymbol',
                    style: textNormalCustom(
                      AppTheme.getInstance().amountTextColor(),
                      14,
                      FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ' ${S.current.from} ',
                  ),
                  baseTextBSC(fromAddress),
                ],
              ),
            ),
          ),
        );
      case DetailCollectionBloc.SIGN_CONTRACT:
        return BaseActivity(
          urlAvatar: urlAvatar,
          title: nftName,
          date: date,
          index: index,
          bloc: bloc,
          statusIconActivity: ImageAssets.img_activity_sign_contract,
          childText: SizedBox(
            width: widthActivity,
            child: RichText(
              text: TextSpan(
                text: '${S.current.activity_signed_a_pawn_contract_between} ',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteWithOpacitySevenZero(),
                  14,
                  FontWeight.w400,
                ),
                children: [
                  baseTextBSC(fromAddress),
                  TextSpan(
                    text: ' ${S.current.activity_and} ',
                  ),
                  baseTextBSC(toAddress),
                ],
              ),
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
