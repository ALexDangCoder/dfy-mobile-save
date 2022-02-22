import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/hard_nft_mint_request.dart';
import 'package:Dfy/presentation/create_hard_nft/hard_nft_mint_request/bloc/hard_nft_mint_request_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/hard_nft_mint_request/ui/mint_request_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListMintRequest extends StatefulWidget {
  const ListMintRequest({
    Key? key,
    required this.listMintRequest,
    required this.cubit,
  }) : super(key: key);

  final List<MintRequestModel> listMintRequest;
  final HardNftMintRequestCubit cubit;

  @override
  _ListMintRequestState createState() => _ListMintRequestState();
}

class _ListMintRequestState extends State<ListMintRequest> {
  @override
  Widget build(BuildContext context) {
    if (widget.listMintRequest.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          /// loadMore
          return true;
        },
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ListView.builder(
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
      return const SizedBox.shrink();
    }
  }
}
