import 'dart:async';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/bloc/send_loan_request_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListSelectNftCollateral extends StatefulWidget {
  const ListSelectNftCollateral({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final SendLoanRequestCubit cubit;

  @override
  _ListSelectNftCollateralState createState() =>
      _ListSelectNftCollateralState();
}

class _ListSelectNftCollateralState extends State<ListSelectNftCollateral> {
  TextEditingController controller = TextEditingController();
  late Timer _debounce;

  @override
  void initState() {
    super.initState();
    _debounce = Timer(const Duration(milliseconds: 500), () {});
    widget.cubit
        .getSelectNftCollateral('0x0103919F4084a836288e895143E4f031761fcFbE');
  }

  @override
  void dispose() {
    _debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 375.w,
            margin: EdgeInsets.only(top: 26.h),
            decoration: BoxDecoration(
              color: AppTheme.getInstance().bgBtsColor(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: BlocConsumer<SendLoanRequestCubit, SendLoanRequestState>(
              listener: (context, state) {
                if (state is ListSelectNftCollateralGetApi) {
                  if (state.completeType == CompleteType.SUCCESS) {
                    if (widget.cubit.loadMoreRefresh) {
                      widget.cubit.contentNftOnSelect.clear();
                    }
                    if ((state.list ?? []).isEmpty) {
                      widget.cubit.showEmpty();
                    } else {
                      widget.cubit.showContent();
                    }
                  } else {
                    widget.cubit.message = state.message ?? '';
                    widget.cubit.showError();
                  }
                }
              },
              bloc: widget.cubit,
              builder: (context, state) {
                return StateStreamLayout(
                  retry: () {
                    widget.cubit.refreshGetListNftCollateral(
                      '0x0103919F4084a836288e895143E4f031761fcFbE',
                    );
                  },
                  textEmpty: widget.cubit.message,
                  error: AppException(S.current.error, widget.cubit.message),
                  stream: widget.cubit.stateStream,
                  child: BaseDesignScreen(
                    title: 'Select NFT collateral',
                    isHaveLeftIcon: false,
                    isImage: true,
                    text: ImageAssets.ic_close,
                    onRightClick: () {
                      Navigator.pop(context);
                    },
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (value) {
                        if (widget.cubit.canLoadMore &&
                            value.metrics.pixels ==
                                value.metrics.maxScrollExtent) {
                          widget.cubit.loadMoreGetListNftCollateral(
                              '0x0103919F4084a836288e895143E4f031761fcFbE');
                        }
                        return true;
                      },
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await widget.cubit.refreshGetListNftCollateral(
                              '0x0103919F4084a836288e895143E4f031761fcFbE');
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                top: 12.h,
                                bottom: 6.h,
                              ),
                              child: searchBar(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
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
                  }
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
      //todo
    });
  }
}
