import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_list_my_acc/ui/item_nft_pawn.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/contract_detail.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/bloc/lender_contract_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_error_view.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LenderContractNft extends StatefulWidget {
  const LenderContractNft({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final LenderContractCubit cubit;

  @override
  _LenderContractNftState createState() => _LenderContractNftState();
}

class _LenderContractNftState extends State<LenderContractNft> {
  @override
  void initState() {
    super.initState();
    widget.cubit.refreshVariableApi();
    if (widget.cubit.listNftLenderContract.isNotEmpty) {
      widget.cubit.listNftLenderContract.clear();
    }
    widget.cubit.getListNft(
      type: 1.toString(),
      userId: widget.cubit.userID,
      status: widget.cubit.statusFilter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LenderContractCubit, LenderContractState>(
      listener: (context, state) {
        if (state is LoadCryptoFtNftResult) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (widget.cubit.refresh) {
              widget.cubit.listNftLenderContract.clear();
            }
          } else {
            widget.cubit.message = S.current.something_went_wrong;
            widget.cubit.listNftLenderContract.clear();
            widget.cubit.emit(LoadCryptoFtNftFail());
          }
          widget.cubit.listNftLenderContract =
              widget.cubit.listNftLenderContract + (state.list ?? []);
          widget.cubit.canLoadMoreList =
              widget.cubit.listNftLenderContract.length >=
                  widget.cubit.defaultSize;
          widget.cubit.loadMore = false;
          widget.cubit.refresh = false;
        }
      },
      bloc: widget.cubit,
      builder: (context, state) {
        return StateStreamLayout(
          stream: widget.cubit.stateStream,
          retry: () {
            widget.cubit.refreshGetListNft();
          },
          error: AppException(
            S.current.error,
            S.current.something_went_wrong,
          ),
          textEmpty: widget.cubit.message,
          child: SizedBox(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (widget.cubit.canLoadMoreList &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  widget.cubit.loadMoreGetListNft(
                    type: '1',
                    // status: widget.cubit.statusFilter,
                  );
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  await widget.cubit.refreshGetListNft(type: '1');
                },
                child: _content(state),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _content(LenderContractState state) {
    if (state is LoadCryptoFtNftFail) {
      return StateErrorView(
        widget.cubit.message,
        () {
          widget.cubit.refreshGetListNft();
        },
        isHaveBackBtn: false,
      );
    } else {
      return (widget.cubit.listNftLenderContract.isNotEmpty)
          ? Column(
              children: [
                GridView.builder(
                  physics: const ClampingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  shrinkWrap: true,
                  itemCount: widget.cubit.listNftLenderContract.length,
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
                              typeNavigator: TypeNavigator.LENDER_TYPE,
                              id: widget
                                      .cubit.listNftLenderContract[index].id ??
                                  0,
                            ),
                            settings: const RouteSettings(
                              name: AppRouter.contract_detail_my_acc,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: NFTItemPawn(
                          cryptoPawnModel:
                              widget.cubit.listNftLenderContract[index],
                        ),
                      ),
                    );
                  },
                ),
                if (state is LoadMoreNFT)
                  Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.r,
                      color: Colors.white,
                    ),
                  )
                else
                  SizedBox()
              ],
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 150.h,
                ),
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
              ),
            );
    }
  }
}
