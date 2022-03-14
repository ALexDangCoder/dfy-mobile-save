import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/hard_nft_mint_request.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/hard_nft_mint_request/bloc/hard_nft_mint_request_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/hard_nft_mint_request/ui/widget/mint_request_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListMintRequest extends StatefulWidget {
  const ListMintRequest({
    Key? key,
    required this.listMintRequest,
    required this.cubit,
    required this.checkRefresh,
  }) : super(key: key);

  final List<MintRequestModel> listMintRequest;
  final HardNftMintRequestCubit cubit;
  final bool checkRefresh;

  @override
  _ListMintRequestState createState() => _ListMintRequestState();
}

class _ListMintRequestState extends State<ListMintRequest> {
  @override
  Widget build(BuildContext context) {
    if (widget.listMintRequest.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (widget.cubit.canLoadMoreList &&
              (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent)) {
            widget.cubit.loadMoreMintRequest();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            widget.cubit.refreshMintRequest();
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 0),
            shrinkWrap: true,
            itemCount: widget.listMintRequest.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH10,
                    MintRequestItem(
                      mintRequestModel: widget.listMintRequest[index],
                    ),
                    spaceH20,
                    divider,
                  ],
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 150.h),
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
                Colors.white54,
                20.sp,
              ),
            ),
          ],
        ),
      );
    }
  }
}
