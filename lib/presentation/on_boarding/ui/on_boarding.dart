import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/on_boarding_content_model/content_model.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
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
    return BaseDesignScreen(
      title: S.current.how_to_create_hard_nft,
      isImage: false,
      isLockTextInSetting: true,
      bottomBar: Container(
        padding: EdgeInsets.only(bottom: 38.h),
        color: AppTheme.getInstance().bgBtsColor(),
        child: GestureDetector(
          onTap: () {
            if (currentIndex == contents.length - 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (cxt) => const ProvideHardNftInfo(),
                ),
              );
            }
            _pageController.nextPage(
              duration: const Duration(microseconds: 100),
              curve: Curves.bounceIn,
            );
          },
          child: ButtonGold(
            title: currentIndex == contents.length - 1
                ? S.current.get_started
                : S.current.next,
            isEnable: true,
          ),
        ),
      ),
      widget: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (cxt) => const ProvideHardNftInfo(),
            ),
          );
        },
        child: Text(
          S.current.skip,
          style: textNormalCustom(
            AppTheme.getInstance().fillColor(),
            16,
            FontWeight.w700,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(contents[index].image),
                    Text(
                      contents[index].title,
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        24,
                        FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    if (index == 0)
                      RichText(
                        text: TextSpan(
                          text: contents[index].descriptionNormal,
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: ' ${contents[index].descriptionYellow}',
                              style: textNormalCustom(
                                AppTheme.getInstance().fillColor(),
                                16,
                                FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      )
                    else if (index == 3)
                      RichText(
                        text: TextSpan(
                          text: contents[index].descriptionNormal,
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: ' ${contents[index].descriptionYellow} ',
                              style: textNormalCustom(
                                AppTheme.getInstance().fillColor(),
                                16,
                                FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: contents[index].partDescription,
                            )
                          ],
                        ),
                      )
                    else
                      RichText(
                        text: TextSpan(
                          text: '${contents[index].descriptionNormal} ',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: contents[index].descriptionYellow,
                              style: textNormalCustom(
                                AppTheme.getInstance().fillColor(),
                                16,
                                FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => buildDot(index, context),
            ),
          ),
          SizedBox(
            height: 60.h,
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 12.h,
      width: currentIndex == index ? 43.w : 12.w,
      margin: EdgeInsets.only(
        right: 16.w,
      ),
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
}
