import 'package:Dfy/generated/l10n.dart';
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
import 'package:Dfy/utils/extensions/string_extension.dart';
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
  final int nft_type;
  final String urlSymbol;

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
    required this.nft_type,
    required this.price,
    required this.priceSymbol,
    required this.urlSymbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String myCopy = '';
    String each = '';
    String myAddress = '';
    String myAddressTo = '';
    String market = '';
    if (marketStatus == 1) {
      market = S.current.sale;
    } else if (marketStatus == 2) {
      market = S.current.auction;
    } else if (marketStatus == 3) {
      market = S.current.pawn;
    } else {
      market = S.current.not_on_market;
    }
    if (nft_type == 0) {
      //721
      myCopy = '';
      each = '';
    } else {
      myCopy = copy;
      each = S.current.activity_each;
    }
    if (addressMyWallet == addressWallet) {
      myAddress = S.current.activity_you;
    } else {
      if (addressWallet.length < 12) {
        myAddress = addressWallet;
      } else {
        myAddress = addressWallet.formatAddressActivityFire();
      }
    }
    if (addressMyWallet == addressWalletSend) {
      myAddressTo = S.current.activity_you;
    } else {
      if (addressWallet.length < 12) {
        myAddress = addressWalletSend;
      } else {
        myAddressTo = addressWalletSend.formatAddressActivityFire();

      }
    }
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
        );
      case DetailCollectionBloc.TRANSFER_ACTIVITY:
        return TransferActivity(
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          copy: copy ?? '',
          addressSend: addressWalletSend ?? '',
          address: addressWallet ?? '',
        );
      case DetailCollectionBloc.BURN:
        return Burn(
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          content: addressWallet ?? '',
          copy: copy ?? '',
        );
      case DetailCollectionBloc.CANCEL:
        return Cancel(
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          content: addressWallet ?? '',
          market: market ?? '',
          copy: copy ?? '',
        );
      case DetailCollectionBloc.LIKE:
        return Like(
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          content: addressWallet ?? '',
        );
      case DetailCollectionBloc.REPORT:
        return Report(
          urlAvatar: urlAvatar ?? '',
          title: title ?? '',
          date: date ?? '',
          content: addressWallet ?? '',
        );
      case DetailCollectionBloc.BUY:
        return Buy(
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
