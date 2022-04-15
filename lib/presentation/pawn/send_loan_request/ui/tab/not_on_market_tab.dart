import 'dart:async';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/ui/nft_item.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/bloc/send_loan_request_cubit.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotOnMarketTab extends StatefulWidget {
  const NotOnMarketTab({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final SendLoanRequestCubit cubit;

  @override
  _NotOnMarketTabState createState() => _NotOnMarketTabState();
}

class _NotOnMarketTabState extends State<NotOnMarketTab>
    with AutomaticKeepAliveClientMixin {
  TextEditingController controller = TextEditingController();
  late Timer _debounce;

  @override
  void initState() {
    super.initState();
    _debounce = Timer(const Duration(milliseconds: 500), () {});
    widget.cubit.getListNft();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _debounce.cancel();
  //   widget.cubit.close();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendLoanRequestCubit, SendLoanRequestState>(
      listener: (context, state) {
        if (state is ListSelectNftCollateralNotOnMarketGetApi) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (widget.cubit.refresh) {
              widget.cubit.contentNftOnSelectNotOnMarket.clear();
            }
            widget.cubit.showContent();
          } else {
            widget.cubit.message = state.message ?? '';
            widget.cubit.contentNftOnSelectNotOnMarket.clear();
            widget.cubit.showError();
          }

          widget.cubit.contentNftOnSelectNotOnMarket =
              widget.cubit.contentNftOnSelectNotOnMarket + (state.list ?? []);
          widget.cubit.canLoadMoreList =
              widget.cubit.contentNftOnSelectNotOnMarket.length >=
                  ApiConstants.DEFAULT_PAGE_SIZE;
          widget.cubit.loadMore = false;
          widget.cubit.refresh = false;
        }
      },
      bloc: widget.cubit,
      builder: (context, state) {
        return StateStreamLayout(
          isBack: false,
          retry: () {
            widget.cubit.refreshNotOnMarket(
              widget.cubit.getCurrentWallet(),
            );
          },
          textEmpty: widget.cubit.message,
          error: AppException(S.current.error, widget.cubit.message),
          stream: widget.cubit.stateStream,
          child: NotificationListener<ScrollNotification>(
            onNotification: (value) {
              if (widget.cubit.canLoadMoreList &&
                  value.metrics.pixels == value.metrics.maxScrollExtent) {
                widget.cubit.loadMoreNotOnMarket();
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                await widget.cubit.refreshNotOnMarket(
                  widget.cubit.getCurrentWallet(),
                );
                controller.text = '';
              },
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: searchBar(),
                  ),
                  spaceH8,
                  if (widget.cubit.contentNftOnSelectNotOnMarket.isNotEmpty)
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom,
                        ),
                        shrinkWrap: true,
                        itemCount:
                            widget.cubit.contentNftOnSelectNotOnMarket.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: NFTItemWidget(
                              callBackNFT: () {
                                widget.cubit.checkNotOnMarket.add(true);
                                widget.cubit.checkData.add('');
                                widget.cubit.durationMy = '';
                                widget.cubit.durationType = '';
                                widget.cubit.loanAmountSymbol = '';
                                widget.cubit.loanAmount = '';
                                Navigator.pop(
                                  context,
                                  widget.cubit.contentNftOnSelectNotOnMarket[index].nft ??
                                      NftMarket(),
                                );
                              },
                              nftMarket: widget
                                      .cubit
                                      .contentNftOnSelectNotOnMarket[index]
                                      .nft ??
                                  NftMarket(),
                              isChoosing: true,
                              // pageRouter: widget.pageRouter,
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 170.w / 231.h,
                        ),
                      ),
                    )
                  else
                    state is ListSelectNftCollateralNotOnMarketGetApi
                        ? Padding(
                            padding: EdgeInsets.only(top: 150.h),
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
                          )
                        : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget searchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 343.w,
            height: 46.h,
            decoration: BoxDecoration(
              color: backSearch,
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 14.w,
                ),
                Image.asset(
                  ImageAssets.ic_search,
                  height: 16.h,
                  width: 16.w,
                ),
                SizedBox(
                  width: 10.7.w,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    onChanged: (value) {
                      widget.cubit.isShowIcCloseSearch.sink.add(true);
                      _onSearchChanged(value.trim());
                    },
                    cursorColor: AppTheme.getInstance().whiteColor(),
                    style: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16.sp,
                    ),
                    maxLength: 255,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isCollapsed: true,
                      counterText: '',
                      hintText: S.current.name_of_nft,
                      hintStyle: textNormal(
                        Colors.white54,
                        16.sp,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                StreamBuilder<bool>(
                  initialData: false,
                  stream: widget.cubit.isShowIcCloseSearch,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: snapshot.data ?? false,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            controller.text = '';
                            widget.cubit.isShowIcCloseSearch.sink.add(false);
                            widget.cubit.getListNft(
                              name: '',
                              isSearch: true,
                            );
                          });
                          FocusScope.of(context).unfocus();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 13.w,
                          ),
                          child: ImageIcon(
                            const AssetImage(
                              ImageAssets.ic_close,
                            ),
                            color: AppTheme.getInstance().whiteColor(),
                            size: 20.sp,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onSearchChanged(String query) {
    if (_debounce.isActive) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 900), () {
      widget.cubit.getListNft(
        name: query,
        isSearch: true,
      );
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
