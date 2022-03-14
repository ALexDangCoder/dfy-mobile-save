import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/home_pawn/bloc/home_pawn_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerPawnSlide extends StatefulWidget {
  const BannerPawnSlide({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final HomePawnCubit cubit;

  @override
  _BannerPawnSlideState createState() => _BannerPawnSlideState();
}

class _BannerPawnSlideState extends State<BannerPawnSlide> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount:
                        widget.cubit.listOfficialPawnShopWithToken.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (_, index) {
                      return Row(
                        children: [
                          _buildAvatarPawn(
                            imgAvatar: widget
                                    .cubit
                                    .listOfficialPawnShopWithToken[index]
                                    .imageCryptoAsset ??
                                '',
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
                                      text: widget
                                              .cubit
                                              .listOfficialPawnShopWithToken[
                                                  index]
                                              .cryptoAsset
                                              ?.symbol ??
                                          '',
                                      style: textNormalCustom(
                                        AppTheme.getInstance().whiteColor(),
                                        14,
                                        FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
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
                                      backgroundImage: NetworkImage(
                                        widget
                                                .cubit
                                                .listOfficialPawnShopWithToken[
                                                    index]
                                                .imageCryptoAsset ??
                                            '',
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
                    widget.cubit.listOfficialPawnShopWithToken.length,
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
      margin: index != 2
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: FadeInImage.assetNetwork(
                placeholder: ImageAssets.image_loading,
                image: imgAvatar,
                imageCacheHeight: 60,
                placeholderCacheHeight: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
