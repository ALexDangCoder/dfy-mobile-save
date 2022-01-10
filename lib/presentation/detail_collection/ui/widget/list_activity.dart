
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/activity_bid.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/activity_burn.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/activity_buy.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/activity_buy_out.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/activity_cancel.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/activity_like.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/activity_put_on_market.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/activity_receive_offer.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/activity_report.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/activity_sign_contract.dart';
import 'package:Dfy/presentation/detail_collection/ui/activity/activity_transfer.dart';
import 'package:flutter/material.dart';

class ListActivity extends StatelessWidget {
  final String urlAvatar;
  final String title;
  final String date;
  final String copy;
  final int marketStatus;
  final String addressWalletSend;
  final String addressWallet;
  final String addressMyWallet;
  final String price;
  final String priceSymbol;
  final int typeActivity;
  final int auctionType;
  final int nftType;
  final String urlSymbol;
  final int index;
  final DetailCollectionBloc bloc;

  const ListActivity({
    Key? key,
    required this.urlAvatar,
    required this.title,
    required this.date,
    required this.copy,
    required this.marketStatus,
    required this.addressWalletSend,
    required this.addressWallet,
    required this.typeActivity,
    required this.auctionType,
    required this.addressMyWallet,
    required this.nftType,
    required this.price,
    required this.priceSymbol,
    required this.urlSymbol,
    required this.index,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String each = bloc.funCheckEach(
      nftType: nftType,
    );
    final String myCopy = bloc.funCheckCopy(
      copy: copy,
      nftType: nftType,
    );
    final String market = bloc.funGetMarket(marketStatus);
    final String myAddress = bloc.funCheckAddressSend(
      addressWallet: addressWallet,
      addressMyWallet: addressMyWallet,
    );
    final String myAddressTo = bloc.funCheckAddressTo(
      addressMyWallet: addressMyWallet,
      addressWalletSend: addressWalletSend,
    );

    return itemActivity(
      price: price,
      typeActivity: typeActivity,
      urlSymbol: urlSymbol,
      urlAvatar: urlAvatar,
      priceSymbol: price,
      title: title,
      addressWallet: myAddress,
      addressWalletSend: myAddressTo,
      auctionType: auctionType,
      copy: myCopy,
      date: date,
      each: each,
      market: market,
      index: index,
      bloc: bloc,
    );
  }

  Widget itemActivity({
    String? urlAvatar,
    String? title,
    String? date,
    String? copy,
    String? market,
    String? addressWalletSend,
    String? addressWallet,
    String? price,
    String? priceSymbol,
    String? each,
    int? typeActivity,
    int? auctionType,
    String? urlSymbol,
    required int index,
    required DetailCollectionBloc bloc,
  }) {
    switch (typeActivity) {
      case DetailCollectionBloc.PUT_ON_MARKET:
        return PutOnMarket(
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          content: addressWallet ?? '',
          money: price ?? '',
          copy: copy ?? '',
          each: each ?? '',
          market: market ?? '',
          moneySymbol: priceSymbol ?? '',
          urlSymbol: urlSymbol ?? '',
          bloc: bloc,
          index: index,
        );
      case DetailCollectionBloc.TRANSFER_ACTIVITY:
        return TransferActivity(
          bloc: bloc,
          index: index,
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          copy: copy ?? '',
          addressSend: addressWalletSend ?? '',
          address: addressWallet ?? '',
        );
      case DetailCollectionBloc.BURN:
        return Burn(
          bloc: bloc,
          index: index,
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          content: addressWallet ?? '',
          copy: copy ?? '',
        );
      case DetailCollectionBloc.CANCEL:
        return Cancel(
          bloc: bloc,
          index: index,
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          content: addressWallet ?? '',
          market: market ?? '',
          copy: copy ?? '',
        );
      case DetailCollectionBloc.LIKE:
        return Like(
          bloc: bloc,
          index: index,
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          content: addressWallet ?? '',
        );
      case DetailCollectionBloc.REPORT:
        return Report(
          bloc: bloc,
          index: index,
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          content: addressWallet ?? '',
        );
      case DetailCollectionBloc.BUY:
        return Buy(
          bloc: bloc,
          index: index,
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          content: addressWallet ?? '',
          amount: price ?? '',
          copy: copy ?? '',
          amountSymbol: priceSymbol ?? '',
          urlSymbol: urlSymbol ?? '',
        );
      case DetailCollectionBloc.BID_BUY_OUT:
        if (auctionType == 0) {
          return Bid(
            bloc: bloc,
            index: index,
            urlAvatar: urlAvatar ?? '',
            title: title ?? '',
            date: date ?? '',
            content: addressWallet ?? '',
            amount: price ?? '',
            urlSymbol: urlSymbol ?? '',
            amountSymbol: priceSymbol ?? '',
          );
        } else {
          return BuyOut(
            bloc: bloc,
            index: index,
            urlAvatar: urlAvatar ?? '',
            title: title ?? '',
            date: date ?? '',
            content: addressWallet ?? '',
            amount: price ?? '',
            urlSymbol: urlSymbol ?? '',
            amountSymbol: priceSymbol ?? '',
          );
        }
      case DetailCollectionBloc.RECEIVE_OFFER:
        return ReceiveOffer(
          bloc: bloc,
          index: index,
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          content: addressWallet ?? '',
          value: price ?? '',
          valueSymbol: priceSymbol ?? '',
          urlSymbol: urlSymbol ?? '',
        );
      case DetailCollectionBloc.SIGN_CONTRACT:
        return SignContract(
          bloc: bloc,
          index: index,
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          addressSend: addressWalletSend ?? '',
          address: addressWallet ?? '',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
