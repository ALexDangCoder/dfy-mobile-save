import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_detail_my_acc/ui/collateral_detail_my_acc.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/bloc/collateral_my_acc_bloc.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/bloc/collateral_my_acc_state.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../item_collateral_my_acc.dart';

class Crypto extends StatefulWidget {
  const Crypto({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final CollateralMyAccBloc bloc;

  @override
  _CryptoState createState() => _CryptoState();
}

class _CryptoState extends State<Crypto> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollateralMyAccBloc, CollateralMyAccState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is CollateralMyAccSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (widget.bloc.loadMoreRefresh) {}
            widget.bloc.showContent();
          } else {
            widget.bloc.mess = state.message ?? '';
            widget.bloc.showError();
          }
          widget.bloc.loadMoreLoading = false;
          if (widget.bloc.isRefresh) {
            widget.bloc.list.clear();
          }
          widget.bloc.list.addAll(state.listCollateral ?? []);
          widget.bloc.canLoadMoreMy =
              widget.bloc.list.length >= ApiConstants.DEFAULT_PAGE_SIZE;
        }
      },
      builder: (context, state) {
        final list = widget.bloc.list;
        return StateStreamLayout(
          retry: () {
            widget.bloc.getListCollateral();
          },
          textEmpty: widget.bloc.mess,
          error: AppException(S.current.error, widget.bloc.mess),
          stream: widget.bloc.stateStream,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (widget.bloc.canLoadMore &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                widget.bloc.loadMorePosts();
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: widget.bloc.refreshPosts,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: list.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: list.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    CollateralDetailMyAccScreen(
                                  id: list[index].id.toString(),
                                ),
                                settings: const RouteSettings(
                                  name: AppRouter.collateral_detail_myacc,
                                ),
                              ),
                            );
                          },
                          child: ItemCollateralMyAcc(
                            bloc: widget.bloc,
                            index: index,
                          ),
                        ),
                      )
                    : state is CollateralMyAccSuccess
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 60.h,
                              ),
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
          ),
        );
      },
    );
  }
}
