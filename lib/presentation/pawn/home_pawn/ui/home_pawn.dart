import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/pawn/borrow_lend/ui/borrow_lend.dart';
import 'package:Dfy/presentation/pawn/home_pawn/bloc/home_pawn_cubit.dart';
import 'package:Dfy/presentation/pawn/home_pawn/ui/components/list_item_horizontal.dart';
import 'package:Dfy/presentation/pawn/lending_registration/ui/leding_registration.dart';
import 'package:Dfy/presentation/pawn/notifications/ui/total_notification.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:Dfy/widgets/dialog/modal_progress_hud.dart';
import 'package:Dfy/widgets/text/text_gradient.dart';
import 'package:Dfy/widgets/views/state_error_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

//todo chờ be thêm icon url token trong nfts collateral

final formatValue = NumberFormat('###,###,###.###', 'en_US');

class HomePawn extends StatefulWidget {
  const HomePawn({Key? key}) : super(key: key);

  @override
  _HomePawnState createState() => _HomePawnState();
}

class _HomePawnState extends State<HomePawn> {
  late HomePawnCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = HomePawnCubit();
    cubit.callAllApi();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePawnCubit, HomePawnState>(
      listener: (ctx, state) {
        _content(state);
      },
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.getInstance().bgBtsColor(),
          body: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppTheme.getInstance().bgColorHomePawn(),
              ),
            ),
            child: _content(state),
          ),
        );
      },
    );
  }

  Widget _content(HomePawnState state) {
    if (state is HomePawnLoadSuccess &&
        state.completeType == CompleteType.SUCCESS) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderWidget(),
          Container(
            height: 1.h,
            color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
          ),
          RefreshIndicator(
            onRefresh: () async {
              await cubit.callAllApi(isRefresh: true);
            },
            child: SizedBox(
              height: 699.h,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH24,
                    // Container(
                    //   margin: EdgeInsets.only(left: 16.w),
                    //   child: Text(
                    //     S.current.header_title_pawn,
                    //     style: textNormalCustom(
                    //       AppTheme.getInstance().whiteColor(),
                    //       20,
                    //       FontWeight.w700,
                    //     ),
                    //   ),
                    // ),
                    spaceH16,
                    // BannerPawnSlide(
                    //   cubit: cubit,
                    // ),
                    // _buildBanner(),
                    spaceH32,
                    // ListItemHorizontal(
                    //   title: S.current.top_rated_lenders,
                    //   listItemWidget: SizedBox(
                    //     height: 165.h,
                    //     child: ListView.builder(
                    //       itemCount: cubit.topRatedLenders.length,
                    //       shrinkWrap: true,
                    //       scrollDirection: Axis.horizontal,
                    //       itemBuilder: (ctx, index) {
                    //         return Row(
                    //           children: [
                    //             _itemTopRate(
                    //               title: cubit.topRatedLenders[index].pawnShop
                    //                       ?.name ??
                    //                   '',
                    //               img: cubit.topRatedLenders[index].pawnShop
                    //                       ?.avatar ??
                    //                   '',
                    //             ),
                    //             spaceW20,
                    //           ],
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // spaceH32,
                    ListItemHorizontal(
                      title: S.current.what_you_can_pawn,
                      isHaveArrow: false,
                      listItemWidget: SizedBox(
                        height: 161.h,
                        child: ListView.builder(
                          itemCount: cubit.borrowFeatLend.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Row(
                              children: [
                                _itemBorrowFtLend(
                                  title: cubit.borrowFeatLend[index].title,
                                  imageBg:
                                      cubit.borrowFeatLend[index].imgBackGround,
                                  suffixTitle:
                                      cubit.borrowFeatLend[index].sufTitle,
                                  type: cubit.borrowFeatLend[index].type,
                                ),
                                spaceW20,
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    spaceH32,
                    // ListItemHorizontal(
                    //   title: S.current.top_sale_pawn,
                    //   listItemWidget: SizedBox(
                    //     height: 267.h,
                    //     child: ListView.builder(
                    //       itemCount: cubit.topSalePawnShop.length,
                    //       shrinkWrap: true,
                    //       scrollDirection: Axis.horizontal,
                    //       itemBuilder: (_, index) {
                    //         return _itemPawnShopPackage(
                    //           imgShop: cubit.topSalePawnShop[index]
                    //                   .pawnShopPackage?.pawnShop?.avatar ??
                    //               '',
                    //           iconTokenUrl: cubit.topSalePawnShop[index]
                    //                   .pawnShopPackage?.loanToken?.iconUrl ??
                    //               '',
                    //           signedContracts: cubit
                    //               .topSalePawnShop[index].signedContract
                    //               .toString(),
                    //           nameShop: cubit.topSalePawnShop[index]
                    //                   .pawnShopPackage?.name ??
                    //               '',
                    //           reputation: cubit.topSalePawnShop[index]
                    //                   .pawnShopPackage?.pawnShop?.reputation ??
                    //               0,
                    //           loan: cubit.topSalePawnShop[index].pawnShopPackage
                    //                   ?.allowedLoanMax ??
                    //               0,
                    //           interestRate: cubit.topSalePawnShop[index]
                    //                   .pawnShopPackage?.interestRate ??
                    //               0,
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // spaceH32,
                    // ListItemHorizontal(
                    //   title: S.current.nft_collateral,
                    //   listItemWidget: SizedBox(
                    //     height: 231.h,
                    //     child: ListView.builder(
                    //       itemCount: cubit.nftsCollateralsPawn.length,
                    //       shrinkWrap: true,
                    //       scrollDirection: Axis.horizontal,
                    //       itemBuilder: (_, index) {
                    //         return Row(
                    //           children: [
                    //             NFTItemWidget(
                    //               nftMarket: cubit.nftsCollateralsPawn[index]
                    //                       .nftModel ??
                    //                   NftMarket(),
                    //             ),
                    //             spaceW12,
                    //           ],
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    spaceH32,
                    // _buildBecomePawnShop(),
                    SizedBox(
                      height: 200.h,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      );
    } else if (state is HomePawnLoadSuccess &&
        state.completeType == CompleteType.ERROR) {
      return StateErrorView(
        S.current.something_went_wrong,
        () async {
          await cubit.callAllApi(isRefresh: true);
        },
        isHaveBackBtn: false,
      );
    } else {
      return Container(
        color: AppTheme.getInstance().bgBtsColor(),
        child: const ModalProgressHUD(
          inAsyncCall: true,
          progressIndicator: CupertinoLoading(),
          child: SizedBox(),
        ),
      );
    }
  }

  Padding _buildBecomePawnShop() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.become_pawnshop,
            style: textNormalCustom(
              AppTheme.getInstance().whiteColor(),
              20,
              FontWeight.w700,
            ),
          ),
          spaceH24,
          Stack(
            children: [
              SizedBox(
                height: 168.h,
                width: 343.w,
                child: Image.asset(
                  ImageAssets.bgBecomePawnShop,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 31.h,
                left: 13.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.des_become_pawnshop,
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        12,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH18,
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => const ConnectWalletDialog(
                            navigationTo: LendingRegistration(),
                            isRequireLoginEmail: true,
                          ),
                        ).then((_) => null);
                      },
                      child: Row(
                        children: [
                          Text(
                            S.current.only_become_pawnshop,
                            style: textNormalCustom(
                              AppTheme.getInstance().blueColor(),
                              12,
                              FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                            width: 12,
                            child: Image.asset(
                              ImageAssets.blueArrow,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Row _itemPawnShopPackage({
    required String imgShop,
    required String signedContracts,
    required String nameShop,
    required String iconTokenUrl,
    required int reputation,
    required double loan,
    required int interestRate,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 262.w,
          height: 267.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 222.h,
                width: 262.w,
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 48.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppTheme.getInstance().bgProgressingColors(),
                ),
                child: Column(
                  children: [
                    Text(
                      nameShop.handleTitle(),
                      style: textNormalCustom(
                        AppTheme.getInstance().getAmountColor(),
                        16,
                        FontWeight.w600,
                      ),
                    ),
                    spaceH8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 16.h,
                          width: 16.w,
                          child: Image.asset(ImageAssets.img_star),
                        ),
                        spaceW4,
                        Text(
                          '$reputation',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    spaceH24,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Loan',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteWithOpacitySevenZero(),
                            14,
                            FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: FadeInImage.assetNetwork(
                                  placeholder: ImageAssets.image_loading,
                                  image: iconTokenUrl,
                                  imageCacheHeight: 20,
                                  placeholderCacheHeight: 15,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            spaceW8,
                            Text(
                              formatValue.format(loan),
                              style: textNormalCustom(
                                AppTheme.getInstance().whiteColor(),
                                14,
                                FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    spaceH13,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Interest rate',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteWithOpacitySevenZero(),
                            14,
                            FontWeight.w400,
                          ),
                        ),
                        Text(
                          '$interestRate APR',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            14,
                            FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    spaceH13,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Signed contracts',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteWithOpacitySevenZero(),
                            14,
                            FontWeight.w400,
                          ),
                        ),
                        Text(
                          '$signedContracts contracts',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            14,
                            FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  height: 94.h,
                  width: 94.w,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: AppTheme.getInstance().bgColorHomePawn(),
                    ),
                  ),
                  child: SizedBox(
                    height: 84.h,
                    width: 84.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: FadeInImage.assetNetwork(
                        placeholder: ImageAssets.image_loading,
                        image: imgShop,
                        imageCacheHeight: 84,
                        placeholderCacheHeight: 70,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        spaceW20,
      ],
    );
  }

  Widget _itemBorrowFtLend({
    required String title,
    required String suffixTitle,
    required TYPE_BORROW_OR_LEND type,
    required String imageBg,
  }) {
    return Container(
      height: 161.h,
      width: 235.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageBg),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12.h,
            left: 12.w,
            child: Text(
              title,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            bottom: 15.h,
            left: 12.w,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ConnectWalletDialog(
                    navigationTo: BorrowLendScreen(
                      type: type,
                    ),
                    isRequireLoginEmail: false,
                  ),
                ).then((_) => null);
              },
              child: Row(
                children: [
                  Text(
                    suffixTitle,
                    style: textNormalCustom(
                      AppTheme.getInstance().blueColor(),
                      12,
                      FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                    width: 12,
                    child: Image.asset(ImageAssets.blueArrow),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
    // return ClipRRect(
    //   borderRadius: BorderRadius.all(
    //     Radius.circular(20.r),
    //   ),
    //   child: SizedBox(
    //     height: 161.h,
    //     width: 235.w,
    //     child: Stack(
    //       children: [
    //         SizedBox(
    //           height: 161.h,
    //           width: 235.w,
    //           child: Image.asset(imageBg),
    //         ),
    //         Positioned(
    //           top: 12.h,
    //           left: 12.w,
    //           child: Text(
    //             title,
    //             style: textNormalCustom(
    //               AppTheme.getInstance().whiteColor(),
    //               16,
    //               FontWeight.w700,
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           bottom: 15.h,
    //           left: 12.w,
    //           child: InkWell(
    //             onTap: () {
    //               showDialog(
    //                 context: context,
    //                 builder: (context) => ConnectWalletDialog(
    //                   navigationTo: BorrowLendScreen(
    //                     type: type,
    //                   ),
    //                   isRequireLoginEmail: false,
    //                 ),
    //               ).then((_) => null);
    //             },
    //             child: Row(
    //               children: [
    //                 Text(
    //                   suffixTitle,
    //                   style: textNormalCustom(
    //                     AppTheme.getInstance().blueColor(),
    //                     12,
    //                     FontWeight.w400,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 12,
    //                   width: 12,
    //                   child: Image.asset(ImageAssets.blueArrow),
    //                 )
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  ClipRRect _itemTopRate({required String title, required String img}) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(16.r),
      ),
      child: Stack(
        children: [
          SizedBox(
            height: 165.h,
            width: 133.w,
            child: FadeInImage.assetNetwork(
              placeholder: ImageAssets.image_loading,
              image: img,
              imageCacheHeight: 165,
              placeholderCacheHeight: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8.h,
            left: 8.w,
            child: Text(
              title,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                14,
                FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  SizedBox _buildBanner() {
    return SizedBox(
      height: 85.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 375.w,
            child: Image.asset(
              ImageAssets.banner_pawn,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 8.h,
            child: RichText(
              text: TextSpan(
                text: S.current.review_partner_in_your_contract,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  12,
                  FontWeight.w700,
                ),
                children: [
                  TextSpan(
                    text: ' 10 DFY ',
                    style: textNormalCustom(
                      AppTheme.getInstance().fillColor(),
                      12,
                      FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: S.current.as_a_reward,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 51.h,
            child: Container(
              height: 24.h,
              width: 84.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppTheme.getInstance().btnGold4(),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30.r),
                ),
              ),
              child: Center(
                child: GradientText(
                  S.current.review_now,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                  gradient: LinearGradient(
                    colors: AppTheme.getInstance().linearTxt(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildHeaderWidget() {
    return Container(
      margin: EdgeInsets.only(
        left: 24.w,
        right: 28.w,
        bottom: 14.h,
        top: 14.h,
      ),
      height: 54.h,
      width: 323.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 139.w,
            height: 38.h,
            child: Image.asset(
              ImageAssets.logo_pawn,
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const ConnectWalletDialog(
                  navigationTo: TotalNotification(),
                  isRequireLoginEmail: true,
                ),
              ).then((_) => null);
            },
            child: SizedBox(
              height: 24.h,
              width: 24.w,
              child: Image.asset(
                ImageAssets.alarm,
              ),
            ),
          )
        ],
      ),
    );
  }
}
