import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/bloc/send_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/send_loan_request_nft.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/check_tab_bar.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/crypto_currentcy.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendLoanRequest extends StatefulWidget {
  const SendLoanRequest(
      {Key? key,
      this.index = 0,
      required this.packageId,
      required this.pawnshopType,
      required this.collateralAccepted})
      : super(key: key);
  final int index;
  final String packageId;
  final String pawnshopType;
  final List<AcceptableAssetsAsCollateral> collateralAccepted;

  @override
  _SendLoanRequestState createState() => _SendLoanRequestState();
}

class _SendLoanRequestState extends State<SendLoanRequest>
    with SingleTickerProviderStateMixin {
  late SendLoanRequestCubit cubit;
  late TabController _tabController;
  late bool checkLogin;
  String walletAddress = PrefsService.getCurrentWalletCore();

  @override
  void initState() {
    super.initState();
    cubit = SendLoanRequestCubit();
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    checkLogin = cubit.getLoginState();
    cubit.tabIndex.add(widget.index);
    cubit.collateralAccepted = widget.collateralAccepted;
    _tabController =
        TabController(initialIndex: widget.index, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: 763.h,
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
                      'Send loan request',
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
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 16.w),
                        width: 24.w,
                        height: 24.h,
                        child: Image.asset(ImageAssets.ic_close),
                      ),
                    ),
                  ],
                ),
                spaceH20,
                line,
                BlocConsumer<SendLoanRequestCubit, SendLoanRequestState>(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state is NoLogin) {
                      showDialog(
                        context: context,
                        builder: (context) => const ConnectWalletDialog(
                          isRequireLoginEmail: true,
                        ),
                      ).then((_) => cubit.getLoginState());
                    }
                  },
                  builder: (context, state) {
                    if (state is GetWalletSuccess) {
                      return SizedBox(
                        height: 696.h,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              spaceH12,
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 16.w,
                                ),
                                child: Text(
                                  'Collateral type',
                                  style: textNormalCustom(
                                    Colors.white,
                                    16,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                              spaceH14,
                              SizedBox(
                                child: StreamBuilder<int>(
                                    stream: cubit.tabIndex,
                                    builder: (context, snapshot) {
                                      return TabBar(
                                        unselectedLabelColor: Colors.white,
                                        labelColor: Colors.white,
                                        onTap: (int i) {
                                          cubit.tabIndex.add(i);
                                        },
                                        indicatorColor:
                                            AppTheme.getInstance().bgBtsColor(),
                                        tabs: [
                                          Tab(
                                            icon: CheckboxItemTab(
                                              isSelected: snapshot.data == 0,
                                              nameCheckbox: 'Cryptocurrency',
                                            ),
                                          ),
                                          Tab(
                                            icon: CheckboxItemTab(
                                              isSelected: snapshot.data == 1,
                                              nameCheckbox: 'NFT',
                                            ),
                                          )
                                        ],
                                        controller: _tabController,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                      );
                                    }),
                              ),
                              StreamBuilder<int>(
                                  stream: cubit.tabIndex,
                                  builder: (context, snapshot) {
                                    return SizedBox(
                                      height: cubit.tabIndex.value == 0
                                          ? 699.h
                                          : 755.h,
                                      child: TabBarView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        controller: _tabController,
                                        children: [
                                          CryptoCurrency(
                                            cubit: cubit,
                                            packageId: widget.packageId,
                                            walletAddress: walletAddress,
                                            hasEmail: cubit.hasEmail,
                                            pawnshopType: widget.pawnshopType,
                                          ),
                                          SendLoanRequestNft(
                                            packageId: widget.packageId,
                                            cubit: cubit,
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: 350.h,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.r,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
