import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/common_ext.dart';
import 'package:flutter/material.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/rendering.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: listBackgroundColor.first,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: listBackgroundColor,
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        S.current.about_us,
                        style: textNormal(
                                AppTheme.getInstance().textThemeColor(), 20)
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 27,
                      top: 20,
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            height: 30,
                            width: 30,
                            child: Image.asset(ImageAssets.ic_back),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                color: AppTheme.getInstance().divideColor(),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 16,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 52,
                              width: 52,
                              child: Image.asset(ImageAssets.imgTokenDFY),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Text(
                                    appName,
                                    style: textNormalCustom(
                                      AppTheme.getInstance().textThemeColor(),
                                      31,
                                      FontWeight.w700,
                                    ).copyWith(height: 1.0),
                                  ),
                                ),
                                SizedBox(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      appURL,
                                      style: textNormalOswaldCustom(
                                        AppTheme.getInstance().logoColor(),
                                        18,
                                        FontWeight.w300,
                                      ).copyWith(height: 1.0),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            text: appName,
                            style: textNormalCustom(
                              AppTheme.getInstance().getAmountColor(),
                              16,
                              FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: S.current.about_us_content,
                                style: textNormalCustom(
                                  AppTheme.getInstance().textThemeColor(),
                                  16,
                                  FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Image.asset(ImageAssets.ic_global),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchURL(defiLink);
                              },
                              child: SizedBox(
                                child: Text(
                                  appURL,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().textThemeColor(),
                                    16,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Image.asset(ImageAssets.ic_email),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchMail(email: mailAsk);
                              },
                              child: SizedBox(
                                child: Text(
                                  mailAsk,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().textThemeColor(),
                                    16,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Image.asset(ImageAssets.ic_email),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchMail(email: mailSupport);
                              },
                              child: SizedBox(
                                child: Text(
                                  mailSupport,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().textThemeColor(),
                                    16,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          child: Text(
                            '$appName - ${S.current.hanoi_office}',
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              20,
                              FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Image.asset(ImageAssets.ic_email),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchMail(email: mailAskHanoi);
                              },
                              child: SizedBox(
                                child: Text(
                                  mailAskHanoi,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().getAmountColor(),
                                    16,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Image.asset(ImageAssets.ic_flag_vn),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Image.asset(ImageAssets.ic_email),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchMail(email: mailMarketingHanoi);
                              },
                              child: SizedBox(
                                child: Text(
                                  mailMarketingHanoi,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().getAmountColor(),
                                    16,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Image.asset(ImageAssets.ic_flag_gb),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Image.asset(ImageAssets.ic_address),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  locationHanoi,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().textThemeColor(),
                                    16,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          child: Text(
                            '$appName - ${S.current.london_office}',
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              20,
                              FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Wrap(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(ImageAssets.ic_email),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    launchMail(email: mailOfficeLondon);
                                  },
                                  child: SizedBox(
                                    child: Text(
                                      mailOfficeLondon,
                                      style: textNormalCustom(
                                        AppTheme.getInstance().getAmountColor(),
                                        16,
                                        FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Image.asset(ImageAssets.ic_flag_gb),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 5,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        AppTheme.getInstance().getAmountColor(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              child: Text(
                                seanMason,
                                style: textNormalCustom(
                                  AppTheme.getInstance().getAmountColor(),
                                  16,
                                  FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                cfo,
                                style: textNormalCustom(
                                  AppTheme.getInstance().getAmountColor(),
                                  16,
                                  FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Image.asset(ImageAssets.ic_address),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  locationLondon,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().textThemeColor(),
                                    16,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          child: Text(
                            '${S.current.registration_number}: $registrationNumber',
                            style: textNormalCustom(
                              AppTheme.getInstance().getGrayColor(),
                              14,
                              FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          child: Text(
                            S.current.find_us_on,
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              20,
                              FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 18,
                          children: [
                            IconButton(
                              onPressed: () {
                                launchURL(gitLink);
                              },
                              icon: Image.asset(ImageAssets.ic_git),
                            ),
                            IconButton(
                              onPressed: () {
                                launchURL(telegramLink);
                              },
                              icon: Image.asset(ImageAssets.ic_telegram_png),
                            ),
                            IconButton(
                              onPressed: () {
                                launchURL(facebookLink);
                              },
                              icon: Image.asset(ImageAssets.icon_fb),
                            ),
                            IconButton(
                              onPressed: () {
                                launchURL(youtubeLink);
                              },
                              icon: Image.asset(ImageAssets.icon_youtube),
                            ),
                            IconButton(
                              onPressed: () {
                                launchURL(linkedinLink);
                              },
                              icon: Image.asset(ImageAssets.icon_linkedin),
                            ),
                            IconButton(
                              onPressed: () {
                                launchURL(twitterLink);
                              },
                              icon: Image.asset(ImageAssets.icon_twitter),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
