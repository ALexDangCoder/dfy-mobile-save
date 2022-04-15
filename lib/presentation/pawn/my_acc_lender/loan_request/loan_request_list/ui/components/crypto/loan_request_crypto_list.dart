import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/bloc/lender_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/crypto/lender_loan_request_crypto_item.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_error_view.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoanRequestCryptoList extends StatefulWidget {
  const LoanRequestCryptoList({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final LenderLoanRequestCubit cubit;

  @override
  _LoanRequestCryptoList createState() => _LoanRequestCryptoList();
}

class _LoanRequestCryptoList extends State<LoanRequestCryptoList> {
  @override
  void initState() {
    super.initState();
    widget.cubit.refreshVariableApi();
    // if(widget.cubit.walletAddressDropDown.isNotEmpty) {
    //   widget.cubit.walletAddressDropDown.clear();
    //   widget.cubit.getListWallet();
    // }
    if (widget.cubit.crypoList.isNotEmpty) {
      widget.cubit.crypoList.clear();
    }
    widget.cubit.getListCryptoApi();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LenderLoanRequestCubit, LenderLoanRequestState>(
      listener: (context, state) {
        if (state is LoadLoanRequestResult) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (widget.cubit.refresh) {
              widget.cubit.crypoList.clear();
            }
            widget.cubit.showContent();
          } else {
            widget.cubit.crypoList.clear();
            widget.cubit.emit(LoadCryptoFail());
          }
          widget.cubit.crypoList = widget.cubit.crypoList + (state.list ?? []);
          widget.cubit.canLoadMoreList =
              widget.cubit.crypoList.length >= widget.cubit.defaultSize;
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
          error: AppException(S.current.error, S.current.something_went_wrong),
          textEmpty: '',
          child: SizedBox(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (widget.cubit.canLoadMoreList &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  widget.cubit.loadMoreGetListCrypto();
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

  Widget _content(LenderLoanRequestState state) {
    if (state is LoadCryptoFail) {
      return StateErrorView(
        S.current.something_went_wrong,
        () {
          widget.cubit.refreshGetListOfferSentCrypto();
        },
        isHaveBackBtn: false,
      );
    } else {
      return (widget.cubit.crypoList.isNotEmpty)
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.cubit.crypoList.length,
                    itemBuilder: (context, index) {
                      return LoanRequestCryptoItem(
                        cubit: widget.cubit,
                        cryptoModel: widget.cubit.crypoList[index],
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
