import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
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
    return StreamBuilder<int>(
      stream: widget.detailCollectionBloc.statusActivity,
      builder: (context, snapshot) {
        final statusActivity = snapshot.data ?? 0;
        final list = widget.detailCollectionBloc.listActivity.value;
        if (statusActivity == 1) {
          return ListView.builder(
            itemCount: list.length,
            padding: EdgeInsets.only(
              top: 24.h,
            ),
            itemBuilder: (context, index) => Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(bottom: 24.h),
              child: ListActivity(
                urlAvatar:
                    '${ApiConstants.BASE_URL_IMAGE}${list[index].avatarCid ?? ''}',
                copy: '${list[index].numberOfCopies ?? 0}',
                auctionType: list[index].auctionType ?? 99,
                addressWalletSend: list[index].fromAddress ?? '',
                marketStatus: list[index].marketStatus ?? 99,
                price: '${list[index].price ?? 0}',
                priceSymbol: list[index].priceSymbol ?? '',
                addressMyWallet: widget.addressWallet,
                title: list[index].nftName ?? '',
                date: 0.formatDateTimeMy(
                  list[index].eventDateTime ?? 0,
                ),
                addressWallet: list[index].toAddress ?? '',
                urlSymbol: widget.detailCollectionBloc
                    .funGetSymbolUrl(list[index].priceSymbol ?? ''),
                nft_type: list[index].nftType ?? 99,
                typeActivity: list[index].activityType ?? 99,
                index: index,
                bloc: widget.detailCollectionBloc,
              ),
            ),
          );
        } else if (statusActivity == 2) {
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
        } else if (statusActivity == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                width: 120.w,
                height: 117.23.h,
                child: Image.asset(
                  ImageAssets.err_load_collection,
                ),
              ),
              spaceH16,
              Text(
                S.current.error_network,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteWithOpacity(),
                  20,
                  FontWeight.bold,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
