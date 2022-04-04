import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_result/bloc/collateral_result_bloc.dart';
import 'package:Dfy/presentation/pawn/collateral_result/bloc/collateral_result_state.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'filter_collateral.dart';
import 'item_become_bank.dart';
import 'item_collateral.dart';

class CollateralResultScreen extends StatefulWidget {
  const CollateralResultScreen({Key? key}) : super(key: key);

  @override
  _CollateralResultScreenState createState() => _CollateralResultScreenState();
}

class _CollateralResultScreenState extends State<CollateralResultScreen> {
  late CollateralResultBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CollateralResultBloc();
    _bloc.refreshPosts();
  }

  Widget widgetCheckList({
    required int numberLength,
    required int maxLength,
    required List<CollateralResultModel> list,
  }) {
    return (numberLength >= maxLength)
        ? ItemCollateral(
            bloc: _bloc,
            loadToken: list[maxLength - 1].loanSymbol ?? '',
            duration: _bloc.getTime(
              type: list[maxLength - 1].durationType ?? 0,
              time: list[maxLength - 1].durationQty ?? 0,
            ),
            address: list[maxLength - 1].walletAddress ?? '',
            iconLoadToken: ImageAssets.getSymbolAsset(
              list[maxLength - 1].loanSymbol ?? '',
            ),
            iconBorrower: ImageAssets.getSymbolAsset(
              list[maxLength - 1].loanSymbol ?? '',
            ),
            //todo img
            contracts: list[maxLength - 1].completedContracts.toString(),
            iconCollateral: ImageAssets.getSymbolAsset(
              list[maxLength - 1].collateralSymbol ?? '',
            ),
            collateral: '${formatPrice.format(
              list[maxLength - 1].collateralAmount,
            )} '
                '${list[maxLength - 1].collateralSymbol ?? ''}',
            id: list[maxLength - 1].id.toString(),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollateralResultBloc, CollateralResultState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is CollateralResultSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (_bloc.loadMoreRefresh) {}
            _bloc.showContent();
          } else {
            _bloc.mess = state.message ?? '';
            _bloc.showError();
          }
          _bloc.loadMoreLoading = false;
          if (_bloc.isRefresh) {
            _bloc.listCollateralResultModel.clear();
          }
          _bloc.listCollateralResultModel.addAll(state.listCollateral ?? []);
          _bloc.canLoadMoreMy = _bloc.listCollateralResultModel.length >=
              ApiConstants.DEFAULT_PAGE_SIZE;
        }
      },
      builder: (context, state) {
        final list = _bloc.listCollateralResultModel;
        return StateStreamLayout(
          retry: () {
            _bloc.getListCollateral();
          },
          textEmpty: _bloc.mess,
          error: AppException(S.current.error, _bloc.mess),
          stream: _bloc.stateStream,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  final FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Container(
                  height: 812.h,
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().bgBtsColor(),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.h),
                      topRight: Radius.circular(30.h),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceH16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 16.w,
                              ),
                              width: 28.w,
                              height: 28.h,
                              child: Image.asset(
                                ImageAssets.ic_back,
                              ),
                            ),
                          ),
                          Text(
                            S.current.collateral_result,
                            style: textNormalCustom(
                              null,
                              20.sp,
                              FontWeight.w700,
                            ).copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => FilterCollateral(
                                  bloc: _bloc,
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 16.w),
                              width: 24.w,
                              height: 24.h,
                              child: Image.asset(ImageAssets.ic_filter),
                            ),
                          ),
                        ],
                      ),
                      spaceH20,
                      line,
                      spaceH12,
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Text(
                          '${list.length} '
                          '${S.current.collateral_offers_match_your_search}',
                          style: textNormalCustom(
                            AppTheme.getInstance().pawnGray(),
                            16,
                            null,
                          ),
                        ),
                      ),
                      spaceH24,
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (_bloc.canLoadMore &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                              _bloc.loadMorePosts();
                            }
                            return true;
                          },
                          child: RefreshIndicator(
                            onRefresh: _bloc.refreshPosts,
                            child: SingleChildScrollView(
                              physics: const ClampingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              child: list.isNotEmpty
                                  ? Column(
                                      children: [
                                        widgetCheckList(
                                          numberLength: list.length,
                                          list: list,
                                          maxLength: 1,
                                        ),
                                        widgetCheckList(
                                          numberLength: list.length,
                                          list: list,
                                          maxLength: 2,
                                        ),
                                        Center(
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: const ItemBecomeBank(),
                                          ),
                                        ),
                                        spaceH20,
                                        if (list.length >= 3)
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: list.length - 2,
                                            itemBuilder: (context, index) =>
                                                ItemCollateral(
                                              loadToken:
                                                  list[index + 2].loanSymbol ??
                                                      '',
                                              duration: _bloc.getTime(
                                                type: list[index + 2]
                                                        .durationType ??
                                                    0,
                                                time: list[index + 2]
                                                        .durationQty ??
                                                    0,
                                              ),
                                              address: list[index + 2]
                                                      .walletAddress ??
                                                  '',
                                              iconLoadToken:
                                                  ImageAssets.getSymbolAsset(
                                                list[index + 2].loanSymbol ??
                                                    '',
                                              ),
                                              iconBorrower:
                                                  ImageAssets.getSymbolAsset(
                                                list[index + 2].loanSymbol ??
                                                    '',
                                              ),
                                              //todo img
                                              contracts: list[index + 2]
                                                  .completedContracts
                                                  .toString(),
                                              iconCollateral:
                                                  ImageAssets.getSymbolAsset(
                                                list[index + 2]
                                                        .collateralSymbol ??
                                                    '',
                                              ),
                                              collateral: '${formatPrice.format(
                                                list[index + 2]
                                                    .collateralAmount,
                                              )} '
                                                  '${list[index + 2].collateralSymbol ?? ''}',
                                              id: list[index + 2].id.toString(),
                                              bloc: _bloc,
                                            ),
                                          )
                                        else
                                          const SizedBox.shrink(),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
