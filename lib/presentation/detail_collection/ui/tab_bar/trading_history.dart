import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/widget/list_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TradingHistoryCollection extends StatefulWidget {
  const TradingHistoryCollection({Key? key, required this.detailCollectionBloc})
      : super(key: key);
  final DetailCollectionBloc detailCollectionBloc;

  @override
  _TradingHistoryCollectionState createState() =>
      _TradingHistoryCollectionState();
}

class _TradingHistoryCollectionState extends State<TradingHistoryCollection> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.only(
        top: 24.h,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          print(index);
        },
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(bottom: 24.h),
          child: ListActivity(
            urlAvatar:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ54OAZe7VB-yP3POTvGD7BsHlRgqX0eqXJ5Q&usqp=CAU',
            copy: '',
            auctionType: 0,
            addressWalletSend: 'asasdfsafadsfdsafdf',
            marketStatus: 2,
            price: '',
            priceSymbol: '',
            addressMyWallet: 'asasdfsafadsfdsafdf',
            title: '',
            date: '',
            addressWallet: 'asasdfsadsfdsafdf',
            content: '',
            urlSymbol:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ54OAZe7VB-yP3POTvGD7BsHlRgqX0eqXJ5Q&usqp=CAU',
            nft_type: 1,
            typeActivity: 1,
          ),
        ),
      ),
    );
  }
}
