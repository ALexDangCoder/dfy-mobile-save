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
  }) : super(key: key);
  final DetailCollectionBloc detailCollectionBloc;

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
        if (statusActivity == DetailCollectionBloc.SUCCESS) {
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
                    '${ApiConstants.BASE_URL_IMAGE}${list[index].avatarCid ??
                        ''}',
                copy: '${list[index].numberOfCopies ?? 0}',
                auctionType: list[index].auctionType ?? 99,
                addressWalletSend: list[index].fromAddress ?? '',
                marketStatus: list[index].marketStatus ?? 99,
                price: '${list[index].price ?? 0}',
                priceSymbol: list[index].priceSymbol ?? '',
                title: list[index].nftName ?? '',
                date: 0.formatDateTimeMy(
                  list[index].eventDateTime ?? 0,
                ),
                addressWallet: list[index].toAddress ?? '',
                urlSymbol: widget.detailCollectionBloc
                    .funGetSymbolUrl(list[index].priceSymbol ?? ''),
                nftType: list[index].nftType ?? 99,
                typeActivity: list[index].activityType ?? 99,
                index: index,
                bloc: widget.detailCollectionBloc,
              ),
            ),
          );
        } else if (statusActivity == DetailCollectionBloc.FAILED) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100.h,
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
            ),
          );
        } else if (statusActivity == DetailCollectionBloc.LOADING) {
          return const Align(
            alignment: Alignment.bottomCenter,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 80.h),
              child: Column(
                children: [
                  Image(
                    image: const AssetImage(
                      ImageAssets.img_search_empty,
                    ),
                    height: 120.h,
                    width: 120.w,
                  ),
                  SizedBox(
                    height: 17.7.h,
                  ),
                  Text(
                    S.current.no_result_found,
                    style: textNormal(
                      AppTheme.getInstance().whiteWithOpacity(),
                      20.sp,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
