import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/condition_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TYPE_FORM_DROPDOWN {
  CONDITION,
  COUNTRY,
  CITY,
  PHONE,
  PRICE,
  NONE_DATA,
}

List<Map<String, dynamic>> firstPhone = [
  {'label': '+84'},
];

class FormDropDown extends StatelessWidget {
  const FormDropDown({
    Key? key,
    required this.typeDrop,
    required this.cubit,
  }) : super(key: key);
  final TYPE_FORM_DROPDOWN typeDrop;
  final ProvideHardNftCubit cubit;

  @override
  Widget build(BuildContext context) {
    if (typeDrop == TYPE_FORM_DROPDOWN.CONDITION) {
      return StreamBuilder<List<Map<String, dynamic>>>(
          stream: cubit.conditionBHVSJ,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.getInstance().whiteColor(),
                ),
              );
            } else if ((snapshot.data ?? []).isEmpty) {
              return InkWell(
                onTap: () {
                  cubit.getAllApiExceptCity();
                },
                child: SizedBox(
                  height: 54.h,
                  width: 54.w,
                  child: Image.asset(ImageAssets.reload_nft),
                ),
              );
            } else {
              return Stack(
                children: [
                  CoolDropdown(
                    // gap: 8.h,
                    dropdownItemMainAxis: MainAxisAlignment.start,
                    resultMainAxis: MainAxisAlignment.start,
                    dropdownList: cubit.conditions,
                    onChange: (value) {
                      cubit.dataStep1.conditionNft.id = value['value'];
                      cubit.dataStep1.conditionNft.name = value['label'];
                    },
                    dropdownItemHeight: 54.h,
                    dropdownHeight: 232.h,
                    dropdownWidth: 343.w,
                    resultAlign: Alignment.centerRight,
                    resultWidth: 343.w,
                    resultHeight: 64.h,
                    dropdownPadding: EdgeInsets.only(right: 11.w),
                    dropdownBD: BoxDecoration(
                      color: AppTheme.getInstance().selectDialogColor(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    resultBD: BoxDecoration(
                      color: AppTheme.getInstance().backgroundBTSColor(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    resultTS: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16,
                    ),
                    placeholder: S.current.select_condition,
                    resultIcon: const SizedBox.shrink(),
                    selectedItemTS: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16,
                    ),
                    unselectedItemTS: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16,
                    ),
                    placeholderTS: textNormal(
                      Colors.white.withOpacity(0.5),
                      16,
                    ),
                    isTriangle: false,
                    selectedItemBD: BoxDecoration(
                      color:
                          AppTheme.getInstance().whiteColor().withOpacity(0.1),
                    ),
                  ),
                  Positioned(
                    right: 19.w,
                    child: SizedBox(
                      height: 64.h,
                      child: sizedSvgImage(
                        w: 13,
                        h: 13,
                        image: ImageAssets.ic_expand_white_svg,
                      ),
                    ),
                  )
                ],
              );
            }
          });
    } else if (typeDrop == TYPE_FORM_DROPDOWN.COUNTRY) {
      return StreamBuilder<List<Map<String, dynamic>>>(
        stream: cubit.countriesBHVSJ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppTheme.getInstance().whiteColor(),
              ),
            );
          } else if ((snapshot.data ?? []).isEmpty) {
            return InkWell(
              onTap: () {
                cubit.getAllApiExceptCity();
              },
              child: SizedBox(
                height: 54.h,
                width: 54.w,
                child: Image.asset(ImageAssets.reload_nft),
              ),
            );
          } else {
            return Stack(
              children: [
                CoolDropdown(
                  // gap: 8.h,
                  dropdownItemMainAxis: MainAxisAlignment.start,
                  resultMainAxis: MainAxisAlignment.start,
                  dropdownList: snapshot.data ?? [],
                  onChange: (value) {
                    if (typeDrop == TYPE_FORM_DROPDOWN.COUNTRY) {
                      cubit.getCitiesApi(value['value']);
                      cubit.dataStep1.country.id = value['value'];
                      cubit.dataStep1.country.name = value['label'];
                    } else {}
                  },
                  dropdownItemHeight: 54.h,
                  dropdownHeight: cubit.countries.isEmpty ? 54.h : 232.h,
                  dropdownWidth: 343.w,
                  resultAlign: Alignment.centerRight,
                  resultWidth: 343.w,
                  resultHeight: 64.h,
                  dropdownPadding: EdgeInsets.only(right: 11.w),
                  dropdownBD: BoxDecoration(
                    color: AppTheme.getInstance().selectDialogColor(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  resultBD: BoxDecoration(
                    color: AppTheme.getInstance().backgroundBTSColor(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  resultTS: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  placeholder: S.current.select_country,
                  resultIcon: const SizedBox.shrink(),
                  selectedItemTS: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  unselectedItemTS: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  placeholderTS: textNormal(
                    Colors.white.withOpacity(0.5),
                    16,
                  ),
                  isTriangle: false,
                  selectedItemBD: BoxDecoration(
                    color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
                  ),
                ),
                Positioned(
                  right: 19.w,
                  child: SizedBox(
                    height: 64.h,
                    child: sizedSvgImage(
                      w: 13,
                      h: 13,
                      image: ImageAssets.ic_expand_white_svg,
                    ),
                  ),
                )
              ],
            );
          }
        },
      );
    } else if (typeDrop == TYPE_FORM_DROPDOWN.CITY) {
      return StreamBuilder<List<Map<String, dynamic>>>(
        stream: cubit.citiesBHVSJ,
        builder: (context, snapshot) {
          if (cubit.checkMapListContainsObj(
              mapList: snapshot.data ?? [], valueNeedCheck: 'loading')) {
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppTheme.getInstance().whiteColor(),
              ),
            );
          } else if (cubit.checkMapListContainsObj(
              mapList: snapshot.data ?? [], valueNeedCheck: 'error')) {
            return InkWell(
              onTap: () {
                cubit.getAllApiExceptCity();
              },
              child: SizedBox(
                height: 54.h,
                width: 54.w,
                child: Image.asset(ImageAssets.reload_nft),
              ),
            );
          } else if (cubit.checkMapListContainsObj(
              mapList: snapshot.data ?? [], valueNeedCheck: 'none')) {
            return Container(child: Text('Empty data'));
          } else {
            return Stack(
              children: [
                CoolDropdown(
                  // gap: 8.h,
                  dropdownItemMainAxis: MainAxisAlignment.start,
                  resultMainAxis: MainAxisAlignment.start,
                  dropdownList: snapshot.data ?? [],
                  onChange: (value) {
                    cubit.dataStep1.city.id = value['value'];
                    cubit.dataStep1.city.name = value['label'];
                    cubit.dataStep1.city.countryID = value['countryID'];
                    cubit.dataStep1.city.latitude = value['latitude'];
                    cubit.dataStep1.city.longitude = value['longitude'];
                  },
                  dropdownItemHeight: 54.h,
                  dropdownHeight: cubit.cities.isEmpty ? 60.h : 232.h,
                  dropdownWidth: 343.w,
                  resultAlign: Alignment.centerRight,
                  resultWidth: 343.w,
                  resultHeight: 64.h,
                  dropdownPadding: EdgeInsets.only(right: 11.w),
                  dropdownBD: BoxDecoration(
                    color: AppTheme.getInstance().selectDialogColor(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  resultBD: BoxDecoration(
                    color: AppTheme.getInstance().backgroundBTSColor(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  resultTS: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  placeholder: S.current.select_city,
                  resultIcon: const SizedBox.shrink(),
                  selectedItemTS: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  unselectedItemTS: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  placeholderTS: textNormal(
                    Colors.white.withOpacity(0.5),
                    16,
                  ),
                  isTriangle: false,
                  selectedItemBD: BoxDecoration(
                    color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
                  ),
                ),
                Positioned(
                  right: 19.w,
                  child: SizedBox(
                    height: 64.h,
                    child: sizedSvgImage(
                      w: 13,
                      h: 13,
                      image: ImageAssets.ic_expand_white_svg,
                    ),
                  ),
                )
              ],
            );
          }
        },
      );
    } else if (typeDrop == TYPE_FORM_DROPDOWN.PRICE) {
      return SizedBox(
        width: 90.w,
        child: Center(
          child: Stack(
            children: [
              Positioned(
                child: CoolDropdown(
                  dropdownItemGap: 8.h,
                  dropdownItemMainAxis: MainAxisAlignment.start,
                  resultMainAxis: MainAxisAlignment.start,
                  isTriangle: false,
                  dropdownList: cubit.tokensMap,
                  dropdownWidth: 113.w,
                  dropdownHeight: 228.h,
                  dropdownPadding: EdgeInsets.only(right: 11.w),
                  dropdownItemHeight: 54.h,
                  defaultValue: cubit.tokensMap[0],
                  resultIcon: const SizedBox.shrink(),
                  dropdownItemReverse: true,
                  dropdownBD: BoxDecoration(
                    color: AppTheme.getInstance().selectDialogColor(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  unselectedItemTS: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  resultTS: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  selectedItemBD: BoxDecoration(
                    color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
                  ),
                  selectedItemTS: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  resultBD: BoxDecoration(
                    color: AppTheme.getInstance().backgroundBTSColor(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onChange: (value) {
                    cubit.dataStep1.tokenInfo.name = value['label'];
                    cubit.dataStep1.tokenInfo.id = value['value'];
                  },
                ),
              ),
              Positioned(
                right: 6.w,
                child: SizedBox(
                  height: 60.h,
                  child: sizedSvgImage(
                    w: 13,
                    h: 13,
                    image: ImageAssets.ic_expand_white_svg,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else if (typeDrop == TYPE_FORM_DROPDOWN.PHONE) {
      return StreamBuilder<List<Map<String, dynamic>>>(
          stream: cubit.phonesCodeBHVSJ,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.getInstance().whiteColor(),
                ),
              );
            } else if ((snapshot.data ?? []).isEmpty) {
              return InkWell(
                onTap: () {
                  cubit.getAllApiExceptCity();
                },
                child: SizedBox(
                  height: 54.h,
                  width: 54.w,
                  child: Image.asset(ImageAssets.reload_nft),
                ),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().backgroundBTSColor(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    bottomLeft: Radius.circular(20.r),
                  ),
                ),
                width: 93.w,
                height: 64.h,
                child: Center(
                  child: Stack(
                    children: [
                      CoolDropdown(
                        dropdownItemGap: 8.h,
                        dropdownItemMainAxis: MainAxisAlignment.start,
                        resultMainAxis: MainAxisAlignment.spaceAround,
                        dropdownHeight: 324.h,
                        dropdownWidth: 109.w,
                        isTriangle: false,
                        dropdownPadding: EdgeInsets.only(right: 11.w),
                        dropdownList: cubit.phonesCode,
                        defaultValue: cubit.phonesCode.isNotEmpty
                            ? cubit.phonesCode[0]
                            : firstPhone[0],
                        resultIcon: const SizedBox.shrink(),
                        dropdownBD: BoxDecoration(
                          color: AppTheme.getInstance().selectDialogColor(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        unselectedItemTS: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                        resultTS: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                        selectedItemBD: BoxDecoration(
                          color: AppTheme.getInstance()
                              .whiteColor()
                              .withOpacity(0.1),
                        ),
                        selectedItemTS: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                        resultBD: BoxDecoration(
                          color: AppTheme.getInstance().backgroundBTSColor(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onChange: (value) {
                          cubit.dataStep1.phoneCodeModel.id = value['value'];
                          cubit.dataStep1.phoneCodeModel.code = value['label'];
                        },
                      ),
                      Positioned(
                        top: 0.h,
                        left: 60.w,
                        child: SizedBox(
                          height: 60.h,
                          child: sizedSvgImage(
                            w: 13,
                            h: 13,
                            image: ImageAssets.ic_expand_white_svg,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          });
    } else {
      return Container();
    }
  }

  Stack form_none_data() {
    return Stack(
      children: [
        CoolDropdown(
          // gap: 8.h,
          dropdownItemMainAxis: MainAxisAlignment.start,
          resultMainAxis: MainAxisAlignment.start,
          dropdownList: [],
          onChange: (value) {},
          dropdownItemHeight: 54.h,
          dropdownHeight: 54.h,
          dropdownWidth: 343.w,
          resultAlign: Alignment.centerRight,
          resultWidth: 343.w,
          resultHeight: 64.h,
          dropdownPadding: EdgeInsets.only(right: 11.w),
          dropdownBD: BoxDecoration(
            color: AppTheme.getInstance().selectDialogColor(),
            borderRadius: BorderRadius.circular(20),
          ),
          resultBD: BoxDecoration(
            color: AppTheme.getInstance().backgroundBTSColor(),
            borderRadius: BorderRadius.circular(20),
          ),
          resultTS: textNormal(
            AppTheme.getInstance().whiteColor(),
            16,
          ),
          placeholder: S.current.select_city,
          resultIcon: const SizedBox.shrink(),
          selectedItemTS: textNormal(
            AppTheme.getInstance().whiteColor(),
            16,
          ),
          unselectedItemTS: textNormal(
            AppTheme.getInstance().whiteColor(),
            16,
          ),
          placeholderTS: textNormal(
            Colors.white.withOpacity(0.5),
            16,
          ),
          isTriangle: false,
          selectedItemBD: BoxDecoration(
            color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
          ),
        ),
        Positioned(
          right: 19.w,
          child: SizedBox(
            height: 64.h,
            child: sizedSvgImage(
              w: 13,
              h: 13,
              image: ImageAssets.ic_expand_white_svg,
            ),
          ),
        )
      ],
    );
  }
}
