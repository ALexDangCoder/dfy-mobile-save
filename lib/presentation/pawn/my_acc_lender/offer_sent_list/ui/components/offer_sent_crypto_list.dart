import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/offer_sent_list_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/ui/components/offer_sent_crypto_item.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_error_view.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferSentListCrypto extends StatefulWidget {
  const OfferSentListCrypto({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final OfferSentListCubit cubit;

  @override
  _OfferSentListCrypto createState() => _OfferSentListCrypto();
}

class _OfferSentListCrypto extends State<OfferSentListCrypto> {
  @override
  void initState() {
    super.initState();
    widget.cubit.refreshVariableApi();
    // if(widget.cubit.walletAddressDropDown.isNotEmpty) {
    //   widget.cubit.walletAddressDropDown.clear();
    //   widget.cubit.getListWallet();
    // }
    if (widget.cubit.listOfferSentCrypto.isNotEmpty) {
      widget.cubit.listOfferSentCrypto.clear();
    }
    widget.cubit.getListOfferSentCrypto(
      userId: widget.cubit.userID,
      type: 0.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfferSentListCubit, OfferSentListState>(
      listener: (context, state) {
        if (state is LoadCryptoResult) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (widget.cubit.refresh) {
              widget.cubit.listOfferSentCrypto.clear();
            }
            widget.cubit.showContent();
          } else {
            widget.cubit.message = state.message ?? '';
            widget.cubit.listOfferSentCrypto.clear();
            widget.cubit.emit(LoadCryptoFail());
          }
          widget.cubit.listOfferSentCrypto =
              widget.cubit.listOfferSentCrypto + (state.list ?? []);
          widget.cubit.canLoadMoreList =
              widget.cubit.listOfferSentCrypto.length >=
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
            widget.cubit.refreshGetListOfferSentCrypto();
          },
          error: AppException(S.current.error, widget.cubit.message),
          textEmpty: widget.cubit.message,
          child: SizedBox(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (widget.cubit.canLoadMoreList &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  widget.cubit.loadMoreGetListCrypto(
                    status: widget.cubit.statusFilter,
                  );
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  await widget.cubit.refreshGetListOfferSentCrypto();
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
      return (widget.cubit.listOfferSentCrypto.isNotEmpty)
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.cubit.listOfferSentCrypto.length,
                    itemBuilder: (context, index) {
                      return OfferSentCryptoItem(
                        index: index,
                        model: widget.cubit.listOfferSentCrypto[index],
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
