import 'dart:io';
import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/presentation/pawn/edit_peronal_info/cubit/edit_personal_info_cubit.dart';
import 'package:Dfy/presentation/pawn/verification/cubit/verification_cubit.dart';
import 'package:Dfy/presentation/pawn/verification/ui/step_two_verify.dart';
import 'package:Dfy/presentation/put_on_market/ui/component/custom_calandar.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepOneVerify extends StatefulWidget {
  const StepOneVerify({Key? key, this.kyc, this.id}) : super(key: key);

  final KYC? kyc;
  final int? id;

  @override
  _StepOneVerifyState createState() => _StepOneVerifyState();
}

class _StepOneVerifyState extends State<StepOneVerify> {
  late TextEditingController textSearchController;
  late TextEditingController textSearchCityController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController middleNameController;
  late TextEditingController addressController;
  late VerificationCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = VerificationCubit();
    textSearchController = TextEditingController();
    textSearchCityController = TextEditingController();
    addressController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    middleNameController = TextEditingController();
    cubit.userProfile.id = widget.id;
    cubit.getCountriesApi();
    if (widget.kyc != null) {
      cubit.userProfile.kyc = widget.kyc;
      cubit.getCites(widget.kyc?.country?.id ?? '0');
      firstNameController.text = widget.kyc?.firstName ?? '';
      lastNameController.text = widget.kyc?.lastName ?? '';
      middleNameController.text = widget.kyc?.middleName ?? '';
      cubit.country.add(widget.kyc?.country ?? CountryModel());
      cubit.city.add(widget.kyc?.city ?? CityModel());
      cubit.selectBirth.add(
        widget.kyc?.dateOfBirth ?? DateTime.now().millisecondsSinceEpoch,
      );
      cubit.country.add(widget.kyc?.country ?? CountryModel());
      cubit.city.add(widget.kyc?.city ?? CityModel());
      textSearchController.text = widget.kyc?.country?.name ?? '';
      addressController.text = widget.kyc?.address ?? '';
      textSearchController.text = widget.kyc?.country?.name ?? '';
      cubit.selectBirth.add(
        DateTime.now().millisecondsSinceEpoch,
      );
    }
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: 'Basic information',
      text: ImageAssets.ic_close,
      isImage: true,
      bottomBar: Container(
        height: 91.h,
        color: AppTheme.getInstance().bgBtsColor(),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 16.h,
            bottom: 16.h,
          ),
          child: InkWell(
            onTap: () {
              if (cubit.checkRequire(
                firsName: firstNameController.text,
                lastName: lastNameController.text,
                middleName: middleNameController.text,
                dateOfBirth: cubit.selectBirth.value,
                country: cubit.country.value,
                cities: cubit.city.value,
                address: addressController.text,
              )) {
                goTo(
                  context,
                  StepTwoVerify(
                    cubit: cubit,
                  ),
                );
              }
            },
            child: ButtonRadial(
              height: 64.h,
              width: double.infinity,
              child: Center(
                child: Text(
                  S.current.continue_s,
                  style: textNormalCustom(
                    Colors.white,
                    20,
                    FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onRightClick: () {
        Navigator.of(context).popUntil(
          (route) => route.settings.name == AppRouter.verify,
        );
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(child: step()),
            spaceH36,
            Row(
              children: [
                Text(
                  'First name',
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                ),
                Text(
                  '*',
                  style: textNormal(
                    AppTheme.getInstance().redColor(),
                    16,
                  ),
                ),
              ],
            ),
            spaceH4,
            Container(
              height: 64.h,
              padding: EdgeInsets.only(right: 15.w, left: 15.w),
              decoration: BoxDecoration(
                color: AppTheme.getInstance().backgroundBTSColor(),
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: firstNameController,
                      maxLength: 100,
                      onChanged: (value) {
                        if (value == '') {
                          cubit.errorFirstName.add('First name is required');
                        } else {
                          cubit.errorFirstName.add('');
                        }
                      },
                      cursorColor: AppTheme.getInstance().whiteColor(),
                      style: textNormal(
                        AppTheme.getInstance().whiteColor(),
                        16,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isCollapsed: true,
                        counterText: '',
                        hintText: S.current.enter_name,
                        hintStyle: textNormal(
                          Colors.white.withOpacity(0.5),
                          16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<String>(
              stream: cubit.errorFirstName,
              builder: (
                BuildContext context,
                AsyncSnapshot<String> snapshot,
              ) {
                if (snapshot.data != '') {
                  return SizedBox(
                    child: Text(
                      snapshot.data ?? '',
                      style: textNormal(
                        Colors.red,
                        12,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            spaceH16,
            Row(
              children: [
                Text(
                  'Last name',
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                ),
                Text(
                  '*',
                  style: textNormal(
                    AppTheme.getInstance().redColor(),
                    16,
                  ),
                ),
              ],
            ),
            spaceH4,
            Container(
              height: 64.h,
              padding: EdgeInsets.only(right: 15.w, left: 15.w),
              decoration: BoxDecoration(
                color: AppTheme.getInstance().backgroundBTSColor(),
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: lastNameController,
                      maxLength: 100,
                      onChanged: (value) {
                        if (value == '') {
                          cubit.errorLastName.add('Last name is required');
                        } else {
                          cubit.errorLastName.add('');
                        }
                      },
                      cursorColor: AppTheme.getInstance().whiteColor(),
                      style: textNormal(
                        AppTheme.getInstance().whiteColor(),
                        16,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isCollapsed: true,
                        counterText: '',
                        hintText: S.current.enter_name,
                        hintStyle: textNormal(
                          Colors.white.withOpacity(0.5),
                          16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<String>(
              stream: cubit.errorLastName,
              builder: (
                BuildContext context,
                AsyncSnapshot<String> snapshot,
              ) {
                if (snapshot.data != '') {
                  return SizedBox(
                    child: Text(
                      snapshot.data ?? '',
                      style: textNormal(
                        Colors.red,
                        12,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            spaceH16,
            Text(
              'Middle name',
              style: textNormal(
                AppTheme.getInstance().whiteColor(),
                16,
              ),
            ),
            spaceH4,
            Container(
              height: 64.h,
              padding: EdgeInsets.only(right: 15.w, left: 15.w),
              decoration: BoxDecoration(
                color: AppTheme.getInstance().backgroundBTSColor(),
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: middleNameController,
                      maxLength: 100,
                      onChanged: (value) {},
                      cursorColor: AppTheme.getInstance().whiteColor(),
                      style: textNormal(
                        AppTheme.getInstance().whiteColor(),
                        16,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isCollapsed: true,
                        counterText: '',
                        hintText: S.current.enter_name,
                        hintStyle: textNormal(
                          Colors.white.withOpacity(0.5),
                          16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'Date of birth',
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                ),
                Text(
                  '*',
                  style: textNormal(
                    AppTheme.getInstance().redColor(),
                    16,
                  ),
                ),
              ],
            ),
            spaceH4,
            InkWell(
              onTap: () async {
                DateTime? picked;
                if (Platform.isAndroid) {
                  picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900, 8),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          colorScheme: const ColorScheme.dark(
                            background: colorSkeleton,
                            surface: colorSkeleton,
                            onSurface: Colors.amberAccent,
                            // default text color
                            primary: Colors.amberAccent, // circle color
                          ),
                          dialogBackgroundColor: colorSkeleton,
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                              primary: Colors.amber,
                              // color of button's letters
                              backgroundColor: Colors.black54,
                              // Background color
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                } else {
                  picked = await showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height / 3,
                        color: Colors.white,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (picked) {
                            if (picked !=
                                DateTime.fromMillisecondsSinceEpoch(
                                  cubit.selectBirth.value,
                                )) {
                              cubit.selectBirth
                                  .add(picked.millisecondsSinceEpoch);
                            }
                          },
                          initialDateTime: DateTime.fromMillisecondsSinceEpoch(
                            cubit.selectBirth.value,
                          ),
                          minimumYear: 1900,
                          maximumDate: DateTime.now(),
                        ),
                      );
                    },
                  );
                }
                if (picked != null) {
                  cubit.selectBirth.add(picked.millisecondsSinceEpoch);
                }
              },
              child: StreamBuilder<int>(
                stream: cubit.selectBirth,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  return Container(
                    height: 64.h,
                    padding: EdgeInsets.only(right: 15.w, left: 15.w),
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().backgroundBTSColor(),
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            formatDateTime2.format(
                              DateTime.fromMillisecondsSinceEpoch(
                                snapshot.data ??
                                    DateTime.now().millisecondsSinceEpoch,
                              ),
                            ),
                            style: textNormalCustom(
                              Colors.white,
                              16,
                              FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Image.asset(
                          ImageAssets.ic_calendar_create_book,
                          width: 24.w,
                          height: 24.h,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Text(
                  'Country',
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                ),
                Text(
                  '*',
                  style: textNormal(
                    AppTheme.getInstance().redColor(),
                    16,
                  ),
                ),
              ],
            ),
            spaceH4,
            StreamBuilder<CountryModel>(
              stream: cubit.country,
              builder: (context, snapshot) {
                return InkWell(
                  onTap: () {
                    boxSearch(
                      context,
                      list: cubit.listCountry,
                      checkList: CheckList.COUNTRY,
                    );
                  },
                  child: Container(
                    height: 64.h,
                    padding: EdgeInsets.only(right: 15.w, left: 15.w),
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().backgroundBTSColor(),
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            snapshot.data?.name ?? 'Select your country',
                            style: textNormalCustom(
                              Colors.white,
                              16,
                              FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Image.asset(
                          ImageAssets.ic_line_down,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Row(
              children: [
                Text(
                  'City',
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                ),
                Text(
                  '*',
                  style: textNormal(
                    AppTheme.getInstance().redColor(),
                    16,
                  ),
                ),
              ],
            ),
            spaceH4,
            StreamBuilder<CityModel>(
              stream: cubit.city,
              builder: (context, snapshot) {
                return InkWell(
                  onTap: () {
                    boxSearch(
                      context,
                      list: cubit.listCity,
                      checkList: CheckList.CITIES,
                    );
                  },
                  child: Container(
                    height: 64.h,
                    padding: EdgeInsets.only(right: 15.w, left: 15.w),
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().backgroundBTSColor(),
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            snapshot.data?.name ?? 'Select your city',
                            style: textNormalCustom(
                              Colors.white,
                              16,
                              FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Image.asset(
                          ImageAssets.ic_line_down,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Row(
              children: [
                Text(
                  'Address',
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                ),
                Text(
                  '*',
                  style: textNormal(
                    AppTheme.getInstance().redColor(),
                    16,
                  ),
                ),
              ],
            ),
            spaceH4,
            Container(
              height: 64.h,
              padding: EdgeInsets.only(right: 15.w, left: 15.w),
              decoration: BoxDecoration(
                color: AppTheme.getInstance().backgroundBTSColor(),
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: addressController,
                      maxLength: 100,
                      cursorColor: AppTheme.getInstance().whiteColor(),
                      style: textNormal(
                        AppTheme.getInstance().whiteColor(),
                        16,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isCollapsed: true,
                        counterText: '',
                        hintText: S.current.enter_add,
                        hintStyle: textNormal(
                          Colors.white.withOpacity(0.5),
                          16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            spaceH38,
          ],
        ),
      ),
    );
  }

  Widget step() {
    return SizedBox(
      height: 30.h,
      width: 318.w,
      child: Row(
        children: [
          const CircleStepCreateNft(
            circleStatus: CircleStatus.IS_CREATING,
            stepCreate: '1',
          ),
          dividerVerify,
          CircleStepCreateNft(
            circleStatus: CircleStatus.IS_NOT_CREATE,
            stepCreate: S.current.step2,
          ),
          dividerVerify,
          CircleStepCreateNft(
            circleStatus: CircleStatus.IS_NOT_CREATE,
            stepCreate: S.current.step3,
          ),
        ],
      ),
    );
  }

  void boxSearch(
    BuildContext context, {
    required CheckList checkList,
    List<Object>? list,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        opaque: false,
        pageBuilder: (_, __, ___) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Center(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 8.w,
                        right: 8.w,
                        top: 8.h,
                        bottom: 8.h,
                      ),
                      height: 300.h,
                      width: 343.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        color: colorSkeleton,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 48.h,
                            padding: EdgeInsets.only(right: 15.w, left: 15.w),
                            decoration: BoxDecoration(
                              color:
                                  AppTheme.getInstance().backgroundBTSColor(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: checkList == CheckList.COUNTRY
                                        ? textSearchController
                                        : textSearchCityController,
                                    maxLength: 100,
                                    onChanged: (value) {
                                      if (checkList == CheckList.COUNTRY) {
                                        cubit.searchCountry(value);
                                      } else {
                                        cubit.searchCities(value);
                                      }
                                    },
                                    cursorColor:
                                        AppTheme.getInstance().whiteColor(),
                                    style: textNormal(
                                      AppTheme.getInstance().whiteColor(),
                                      16,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isCollapsed: true,
                                      hintText: checkList == CheckList.COUNTRY
                                          ? 'Enter your country'
                                          : 'Enter your city',
                                      counterText: '',
                                      hintStyle: textNormal(
                                        Colors.white.withOpacity(0.5),
                                        16,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          divider,
                          Expanded(
                            child: checkList == CheckList.COUNTRY
                                ? StreamBuilder<List<CountryModel>>(
                                    stream: cubit.streamCountry,
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        itemCount: snapshot.data?.length ?? 0,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if ((snapshot.data?.length ?? 0) >
                                              0) {
                                            return InkWell(
                                              onTap: () {
                                                cubit.country.add(
                                                  snapshot.data?[index] ??
                                                      CountryModel(),
                                                );
                                                Navigator.pop(context);
                                                cubit.getCites(
                                                  snapshot.data?[index].id ??
                                                      '0',
                                                );
                                              },
                                              child: Container(
                                                color:
                                                    cubit.country.value.name ==
                                                            snapshot
                                                                .data?[index]
                                                                .name
                                                        ? Colors.white
                                                            .withOpacity(0.4)
                                                        : Colors.transparent,
                                                child: Column(
                                                  children: [
                                                    spaceH5,
                                                    Text(
                                                      snapshot.data?[index]
                                                              .name ??
                                                          '',
                                                      style: textNormal(
                                                        Colors.white,
                                                        14,
                                                      ),
                                                    ),
                                                    spaceH5,
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        },
                                      );
                                    },
                                  )
                                : StreamBuilder<List<CityModel>>(
                                    stream: cubit.streamCity,
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        itemCount: snapshot.data?.length ?? 0,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if ((snapshot.data?.length ?? 0) >
                                              0) {
                                            return InkWell(
                                              onTap: () {
                                                cubit.city.add(
                                                  snapshot.data?[index] ??
                                                      CityModel(),
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                color: cubit.city.value.name ==
                                                        snapshot
                                                            .data?[index].name
                                                    ? Colors.white
                                                        .withOpacity(0.4)
                                                    : Colors.transparent,
                                                child: Column(
                                                  children: [
                                                    spaceH5,
                                                    Text(
                                                      snapshot.data?[index]
                                                              .name ??
                                                          '',
                                                      style: textNormal(
                                                        Colors.white,
                                                        14,
                                                      ),
                                                    ),
                                                    spaceH5,
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
