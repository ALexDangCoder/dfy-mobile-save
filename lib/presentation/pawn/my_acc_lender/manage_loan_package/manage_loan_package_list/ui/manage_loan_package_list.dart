import 'dart:async';
import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/bloc/manage_loan_package_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/components/become_pawnshop.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/create_new_loan_package/ui/create_new_loan_package.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/create_new_loan_package/ui/lending_setting.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/manage_loan_package_list/loan_package_detail/ui/loan_package_detail.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/widget/loan_package_item.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_fail.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/base_items/custom_hide_keyboard.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/success/successful_by_title.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageLoanPackageList extends StatefulWidget {
  const ManageLoanPackageList({Key? key}) : super(key: key);

  @override
  _ManageLoanPackageListState createState() => _ManageLoanPackageListState();
}

class _ManageLoanPackageListState extends State<ManageLoanPackageList> {
  late ManageLoanPackageCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ManageLoanPackageCubit();
    cubit.getListPawnShop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageLoanPackageCubit, ManageLoanPackageState>(
      listener: (context, state) async {
        if (state is NotPawnShopFound) {
          cubit.showContent();
          unawaited(
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BecomeAPawnShop(),
              ),
            ),
          );
        } else if (state is ManageLoadApiListPawnShop) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (cubit.refresh) {
              cubit.listPawnShop.clear();
            }
            cubit.showContent();
          } else {
            cubit.showError();
          }
          cubit.listPawnShop = cubit.listPawnShop + (state.list ?? []);
          cubit.canLoadMoreList =
              cubit.listPawnShop.length >= cubit.defaultSize;
          cubit.loadMore = false;
          cubit.refresh = false;
        } else {
          //nothing
        }
      },
      bloc: cubit,
      builder: (context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException(S.current.error, S.current.something_went_wrong),
          textEmpty: S.current.something_went_wrong,
          retry: () {},
          child: CustomGestureDetectorOnTapHideKeyBoard(
            child: Scaffold(
              backgroundColor: Colors.black,
              floatingActionButton: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateNewLoanPackage(
                        pawnShopId: cubit.idPawnShop,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: AppTheme.getInstance().colorFab(),
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 32.sp,
                    color: AppTheme.getInstance().whiteColor(),
                  ),
                ),
              ),
              body: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 375.w,
                  height: 812.h,
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().bgBtsColor(),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: _content(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _content() {
    return cubit.listPawnShop.isNotEmpty
        ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              children: [
                _header(),
                Divider(
                  color: AppTheme.getInstance().divideColor(),
                ),
                Flexible(
                  child: SizedBox(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (cubit.canLoadMoreList &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          cubit.loadMoreGetListPawnShop();
                        }
                        return true;
                      },
                      child: RefreshIndicator(
                        onRefresh: () async {
                          cubit.refreshGetListPawnShop();
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              spaceH24,
                              Text(
                                S.current.lending_setting.toUpperCase(),
                                style: textNormalCustom(
                                  AppTheme.getInstance()
                                      .unselectedTabLabelColor(),
                                  14,
                                  FontWeight.w400,
                                ),
                              ),
                              spaceH20,
                              _lenderSettingItem(),
                              spaceH32,
                              Text(
                                S.current.loan_package.toUpperCase(),
                                style: textNormalCustom(
                                  AppTheme.getInstance()
                                      .unselectedTabLabelColor(),
                                  14,
                                  FontWeight.w400,
                                ),
                              ),
                              spaceH16,
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: cubit.listPawnShop.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      goTo(
                                        context,
                                        LoanPackageDetail(
                                            id: cubit.listPawnShop[index].id ??
                                                0),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        LoanPackageItem(
                                          pawnshopPackage:
                                              cubit.listPawnShop[index],
                                        ),
                                        spaceH16,
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: double.infinity,
            width: double.infinity,
          );
  }

  SizedBox _header() {
    return SizedBox(
      height: 64.h,
      child: SizedBox(
        height: 28.h,
        width: 343.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: InkWell(
                onTap: () {
                  //todo
                },
                child: SizedBox(
                  height: 30.h,
                  width: 30.w,
                  child: Image.asset(ImageAssets.ic_menu),
                ),
              ),
            ),
            Flexible(
              flex: 6,
              child: Align(
                child: Text(
                  S.current.manage_loan_package,
                  textAlign: TextAlign.center,
                  style: titleText(
                    color: AppTheme.getInstance().textThemeColor(),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                right: 39.w,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _lenderSettingItem() {
    return Container(
      width: 343.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        image: const DecorationImage(
          image: AssetImage(ImageAssets.bg_manage_loan_package_list),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Column(
              children: [
                Text(
                  S.current.description_manage_loan_1,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    14,
                    FontWeight.w600,
                  ),
                ),
                Text(
                  S.current.description_manage_loan_2,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    14,
                    FontWeight.w600,
                  ),
                ),
                spaceH13,
                InkWell(
                  onTap: () {
                    // goTo(context, LendingSetting(cubit: cubit));
                  },
                  child: Container(
                    width: 165.w,
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: ButtonGold(
                      title: S.current.add_lend_setting,
                      isEnable: true,
                      fixSize: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
