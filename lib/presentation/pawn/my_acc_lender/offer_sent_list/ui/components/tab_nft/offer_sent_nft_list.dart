import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/nft/lender_loan_request_nft_item.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/offer_sent_list_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/ui/components/offer_sent_crypto_item.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_error_view.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class OfferSentNftList extends StatefulWidget {
  const OfferSentNftList({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final OfferSentListCubit cubit;

  @override
  _OfferSentNftListState createState() => _OfferSentNftListState();
}

class _OfferSentNftListState extends State<OfferSentNftList> {
  @override
  void initState() {
    super.initState();
    widget.cubit.refreshVariableApi();
    if (widget.cubit.listOfferSentNFT.isNotEmpty) {
      widget.cubit.listOfferSentNFT.clear();
    }
    widget.cubit.getListOfferSentCrypto(
      userId: widget.cubit.userID,
      type: 1.toString(),
      status: widget.cubit.statusFilter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfferSentListCubit, OfferSentListState>(
      listener: (context, state) {
        if (state is LoadCryptoResult) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (widget.cubit.refresh) {
              widget.cubit.listOfferSentNFT.clear();
            }
            widget.cubit.showContent();
          } else {
            widget.cubit.message = state.message ?? '';
            widget.cubit.listOfferSentNFT.clear();
            widget.cubit.emit(LoadCryptoFail());
          }
          widget.cubit.listOfferSentNFT =
              widget.cubit.listOfferSentNFT + (state.list ?? []);
          widget.cubit.canLoadMoreList =
              widget.cubit.listOfferSentNFT.length >=
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
            widget.cubit.refreshGetListOfferSentCrypto(type: '1');
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
                  widget.cubit.loadMoreGetListCrypto(type: '1', status: widget.cubit.statusFilter);
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  await widget.cubit.refreshGetListOfferSentCrypto(type: '1');
                },
                child: _content(state),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _content(OfferSentListState state) {
    if (state is LoadCryptoFail) {
      return StateErrorView(
        widget.cubit.message,
        () {
          widget.cubit.refreshGetListOfferSentCrypto();
        },
        isHaveBackBtn: false,
      );
    } else {
      return (widget.cubit.listOfferSentNFT.isNotEmpty)
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.cubit.listOfferSentNFT.length,
                    itemBuilder: (context, index) {
                      return OfferSentCryptoItem(
                        index: index,
                        model: widget.cubit.listOfferSentNFT[index],
                        cubit: widget.cubit,
                      );
                    },
                  ),
                ),
                if (state is LoadMoreCrypto)
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
