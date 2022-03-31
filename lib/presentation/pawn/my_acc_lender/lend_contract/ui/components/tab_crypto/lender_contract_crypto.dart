import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/bloc/lender_contract_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/ui/components/tab_crypto/lender_contract_crypto_item.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_error_view.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LenderContractCrypto extends StatefulWidget {
  const LenderContractCrypto({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final LenderContractCubit cubit;

  @override
  _LenderContractCryptoState createState() => _LenderContractCryptoState();
}

class _LenderContractCryptoState extends State<LenderContractCrypto> {
  @override
  void initState() {
    super.initState();
    widget.cubit.refreshVariableApi();
    widget.cubit.getListNft(
      userId: widget.cubit.userID,
      type: 0.toString(),
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
              widget.cubit.listCryptoLenderContract.clear();
            }
            widget.cubit.showContent();
          } else {
            widget.cubit.message = S.current.something_went_wrong;
            widget.cubit.listCryptoLenderContract.clear();
            widget.cubit.emit(LoadCryptoFtNftFail());
          }
          widget.cubit.listCryptoLenderContract =
              widget.cubit.listCryptoLenderContract + (state.list ?? []);
          widget.cubit.canLoadMoreList =
              widget.cubit.listCryptoLenderContract.length >=
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
                    type: '0',
                    // status: widget.cubit.statusFilter,
                  );
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  await widget.cubit.refreshGetListNft(type: '0');
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
          widget.cubit.refreshGetListNft(type: '0');
        },
        isHaveBackBtn: false,
      );
    } else {
      return (widget.cubit.listCryptoLenderContract.isNotEmpty)
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.cubit.listCryptoLenderContract.length,
                    itemBuilder: (context, index) {
                      return LenderContractCryptoItem(
                        obj: widget.cubit.listCryptoLenderContract[index],
                        cubit: widget.cubit,
                      );
                    },
                  ),
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
