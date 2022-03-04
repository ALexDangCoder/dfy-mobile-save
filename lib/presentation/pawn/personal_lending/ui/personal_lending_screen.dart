import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/dialog_filter.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/item_header_filter.dart';
import 'package:Dfy/presentation/pawn/personal_lending/bloc/personal_lending_bloc.dart';
import 'package:Dfy/presentation/pawn/personal_lending/bloc/personal_lending_state.dart';
import 'package:Dfy/presentation/pawn/personal_lending/ui/personal_item.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'filter_personal.dart';

class PersonalLendingScreen extends StatefulWidget {
  const PersonalLendingScreen({Key? key}) : super(key: key);

  @override
  _PersonalLendingScreenState createState() => _PersonalLendingScreenState();
}

class _PersonalLendingScreenState extends State<PersonalLendingScreen> {
  late PersonalLendingBloc _bloc;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _bloc = PersonalLendingBloc();
    _bloc.refreshPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalLendingBloc, PersonalLendingState>(
      bloc: _bloc,
      listener: (context, state) {
        ///Loading
        if (state is PersonalLendingLoading && _bloc.isRefresh) {
          if (!_isLoading) {
            _isLoading = true;
            showLoading(
              context,
              close: (value) {
                _isLoading = false;
              },
            );
          }
        }

        if (_isLoading && state is! PersonalLendingLoading) {
          hideLoading(context);
        }

        ///Get Blog List Completed
        if (state is PersonalLendingSuccess) {
          if (_bloc.isRefresh) {
            _bloc.list.clear();
          }
          _bloc.list.addAll(state.listPersonal ?? []);
        }
      },
      builder: (context, state) {
        final list = _bloc.list;
        return StateStreamLayout(
          retry: () {},
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
                  height: 764.h,
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
                            S.current.personal_lending,
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
                                builder: (context) => PersonalFilter(
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
                      spaceH24,
                      Center(
                        child: SizedBox(
                          width: 343.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final res = await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => DialogFilter(
                                      title: S.current.rating,
                                      type: _bloc.typeRating ??
                                          TypeFilter.HIGH_TO_LOW,
                                    ),
                                  );
                                  if (res != null) {
                                    _bloc.typeRating = res;
                                    //todo filter
                                  }
                                },
                                child: ItemHeaderFilter(
                                  title: S.current.rating,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final res = await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => DialogFilter(
                                      title: S.current.rating,
                                      type: _bloc.typeInterest ??
                                          TypeFilter.HIGH_TO_LOW,
                                    ),
                                  );
                                  if (res != null) {
                                    _bloc.typeInterest = res;
                                    //todo filter
                                  }
                                },
                                child: ItemHeaderFilter(
                                  title: S.current.interest_rate_pawn,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final res = await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => DialogFilter(
                                      title: S.current.rating,
                                      type: _bloc.typeSigned ??
                                          TypeFilter.HIGH_TO_LOW,
                                    ),
                                  );
                                  if (res != null) {
                                    _bloc.typeSigned = res;
                                    //todo filter
                                  }
                                },
                                child: ItemHeaderFilter(
                                  title: S.current.signed_contracts,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      spaceH20,
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
                              child: ListView.builder(
                                padding: EdgeInsets.only(
                                  bottom: 20.h,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: list.length,
                                itemBuilder: (context, index) => PersonalItem(
                                  rate: list[index].reputation.toString(),
                                  isShop: list[index].isKYC ?? false,
                                  nameShop: list[index].name.toString(),
                                  interestRate:
                                      '${list[index].minInterestRate}%'
                                      '-${list[index].maxInterestRate}%',
                                  collateral: list[index]
                                          .p2PLenderPackages?[0]
                                          .acceptableAssetsAsCollateral ??
                                      [],
                                  total: list[index].totalLoanValue.toString(),
                                  signedContract:
                                      list[index].completedContracts.toString(),
                                ),
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
