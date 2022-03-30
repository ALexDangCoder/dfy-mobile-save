import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
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
    print('current wallet filter ${widget.cubit.walletAddressFilter}');
    print('current wallet filter ${PrefsService.getCurrentBEWallet()}');
    widget.cubit.refreshVariableApi();
    if(widget.cubit.listNftLenderContract.isNotEmpty) {
      widget.cubit.listNftLenderContract.clear();
    }
    widget.cubit.getListNft(
      type: 1.toString(),
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
            widget.cubit.showContent();
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
                Container(

                ),
                // Expanded(
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     itemCount: widget.cubit.listOfferSentNFT.length,
                //     itemBuilder: (context, index) {
                //       return OfferSentCryptoItem(
                //         index: index,
                //         model: widget.cubit.listOfferSentNFT[index],
                //         cubit: widget.cubit,
                //       );
                //     },
                //   ),
                // ),
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
