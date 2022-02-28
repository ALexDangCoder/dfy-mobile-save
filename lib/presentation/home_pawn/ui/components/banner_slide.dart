import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/home_pawn/bloc/home_pawn_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerPawnSlide extends StatefulWidget {
  const BannerPawnSlide({Key? key}) : super(key: key);

  @override
  _BannerPawnSlideState createState() => _BannerPawnSlideState();
}

class _BannerPawnSlideState extends State<BannerPawnSlide> {
  int currentIndex = 0;
  late PageController _pageController;
  late HomePawnCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = HomePawnCubit();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 181.h,
          width: 375.w,
          child: Image.asset(
            ImageAssets.bgPawnShopToken,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          // left: 29.w,
          child: Container(
            margin: EdgeInsets.only(left: 28.w),
            height: 135.h,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: cubit.pawnsBannerSlide.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (_, index) {
                      return Row(
                        children: [
                          _buildAvatarPawn(
                            imgAvatar: cubit.pawnsBannerSlide[index].avatar,
                          ),
                          spaceW30,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: S.current.name_of_token,
                                    style: textNormalCustom(
                                      AppTheme.getInstance().whiteColor(),
                                      14,
                                      FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: cubit.pawnsBannerSlide[index]
                                            .nameOfToken,
                                        style: textNormalCustom(
                                          AppTheme.getInstance().whiteColor(),
                                          14,
                                          FontWeight.w600,
                                        ),
                                      )
                                    ]),
                              ),
                              spaceH15,
                              Row(
                                children: [
                                  Text(
                                    S.current.symbol_of_token,
                                    style: textNormalCustom(
                                      AppTheme.getInstance().whiteColor(),
                                      14,
                                      FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                        cubit
                                            .pawnsBannerSlide[index].iconSymbol,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              spaceH22,
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20.w,
                                ),
                                child: ButtonGold(
                                  title: S.current.explore_now,
                                  isEnable: true,
                                  height: 32.h,
                                  fixSize: false,
                                  radiusButton: 10,
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    cubit.pawnsBannerSlide.length,
                    (index) => buildDot(index, context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 6.h,
      width: currentIndex == index ? 32.25.w : 6.w,
      margin: index != 3
          ? EdgeInsets.only(
              right: 8.w,
            )
          : null,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().colorTextReset(),
        gradient: RadialGradient(
          radius: 4.r,
          center: const Alignment(0.5, -0.5),
          colors: currentIndex == index
              ? AppTheme.getInstance().gradientButtonColor()
              : [
                  AppTheme.getInstance().colorTextReset(),
                  AppTheme.getInstance().colorTextReset(),
                ],
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }

  Stack _buildAvatarPawn({required String imgAvatar}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 130.h,
          width: 92.08.w,
          child: Image.asset(ImageAssets.bgAvatarPawn),
        ),
        Positioned(
          top: 15.h,
          child: SizedBox(
            height: 60.h,
            width: 60.w,
            child: CircleAvatar(
              backgroundImage: AssetImage(imgAvatar),
            ),
          ),
        ),
      ],
    );
  }
}
