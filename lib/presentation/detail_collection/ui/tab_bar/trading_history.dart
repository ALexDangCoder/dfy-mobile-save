import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/activity_collection_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/widget/list_activity.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/int_extension.dart';
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
        if(snapshot.data?.isEmpty ?? false){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                width: 120.w,
                height: 117.23.h,
                child: Image.asset(
                  ImageAssets.img_search_empty,
                ),
              ),
              spaceH16,
              Text(
                S.current.no_result_found,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteWithOpacity(),
                  20,
                  FontWeight.bold,
                ),
              ),
            ],
          );
        }else{
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
                  addressWalletSend: snapshot.data?[index].fromAddress ??
                      'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                  marketStatus: snapshot.data?[index].marketStatus ?? 99,
                  price: '${snapshot.data?[index].price ?? 0}',
                  priceSymbol: snapshot.data?[index].priceSymbol ?? '',
                  addressMyWallet: widget.addressWallet,
                  title: snapshot.data?[index].nftName ?? '',
                  date: 0.formatDateTimeMy(
                    snapshot.data?[index].eventDateTime ?? 0,
                  ),
                  addressWallet: snapshot.data?[index].toAddress ??
                      'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                  urlSymbol: widget.detailCollectionBloc
                      .funGetSymbolUrl(snapshot.data?[index].priceSymbol ?? ''),
                  nft_type: snapshot.data?[index].nftType ?? 99,
                  typeActivity: snapshot.data?[index].status ?? 99,
                ),
              ),
            ),
          );
        }

      },
    );
  }
}
