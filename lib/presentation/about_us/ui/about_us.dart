import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    child: Container(
                      child: Center(
                        child: Text(
                          S.current.about_us,
                          style: textNormal(
                                  AppTheme.getInstance().textThemeColor(), 20)
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
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
                          child: Image.asset(ImageAssets.ic_back),
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
                                SizedBox  (
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
