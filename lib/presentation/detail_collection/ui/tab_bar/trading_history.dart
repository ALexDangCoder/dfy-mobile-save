import 'package:Dfy/domain/model/market_place/activity_collection_model.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/widget/list_activity.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityCollection extends StatefulWidget {
  const ActivityCollection({
    Key? key,
    required this.detailCollectionBloc,
    required this.addressWallet,
  }) : super(key: key);
  final DetailCollectionBloc detailCollectionBloc;
  final String addressWallet;

  @override
  _ActivityCollectionState createState() => _ActivityCollectionState();
}

class _ActivityCollectionState extends State<ActivityCollection> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ActivityCollectionModel>>(
        stream: widget.detailCollectionBloc.listActivity,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
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
                      '${ApiConstants.BASE_URL_IMAGE}${snapshot.data?[index].avatarCid ?? ''}',
                  copy: '${snapshot.data?[index].numberOfCopies ?? 0}',
                  auctionType: snapshot.data?[index].activityType ?? 99,
                  addressWalletSend: snapshot.data?[index].fromAddress ?? '',
                  marketStatus: snapshot.data?[index].marketStatus ?? 99,
                  price: '${snapshot.data?[index].price ?? 0}',
                  priceSymbol: snapshot.data?[index].priceSymbol ?? '',
                  addressMyWallet:widget.addressWallet,
                  title: snapshot.data?[index].nftName ?? '',
                  date: '${snapshot.data?[index].eventDateTime ?? 0}',
                  addressWallet: snapshot.data?[index].nftOwner ?? '',
                  urlSymbol: widget.detailCollectionBloc
                      .funGetSymbolUrl(snapshot.data?[index].priceSymbol ?? ''),
                  nft_type: snapshot.data?[index].nftType ?? 99,
                  typeActivity: snapshot.data?[index].status ?? 99,
                ),
              ),
            ),
          );
        });
  }
}
