import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_list_my_acc/bloc/borrow_list_my_acc_bloc.dart';
import 'package:Dfy/presentation/pawn/borrow_list_my_acc/bloc/borrow_list_my_acc_state.dart';
import 'package:Dfy/presentation/pawn/borrow_list_my_acc/ui/item_nft_pawn.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/contract_detail.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class _NFTTabState extends State<NFTTab> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.bloc.refreshPosts(
      type: BorrowListMyAccBloc.NFT_TYPE,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = widget.bloc;
    return BlocConsumer<BorrowListMyAccBloc, BorrowListMyAccState>(
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
          bloc.loadMoreLoading = false;
          if (bloc.isRefresh) {
            bloc.listNFT.clear();
          }
          bloc.listNFT.addAll(state.listNFT ?? []);
          bloc.canLoadMoreMy =
              bloc.listNFT.length >= ApiConstants.DEFAULT_PAGE_SIZE;
        }
      },
      builder: (context, state) {
        return StateStreamLayout(
          isBack: false,
          retry: () {
            widget.bloc.refreshPosts(
              type: BorrowListMyAccBloc.NFT_TYPE,
            );
          },
          error: AppException(S.current.error, bloc.mess),
          stream: bloc.stateStream,
          textEmpty: bloc.mess,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (bloc.canLoadMore &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                bloc.loadMorePosts(
                  type: BorrowListMyAccBloc.NFT_TYPE,
                );
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                await widget.bloc.refreshPosts(
                  type: BorrowListMyAccBloc.NFT_TYPE,
                );
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ContractDetail(
                                  type: TypeBorrow.NFT_TYPE,
                                  id: bloc.listNFT[index].id ?? 0,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: NFTItemPawn(
                              cryptoPawnModel: bloc.listNFT[index],
                              bloc: bloc,
                            ),
                          ),
                        );
                      },
                    )
                  : Column(
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
                    ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
