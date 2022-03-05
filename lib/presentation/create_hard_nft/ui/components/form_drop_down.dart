import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/form_search_create_hard_nft.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
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
    this.defaultValue,
    this.currentInfo,
  }) : super(key: key);
  final TYPE_FORM_DROPDOWN typeDrop;
  final ProvideHardNftCubit cubit;
  final Map<String, dynamic>? defaultValue;
  final UserInfoCreateHardNft? currentInfo;

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
                      value as Map<String, dynamic>;
                      cubit.dataStep1.conditionNft.id =
                          int.tryParse(value['value']);
                      cubit.dataStep1.conditionNft.name = value['label'];
                      cubit.mapValidate['condition'] = true;
                      cubit.validateAll();
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
            return InkWell(
              onTap: () => {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => Dialog(
                    backgroundColor: Colors.transparent,
                    child: FormSearchCreateHardNft(
                      cubit: cubit,
                      hintSearch: S.current.select_country,
                      initData: cubit.countries,
                      streamController: cubit.countriesBHVSJ.stream,
                      typeDrop: TYPE_FORM_DROPDOWN.COUNTRY,
                    ),
                  ),
                )
              },
              child: StreamBuilder<String>(
                  initialData: currentInfo != null
                      ? currentInfo?.country?.name ?? ''
                      : S.current.select_country,
                  stream: cubit.resultCountryChoose.stream,
                  builder: (context, snapshot) {
                    return Container(
                      width: 343.w,
                      height: 64.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        color: AppTheme.getInstance().itemBtsColors(),
                      ),
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data ?? S.current.select_country,
                            style: textNormalCustom(
                              AppTheme.getInstance().whiteColor(),
                              16,
                              FontWeight.w400,
                            ),
                          ),
                          spaceW20,
                          SizedBox(
                            height: 60.h,
                            child: sizedSvgImage(
                              w: 13,
                              h: 13,
                              image: ImageAssets.ic_expand_white_svg,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
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
            cubit.mapValidate['city'] = true;
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(
                  left: 16.w,
                ),
                child: Text(
                  S.current.empty_data,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
            );
          } else {
            return Stack(
              children: [
                CoolDropdown(
                  defaultValue: defaultValue,
                  dropdownItemMainAxis: MainAxisAlignment.start,
                  resultMainAxis: MainAxisAlignment.start,
                  dropdownList: snapshot.data ?? [],
                  onChange: (value) {
                    cubit.dataStep1.city.id = value['value'];
                    cubit.dataStep1.city.name = value['label'];
                    cubit.dataStep1.city.countryID = value['countryID'];
                    cubit.dataStep1.city.latitude = value['latitude'];
                    cubit.dataStep1.city.longitude = value['longitude'];
                    cubit.mapValidate['city'] = true;
                    cubit.validateAll();
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
        width: 120.w,
        child: Center(
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Positioned(
                child: CoolDropdown(
                  dropdownItemGap: 8.h,
                  dropdownItemMainAxis: MainAxisAlignment.start,
                  resultMainAxis: MainAxisAlignment.start,
                  isTriangle: false,
                  dropdownList: cubit.tokensMap,
                  dropdownWidth: 113.w,
                  dropdownHeight: 200.h,
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
                    if (value['label'] == DFY) {
                      cubit.dataStep1.tokenInfo.symbol = DFY;
                      cubit.dataStep1.tokenInfo.id = 1;
                    } else if (value['label'] == USDT) {
                      cubit.dataStep1.tokenInfo.symbol = USDT;
                      cubit.dataStep1.tokenInfo.id = 5;
                    } else {
                      cubit.dataStep1.tokenInfo.symbol = BNB;
                      cubit.dataStep1.tokenInfo.id = 38;
                    }
                  },
                ),
              ),
              Positioned(
                right: 19.15.w,
                // top: -7.h,
                child: SizedBox(
                  height: 70.h,
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
              return InkWell(
                onTap: () => {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      child: FormSearchCreateHardNft(
                        cubit: cubit,
                        hintSearch: S.current.search,
                        initData: cubit.phonesCode,
                        streamController: cubit.phonesCodeBHVSJ.stream,
                        typeDrop: TYPE_FORM_DROPDOWN.PHONE,
                      ),
                    ),
                  )
                },
                child: StreamBuilder<String>(
                    initialData: currentInfo != null
                        ? currentInfo?.phoneCode?.code ?? ''
                        : S.current.phone,
                    stream: cubit.resultPhoneChoose.stream,
                    builder: (context, snapshot) {
                      return Container(
                        margin: EdgeInsets.only(right: 16.w),
                        padding: EdgeInsets.only(
                          left: 16.w,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              snapshot.data ?? S.current.phone,
                              style: textNormalCustom(
                                AppTheme.getInstance().whiteColor(),
                                16,
                                FontWeight.w400,
                              ),
                            ),
                            spaceW20,
                            SizedBox(
                              height: 60.h,
                              child: sizedSvgImage(
                                w: 13,
                                h: 13,
                                image: ImageAssets.ic_expand_white_svg,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
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
