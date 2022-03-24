import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_list_my_acc/bloc/borrow_list_my_acc_bloc.dart';
import 'package:Dfy/presentation/pawn/borrow_list_my_acc/bloc/borrow_list_my_acc_state.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../item_crypto.dart';

class CryptoTab extends StatefulWidget {
  const CryptoTab({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final BorrowListMyAccBloc bloc;

  @override
  _CryptoTabState createState() => _CryptoTabState();
}

class _CryptoTabState extends State<CryptoTab> {
  @override
  void initState() {
    super.initState();
    widget.bloc.list.clear();
    widget.bloc.refreshPosts(
      type: BorrowListMyAccBloc.BORROW_TYPE,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = widget.bloc;
    return BlocConsumer<BorrowListMyAccBloc, BorrowListMyAccState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is BorrowListMyAccSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (bloc.loadMoreRefresh) {}
            bloc.showContent();
          } else {
            bloc.mess = state.message ?? '';
            bloc.showError();
          }
          bloc.loadMoreLoading = false;
          if (bloc.isRefresh) {
            bloc.list.clear();
          }
          bloc.list.addAll(state.list ?? []);
          bloc.canLoadMoreMy =
              bloc.list.length >= ApiConstants.DEFAULT_PAGE_SIZE;
        }
      },
      builder: (context, state) {
        return StateStreamLayout(
          retry: () {
            widget.bloc.refreshPosts(
              type: BorrowListMyAccBloc.BORROW_TYPE,
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
                  type: BorrowListMyAccBloc.BORROW_TYPE,
                );
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                await widget.bloc.refreshPosts(
                  type: BorrowListMyAccBloc.BORROW_TYPE,
                );
              },
              child: bloc.list.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: ListView.builder(
                        itemCount: bloc.list.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            //todo
                          },
                          child: ItemCrypto(
                            obj: bloc.list[index],
                            bloc: bloc,
                          ),
                        ),
                      ),
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
}
