import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/pawn/edit_peronal_info/ui/edit_personal_infor.dart';
import 'package:Dfy/presentation/pawn/edit_profile/ui/edit_profile.dart';
import 'package:Dfy/presentation/pawn/other_profile/cubit/other_profile_cubit.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/widget/borrow_tab.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/widget/header_tab_profile.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/widget/lender_tab.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/coming_soon.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherProfile extends StatefulWidget {
  const OtherProfile({
    Key? key,
    required this.userId,
    required this.index,
    required this.pageRouter,
  }) : super(key: key);

  final String userId;
  final int index;
  final PageRouter pageRouter;

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile>
    with SingleTickerProviderStateMixin {
  late OtherProfileCubit cubit;
  late TabController _tabController;
  late ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = OtherProfileCubit();
    cubit.setTitle(widget.index);
    if (widget.pageRouter == PageRouter.MARKET) {
      cubit.userId = widget.userId;
      cubit.getUserProfile(userId: widget.userId);
      cubit.getReputation(userId: widget.userId);
    } else {
      cubit.getMyUserProfile();
    }
    _tabController =
        TabController(initialIndex: widget.index, length: 2, vsync: this);
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: cubit,
      listener: (context, state) {
        if (state is OtherProfileSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            cubit.userProfile = state.userProfile ?? UserProfile();
            cubit.showContent();
          } else {
            cubit.message = state.message ?? '';
            cubit.showError();
          }
        }
      },
      builder: (context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException(S.current.error, cubit.message),
          retry: () async {
            if (widget.pageRouter == PageRouter.MARKET) {
              cubit.userId = widget.userId;
              await cubit.getUserProfile(userId: widget.userId);
              await cubit.getReputation(userId: widget.userId);
            } else {
              await cubit.getMyUserProfile();
            }
          },
          textEmpty: 'Pawnshop not found',
          child: StreamBuilder<String>(
            stream: cubit.titleStream,
            builder: (context, AsyncSnapshot<String> snapshot) {
              return BaseDesignScreen(
                title: snapshot.data ?? 'View profile',
                child: state is OtherProfileSuccess
                    ? NestedScrollView(
                        controller: scrollController,
                        physics: const ScrollPhysics(),
                        body: DefaultTabController(
                          length: 2,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              BorrowTab(
                                cubit: cubit,
                                listReputation: cubit.reputation,
                                pageRouter: widget.pageRouter,
                              ),
                              LenderTab(
                                cubit: cubit,
                                pageRouter: widget.pageRouter,
                                listReputation: cubit.reputation,
                              ),
                            ],
                          ),
                        ),
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return [
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 12.w,
                                      top: 24.h,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        title('PAWNSHOP INFORMATION'),
                                        if (widget.pageRouter ==
                                                PageRouter.MY_ACC &&
                                            cubit.userProfile.pawnshop != null)
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfile(
                                                    userProfile:
                                                        cubit.userProfile,
                                                  ),
                                                ),
                                              )
                                                  .then((value) async {
                                                if (value != null) {
                                                  await cubit
                                                      .getMyUserProfile();
                                                }
                                              });
                                            },
                                            child: Image.asset(
                                              ImageAssets.ic_edit_profile,
                                              height: 28.h,
                                              width: 28.w,
                                            ),
                                          )
                                        else
                                          const SizedBox(),
                                      ],
                                    ),
                                  ),
                                  if (cubit.userProfile.pawnshop == null &&
                                      widget.pageRouter ==
                                          PageRouter.MY_ACC) ...[
                                    sizedSvgImage(
                                      w: 138,
                                      h: 214,
                                      image: ImageAssets.img_become_pawnshop,
                                    ),
                                    Center(
                                      child: Text(
                                        'You are not a pawnshop',
                                        style: textNormalCustom(
                                          Colors.white,
                                          16,
                                          FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    spaceH24,
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          launch(
                                            '${Get.find<AppConstants>().basePawnUrl}/pawn/shop',
                                          );
                                        },
                                        child: ButtonRadial(
                                          height: 40.h,
                                          width: 174.w,
                                          radius: 12,
                                          child: Center(
                                            child: Text(
                                              S.current.only_become_pawnshop,
                                              style: textNormalCustom(
                                                Colors.white,
                                                16,
                                                FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    spaceH20,
                                    boxCover(),
                                    spaceH12,
                                    Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            cubit.userProfile.pawnshop?.name ??
                                                '',
                                            style: textNormalCustom(
                                              Colors.white,
                                              20,
                                              FontWeight.w600,
                                            ),
                                          ),
                                          spaceH8,
                                          Text(
                                            'Joined in ${cubit.date()}',
                                            style: textNormalCustom(
                                              textPawnGray,
                                              16,
                                              FontWeight.w400,
                                            ),
                                          ),
                                          spaceH4,
                                          if (cubit.userProfile.kyc?.status ==
                                              2)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                sizedSvgImage(
                                                  w: 14,
                                                  h: 14,
                                                  image:
                                                      ImageAssets.ic_verify_svg,
                                                ),
                                                spaceW5,
                                                Text(
                                                  'Identity verified',
                                                  style: textNormalCustom(
                                                    textPawnGray,
                                                    16,
                                                    FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                    spaceH32,
                                    rowItem(
                                      'Name:',
                                      cubit.userProfile.pawnshop?.name ?? '',
                                      moreValue: true,
                                    ),
                                    spaceH16,
                                    rowItem(
                                      'Email:',
                                      cubit.userProfile.pawnshop?.email ?? '',
                                      moreValue: true,
                                    ),
                                    spaceH16,
                                    rowItem(
                                      'Phone number:',
                                      cubit.userProfile.pawnshop?.phoneNumber ??
                                          '',
                                    ),
                                    spaceH16,
                                    rowItem(
                                      'Address:',
                                      cubit.userProfile.pawnshop?.address ?? '',
                                      moreValue: true,
                                    ),
                                    spaceH16,
                                    rowItem(
                                      'Description:',
                                      cubit.userProfile.pawnshop?.description ??
                                          '',
                                      moreValue: true,
                                    ),
                                  ],
                                  spaceH32,
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 12.w,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        title('PERSONAL INFORMATION'),
                                        if (widget.pageRouter ==
                                                PageRouter.MY_ACC &&
                                            cubit.userProfile.id != null)
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditPersonalInfo(
                                                    userProfile:
                                                        cubit.userProfile,
                                                  ),
                                                ),
                                              )
                                                  .then((value) async {
                                                if (value != null) {
                                                  await cubit
                                                      .getMyUserProfile();
                                                }
                                              });
                                            },
                                            child: Image.asset(
                                              ImageAssets.ic_edit_profile,
                                              height: 28.h,
                                              width: 28.w,
                                            ),
                                          )
                                        else
                                          const SizedBox(),
                                      ],
                                    ),
                                  ),
                                  if (cubit.userProfile.id == null &&
                                      widget.pageRouter ==
                                          PageRouter.MY_ACC) ...[
                                    spaceH32,
                                    Image.asset(
                                      ImageAssets.img_login_user,
                                      height: 142.h,
                                    ),
                                    spaceH24,
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const ConnectWalletDialog(
                                              navigationTo: OtherProfile(
                                                userId: '',
                                                pageRouter: PageRouter.MY_ACC,
                                                index: 0,
                                              ),
                                              isRequireLoginEmail: true,
                                            ),
                                          );
                                        },
                                        child: ButtonRadial(
                                          height: 40.h,
                                          width: 174.w,
                                          radius: 12,
                                          child: Center(
                                            child: Text(
                                              S.current.login,
                                              style: textNormalCustom(
                                                Colors.white,
                                                16,
                                                FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    spaceH16,
                                    rowItem(
                                      'Name:',
                                      cubit.userProfile.name ?? '',
                                      moreValue: true,
                                    ),
                                    spaceH16,
                                    rowItem(
                                      'Email:',
                                      cubit.userProfile.email ?? '',
                                      moreValue: true,
                                    ),
                                    spaceH16,
                                    rowItem(
                                      'Referral link:',
                                      '${Get.find<AppConstants>().pawn_custom_url}login?tab=1&referral=${cubit.userProfile.referredId}',
                                      urlLink: true,
                                    ),
                                    spaceH16,
                                    rowItem(
                                      'Referral ID:',
                                      cubit.userProfile.referredId ?? '',
                                      hasCopy:
                                          cubit.userProfile.referredId != null,
                                    ),
                                    spaceH16,
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 16.w,
                                        right: 16.w,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Personal link:',
                                            style: textNormalCustom(
                                              grey3,
                                              16,
                                              FontWeight.w400,
                                            ),
                                          ),
                                          spaceW8,
                                          Expanded(
                                            flex: 2,
                                            child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: cubit.userProfile.links
                                                      ?.length ??
                                                  0,
                                              itemBuilder: (
                                                BuildContext context,
                                                int index,
                                              ) {
                                                return Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        launch(
                                                          cubit.userProfile
                                                                      .links?[
                                                                  index] ??
                                                              '',
                                                        );
                                                      },
                                                      child: Text(
                                                        cubit.userProfile
                                                                    .links?[
                                                                index] ??
                                                            '',
                                                        style: textNormalCustom(
                                                          Colors.white,
                                                          16,
                                                          FontWeight.w400,
                                                        ).copyWith(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                            SliverPersistentHeader(
                              delegate: SliverHeader(
                                TabBar(
                                  unselectedLabelColor: purple,
                                  labelColor: Colors.white,
                                  onTap: (int i) {
                                    cubit.setTitle(i);
                                  },
                                  indicatorColor: formColor,
                                  labelStyle: textNormalCustom(
                                    Colors.white,
                                    14,
                                    FontWeight.w600,
                                  ),
                                  tabs: const [
                                    Tab(
                                      text: 'Borrower profile',
                                    ),
                                    Tab(
                                      text: 'Lender profile',
                                    )
                                  ],
                                  controller: _tabController,
                                  indicatorSize: TabBarIndicatorSize.label,
                                ),
                              ),
                              pinned: true,
                            ),
                          ];
                        },
                      )
                    : const SizedBox(),
              );
            },
          ),
        );
      },
    );
  }

  Widget title(String text) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      child: Text(
        text,
        style: textNormalCustom(purple, 14, FontWeight.w400),
      ),
    );
  }

  Widget boxCover() {
    return SizedBox(
      height: 179.h,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: 145.h,
            width: double.infinity,
            child: FadeInImage.assetNetwork(
              placeholder: '',
              image: cubit.userProfile.pawnshop?.cover ?? '',
              placeholderErrorBuilder: (ctx, obj, st) {
                return Container(
                  height: 145.h,
                  width: double.infinity,
                  color: borderItemColors,
                );
              },
              imageErrorBuilder: (ctx, obj, st) {
                return Container(
                  height: 145.h,
                  width: double.infinity,
                  color: borderItemColors,
                );
              },
              placeholderCacheHeight: 400,
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 68.h,
                  width: 68.w,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: '',
                    image: cubit.userProfile.pawnshop?.avatar ?? '',
                    placeholderErrorBuilder: (ctx, obj, st) {
                      return const SizedBox();
                    },
                    imageErrorBuilder: (ctx, obj, st) {
                      return Container(
                        height: 145.h,
                        width: double.infinity,
                        color: borderItemColors,
                      );
                    },
                    placeholderCacheHeight: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowItem(
    String title,
    String value, {
    Color? color,
    bool? urlLink,
    bool? moreValue,
    bool? hasCopy,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textNormalCustom(
              grey3,
              16,
              FontWeight.w400,
            ),
          ),
          spaceW8,
          if (urlLink == true || moreValue == true)
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  if (urlLink == true) {
                    launch(
                      value,
                    );
                  }
                },
                child: Text(
                  value,
                  style: textNormalCustom(
                    color ?? Colors.white,
                    16,
                    FontWeight.w400,
                  ).copyWith(
                    decoration: urlLink == true
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),
              ),
            )
          else
            Text(
              value,
              style: textNormalCustom(
                color ?? Colors.white,
                16,
                FontWeight.w400,
              ),
            ),
          if (hasCopy == true) ...[
            spaceW18,
            InkWell(
              onTap: () {
                FlutterClipboard.copy(value);
                Fluttertoast.showToast(
                  msg: S.current.copy,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                );
              },
              child: Image.asset(
                ImageAssets.ic_copy,
                height: 24.h,
                width: 24.w,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
