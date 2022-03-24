import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/ui/nft_item.dart';
import 'package:Dfy/presentation/pawn/borrow_list_my_acc/bloc/borrow_list_my_acc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NFTTab extends StatefulWidget {
  const NFTTab({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final BorrowListMyAccBloc bloc;

  @override
  _NFTTabState createState() => _NFTTabState();
}

class _NFTTabState extends State<NFTTab> {
  @override
  void initState() {
    super.initState();
    widget.bloc.getBorrowContract(
      type: BorrowListMyAccBloc.NFT_TYPE,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ClampingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      shrinkWrap: true,
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 170.w / 231.h,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: NFTItemWidget(
            nftMarket: NftMarket(
              description: '213421342134',
              collateralId: 12,
              //todo
            ),
          ),
        );
      },
    );
  }
}
