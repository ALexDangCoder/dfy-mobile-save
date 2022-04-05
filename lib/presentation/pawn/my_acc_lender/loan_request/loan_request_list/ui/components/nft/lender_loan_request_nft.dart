import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/bloc/lender_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/nft/lender_loan_request_nft_item.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/widgets/views/state_error_view.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoanRequestNftList extends StatefulWidget {
  const LoanRequestNftList({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final LenderLoanRequestCubit cubit;

  @override
  _LoanRequestNftListState createState() => _LoanRequestNftListState();
}

class _LoanRequestNftListState extends State<LoanRequestNftList> {
  @override
  void initState() {
    super.initState();
    if (widget.cubit.nftList.isNotEmpty) {
      widget.cubit.nftList.clear();
    }
    widget.cubit.getListNftApi();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LenderLoanRequestCubit, LenderLoanRequestState>(
      bloc: widget.cubit,
      listener: (context, state) {
        if (state is LoadLoanRequestResult) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (widget.cubit.refresh) {
              widget.cubit.nftList.clear();
            }
            widget.cubit.showContent();
          } else {
            widget.cubit.nftList.clear();
            widget.cubit.emit(LoadCryptoFail());
          }
          widget.cubit.nftList = widget.cubit.nftList + (state.list ?? []);
          widget.cubit.canLoadMoreList =
              widget.cubit.nftList.length >= widget.cubit.defaultSize;
          widget.cubit.loadMore = false;
          widget.cubit.refresh = false;
        }
      },
      builder: (context, state) {
        return StateStreamLayout(
          stream: widget.cubit.stateStream,
          textEmpty: S.current.something_went_wrong,
          error: AppException(S.current.error, S.current.something_went_wrong),
          retry: () {
            widget.cubit.refreshGetListNftLoanRequest();
          },
          child: SizedBox(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (widget.cubit.canLoadMoreList &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  // widget.cubit.loadMoreGetListCrypto(); todo
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  await widget.cubit.refreshGetListNftLoanRequest();
                },
                child: _content(state),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _content(LenderLoanRequestState state) {
    if (state is LoadCryptoFail) {
      return StateErrorView(
        S.current.something_went_wrong,
        () {
          widget.cubit.refreshGetListNftLoanRequest();
        },
        isHaveBackBtn: false,
      );
    } else {
      return (widget.cubit.nftList.isNotEmpty)
          ? Container(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.cubit.nftList.length,
                      itemBuilder: (context, index) {
                        return LenderLoanRequestNftItem(
                          cubit: widget.cubit,
                          nftModel: widget.cubit.nftList[index],
                        );
                      },
                    ),
                  ),
                  if (state is LoadMoreCrypto)
                    Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.r,
                        color: AppTheme.getInstance().whiteColor(),
                      ),
                    )
                  else
                    SizedBox()
                ],
              ),
            )
          : Container(
              color: AppTheme.getInstance().bgBtsColor(),
            );
    }
  }
}
