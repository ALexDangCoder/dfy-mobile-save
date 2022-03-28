import 'dart:async';
import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/edit_peronal_info/cubit/edit_personal_info_cubit.dart';
import 'package:Dfy/presentation/put_on_market/ui/component/custom_calandar.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

class EditPersonalInfo extends StatefulWidget {
  const EditPersonalInfo({Key? key, required this.userProfile})
      : super(key: key);
  final UserProfile userProfile;

  @override
  _EditPersonalInfoState createState() => _EditPersonalInfoState();
}

class _EditPersonalInfoState extends State<EditPersonalInfo> {
  late TextEditingController nameController;
  late TextEditingController textSearchController;
  late TextEditingController textSearchCityController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController middleNameController;
  late TextEditingController addressController;
  late TextEditingController personalLinkController;
  late TextEditingController personalLink2Controller;
  late TextEditingController personalLink3Controller;
  late TextEditingController personalLink4Controller;
  late TextEditingController personalLink5Controller;
  List<TextEditingController> listPersonalLink = [];
  late EditPersonalInfoCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = EditPersonalInfoCubit();
    textSearchController = TextEditingController();
    textSearchCityController = TextEditingController();
    addressController = TextEditingController();
    nameController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    middleNameController = TextEditingController();
    personalLinkController = TextEditingController();
    personalLink2Controller = TextEditingController();
    personalLink3Controller = TextEditingController();
    personalLink4Controller = TextEditingController();
    personalLink5Controller = TextEditingController();
    nameController.text = widget.userProfile.name ?? '';
    listPersonalLink = [
      personalLink2Controller,
      personalLink3Controller,
      personalLink4Controller,
      personalLink5Controller,
    ];
    cubit.personalLink = widget.userProfile.links ?? [];
    cubit.listErrorPersonalLink.add(cubit.errorPersonalLink2);
    cubit.listErrorPersonalLink.add(cubit.errorPersonalLink3);
    cubit.listErrorPersonalLink.add(cubit.errorPersonalLink4);
    cubit.listErrorPersonalLink.add(cubit.errorPersonalLink5);
    if (widget.userProfile.links?.isNotEmpty ?? false) {
      personalLinkController.text = widget.userProfile.links?[0] ?? '';
      if (widget.userProfile.links!.length > 1) {
        for (int i = 0; i < widget.userProfile.links!.length - 1; i++) {
          listPersonalLink[i].text = widget.userProfile.links?[i + 1] ?? '';
          cubit.personalLinkStream.add(widget.userProfile.links!.length - 1);
        }
      } else {
        cubit.personalLinkStream.add(widget.userProfile.links?.length ?? 0);
      }
    }
    cubit.getCountriesApi();
    if (widget.userProfile.kyc != null) {
      cubit.getCountriesApi();
      cubit.getCites(widget.userProfile.kyc?.country?.id ?? '0');
      firstNameController.text = widget.userProfile.kyc?.firstName ?? '';
      lastNameController.text = widget.userProfile.kyc?.lastName ?? '';
      middleNameController.text = widget.userProfile.kyc?.middleName ?? '';
      cubit.selectBirth.add(widget.userProfile.kyc?.dateOfBirth ?? 0);
      cubit.country.add(widget.userProfile.kyc?.country ?? CountryModel());
      textSearchController.text = widget.userProfile.kyc?.country?.name ?? '';
      addressController.text = widget.userProfile.kyc?.address ?? '';
    }
  }

  @override
  void dispose() {
    textSearchController.clear();
    textSearchCityController.clear();
    textSearchCityController.clear();
    addressController.clear();
    nameController.clear();
    firstNameController.clear();
    lastNameController.clear();
    middleNameController.clear();
    personalLinkController.clear();
    personalLink2Controller.clear();
    personalLink3Controller.clear();
    personalLink4Controller.clear();
    personalLink5Controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPersonalInfoCubit, EditPersonalInfoState>(
      bloc: cubit,
      builder: (context, state) {
        return BaseDesignScreen(
          title: 'Edit Personal Info',
          isImage: false,
          onRightClick: () async {
            if (widget.userProfile.kyc == null) {
              if (nameController.text != '') {
                unawaited(showLoadingDialog(context, showLoading: true));
                await cubit.updateData(
                  name: nameController.text,
                  list: cubit.getListLink(
                      personalLinkController.text, listPersonalLink),
                );
                await showLoadSuccess(context, onlySuccess: true).then(
                      (value) => Navigator.of(context)
                    ..pop()
                    ..pop(true),
                );
              } else {
                cubit.errorName.add('Name is not null');
              }
            } else {
              if (firstNameController.text != '' &&
                  lastNameController.text != '') {
                unawaited(showLoadingDialog(context, showLoading: true));
                await cubit.updateData(
                  address: addressController.text,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  middleName: middleNameController.text,
                  dateOfBirth: cubit.selectBirth.value,
                  cityId: cubit.city.value.id.toString(),
                  countryId: cubit.country.value.id.toString(),
                  list: cubit.getListLink(
                      personalLinkController.text, listPersonalLink),
                );
                await showLoadSuccess(context, onlySuccess: true).then(
                  (value) => Navigator.of(context)
                    ..pop()
                    ..pop(true),
                );
              } else {}
            }
          },
          text: S.current.save,
          resizeBottomInset: true,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 24.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.userProfile.kyc == null) ...[
                  Text(
                    'Name',
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
                            controller: nameController,
                            maxLength: 100,
                            onChanged: (value) {
                              if (value == '') {
                                cubit.errorName.add('Name is not null');
                              } else {
                                cubit.errorName.add('');
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
                    stream: cubit.errorName,
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
                ] else ...[
                  Text(
                    'First name',
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
                            controller: firstNameController,
                            maxLength: 100,
                            onChanged: (value) {
                              if (value == '') {
                                cubit.errorFirstName
                                    .add('First name is not null');
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
                  Text(
                    'Last name',
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
                            controller: lastNameController,
                            maxLength: 100,
                            onChanged: (value) {
                              if (value == '') {
                                cubit.errorLastName
                                    .add('Last name is not null');
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
                  Text(
                    'Date of birth',
                    style: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16,
                    ),
                  ),
                  spaceH4,
                  InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration.zero,
                          opaque: false,
                          pageBuilder: (_, __, ___) {
                            return CustomCalendar(
                              isCheckDate: false,
                              selectDate: DateTime.fromMillisecondsSinceEpoch(
                                widget.userProfile.kyc?.dateOfBirth ?? 0,
                                isUtc: true,
                              ),
                            );
                          },
                        ),
                      );
                      if (result != null) {
                        cubit.selectBirth.add(result.millisecondsSinceEpoch);
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  formatDateTime2.format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      snapshot.data ?? 0,
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
                  Text(
                    'Country',
                    style: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16,
                    ),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
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
                  Text(
                    'City',
                    style: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16,
                    ),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
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
                  Text(
                    'Address',
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
                            controller: addressController,
                            maxLength: 100,
                            onChanged: (value) {
                              if (value == '') {
                                cubit.errorAddress.add('Address is not null');
                              } else {
                                cubit.errorAddress.add('');
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
                  StreamBuilder<String>(
                    stream: cubit.errorAddress,
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
                ],
                spaceH16,
                Text(
                  'Email',
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
                        child: Text(
                          widget.userProfile.email ?? '',
                          style: textNormalCustom(
                            Colors.white,
                            16,
                            FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                spaceH16,
                Text(
                  'Personal link',
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
                          controller: personalLinkController,
                          maxLength: 100,
                          onChanged: (value) {
                            final Uri? uri = Uri.tryParse(value);
                            if (!(uri?.hasAbsolutePath ?? false)) {
                              cubit.errorPersonalLink
                                  .add('Please enter valid url');
                            } else {
                              cubit.errorPersonalLink.add('');
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
                            hintText: 'Enter your personal link',
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
                  stream: cubit.errorPersonalLink,
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
                StreamBuilder<int>(
                  stream: cubit.personalLinkStream,
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.data != 0) {
                      return SizedBox(
                        child: ListView.builder(
                          itemCount: snapshot.data ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                itemPersonalLink(
                                  listPersonalLink[index],
                                  index,
                                ),
                                spaceH16,
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                divider,
                spaceH20,
                StreamBuilder<int>(
                    stream: cubit.personalLinkStream,
                    builder: (context, snapshot) {
                      return InkWell(
                        onTap: () {
                          if ((snapshot.data ?? 0) < 4) {
                            if (listPersonalLink.length < 5) {
                              listPersonalLink.add(TextEditingController());
                              cubit.listErrorPersonalLink
                                  .add(BehaviorSubject<String>());
                            }
                            cubit.personalLinkStream
                                .add((snapshot.data ?? 0) + 1);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageAssets.addPropertiesNft,
                              width: 24.w,
                              height: 24.h,
                              color: (snapshot.data ?? 0) < 4
                                  ? fillYellowColor
                                  : grey3,
                            ),
                            spaceW8,
                            Text(
                              'Add more link',
                              style: textNormal(
                                (snapshot.data ?? 0) < 4
                                    ? fillYellowColor
                                    : grey3,
                                16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                spaceH20,
                divider,
                spaceH20,
              ],
            ),
          ),
        );
      },
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
                                              child: Column(
                                                children: [
                                                  Text(
                                                    snapshot.data?[index]
                                                            .name ??
                                                        '',
                                                    style: textNormal(
                                                      Colors.white,
                                                      14,
                                                    ),
                                                  ),
                                                  spaceH10,
                                                ],
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
                                              child: Column(
                                                children: [
                                                  Text(
                                                    snapshot.data?[index]
                                                            .name ??
                                                        '',
                                                    style: textNormal(
                                                      Colors.white,
                                                      14,
                                                    ),
                                                  ),
                                                  spaceH10,
                                                ],
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

  Widget itemPersonalLink(TextEditingController controller, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
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
                      child: TextFormField(
                        controller: controller,
                        maxLength: 100,
                        onChanged: (value) {
                          final Uri? uri = Uri.tryParse(value);
                          if (!(uri?.hasAbsolutePath ?? false)) {
                            cubit.listErrorPersonalLink[index]
                                .add('Please enter valid url');
                          } else {
                            cubit.listErrorPersonalLink[index].add('');
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
                          hintText: 'Enter your personal link',
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
            ),
            spaceW8,
            StreamBuilder<int>(
                stream: cubit.personalLinkStream,
                builder: (context, snapshot) {
                  return InkWell(
                    onTap: () {
                      if ((snapshot.data ?? 0) > 0) {
                        cubit.personalLinkStream.add((snapshot.data ?? 0) - 1);
                        listPersonalLink.removeAt(index);
                        cubit.listErrorPersonalLink.removeAt(index);
                      }
                    },
                    child: sizedSvgImage(
                      w: 24,
                      h: 24,
                      image: ImageAssets.delete_svg,
                    ),
                  );
                }),
          ],
        ),
        StreamBuilder<String>(
          stream: cubit.listErrorPersonalLink[index],
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
      ],
    );
  }
}
