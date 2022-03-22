
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/other_profile/cubit/other_profile_cubit.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/widget/borrow_tab.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/widget/header_tab_profile.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/widget/lender_tab.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherProfile extends StatefulWidget {
  const OtherProfile({Key? key, required this.userId, required this.index})
      : super(key: key);

  final String userId;
  final int index;

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
    cubit.userId = widget.userId;
    cubit.setTitle(widget.index);
    cubit.getUserProfile(userId: widget.userId);
    cubit.getReputation(userId: widget.userId);
    _tabController =
        TabController(initialIndex: widget.index, length: 2, vsync: this);
    scrollController = ScrollController();
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
            await cubit.getUserProfile(userId: widget.userId);
            await cubit.getReputation(userId: widget.userId);
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
                        physics:
                            const ScrollPhysics(parent: PageScrollPhysics()),
                        body: DefaultTabController(
                          length: 2,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              BorrowTab(
                                cubit: cubit,
                                listReputation: cubit.reputation,
                              ),
                              LenderTab(
                                cubit: cubit,
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
                                  title('PAWNSHOP INFORMATION'),
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
                                        if (cubit.userProfile.kyc != null)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    'Description:',
                                    cubit.userProfile.pawnshop?.description ??
                                        '',
                                    moreValue: true,
                                  ),
                                  spaceH32,
                                  title('PERSONAL INFORMATION'),
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
                                    '${Get.find<AppConstants>().baseUrl}/login?tab=1&referral=${cubit.userProfile.referredId}',
                                    urlLink: true,
                                  ),
                                  spaceH16,
                                  rowItem(
                                    'Referral ID:',
                                    cubit.userProfile.referredId ?? '',
                                    hasCopy: true,
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
                                            itemBuilder: (BuildContext context,
                                                int index) {
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
                                                              .links?[index] ??
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
                return const SizedBox();
              },
              imageErrorBuilder: (ctx, obj, st) {
                return const SizedBox();
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
                      return const SizedBox();
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
