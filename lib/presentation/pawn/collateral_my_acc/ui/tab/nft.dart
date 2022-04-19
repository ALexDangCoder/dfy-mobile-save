import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/ui/nft_item.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/bloc/collateral_my_acc_bloc.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/bloc/collateral_my_acc_state.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NFTCollateral extends StatefulWidget {
  const NFTCollateral({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final CollateralMyAccBloc bloc;

  @override
  _NFTTabState createState() => _NFTTabState();
}

class _NFTTabState extends State<NFTCollateral> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.bloc.refreshPostsNft();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = widget.bloc;
    return BlocConsumer<CollateralMyAccBloc, CollateralMyAccState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is BorrowListMyAccNFTSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (bloc.loadMoreRefresh) {}
            bloc.showContent();
          } else {
            bloc.mess = state.message ?? '';
            bloc.showError();
          }
          bloc.loadMore = false;
          if (bloc.refresh) {
            bloc.listNFT.clear();
            bloc.refresh = false;
          }
          bloc.listNFT.addAll(state.listNFT ?? []);
          bloc.canLoadMoreListNft =
              (state.listNFT?.length ?? 0) >= ApiConstants.DEFAULT_PAGE_SIZE;
        }
      },
      builder: (context, state) {
        return StateStreamLayout(
          isBack: false,
          retry: () {
            widget.bloc.refreshPostsNft();
          },
          error: AppException(S.current.error, bloc.mess),
          stream: bloc.stateStream,
          textEmpty: bloc.mess,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (bloc.canLoadMoreListNft &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                bloc.loadMorePostsNft();
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                 await widget.bloc.refreshPostsNft();
              },
              child: bloc.listNFT.isNotEmpty
                  ? GridView.builder(
                physics: const ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                shrinkWrap: true,
                itemCount: bloc.listNFT.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 170.w / 231.h,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: NFTItemWidget(
                        nftMarket:
                        widget.bloc.listNFT[index],
                        pageRouter: PageRouter.MY_ACC,
                      ),
                    ),
                  );
                },
              )
                  : state is BorrowListMyAccNFTSuccess
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image(
                      image: const AssetImage(
                        ImageAssets.img_search_empty,
                      ),
                      height: 120.h,
                      width: 120.w,
                    ),
                  ),
                  SizedBox(
                    height: 17.7.h,
                  ),
                  Center(
                    child: Text(
                      S.current.no_result_found,
                      style: textNormal(
                        Colors.white54,
                        20.sp,
                      ),
                    ),
                  ),
                ],
              )
                  : const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
