import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/check_tab_bar.dart';
import 'package:Dfy/presentation/pawn/verification/cubit/verification_cubit.dart';
import 'package:Dfy/presentation/pawn/verification/ui/step_three_verify.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/item/successCkcCreateNft.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Identity { CC_ID, DV_ID, PP_ID }

class StepTwoVerify extends StatefulWidget {
  const StepTwoVerify({Key? key, required this.cubit}) : super(key: key);
  final VerificationCubit cubit;

  @override
  _StepTwoVerifyState createState() => _StepTwoVerifyState();
}

class _StepTwoVerifyState extends State<StepTwoVerify> {
  late VerificationCubit cubit;
  late TextEditingController ccIdController;
  late TextEditingController drIdController;
  late TextEditingController ppIdController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = widget.cubit;
    ccIdController = TextEditingController();
    drIdController = TextEditingController();
    ppIdController = TextEditingController();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: 'Identity documents',
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
              if (cubit.checkData(
                ccIdController.text,
                drIdController.text,
                ppIdController.text,
              )) {
                cubit.upLoadImage();
                goTo(
                  context,
                  StepThreeVerify(
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
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor:
                                AppTheme.getInstance().whiteColor(),
                          ),
                          child: Radio<Identity>(
                            activeColor: AppTheme.getInstance().fillColor(),
                            value: Identity.CC_ID,
                            groupValue: cubit.type,
                            onChanged: (Identity? value) {
                              cubit.type = value ?? Identity.CC_ID;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      spaceW4,
                      GestureDetector(
                        onTap: () {
                          cubit.type = Identity.CC_ID;
                          setState(() {});
                        },
                        child: Text(
                          'Government card',
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor:
                                AppTheme.getInstance().whiteColor(),
                          ),
                          child: Radio<Identity>(
                            activeColor: AppTheme.getInstance().fillColor(),
                            value: Identity.DV_ID,
                            groupValue: cubit.type,
                            onChanged: (Identity? value) {
                              cubit.type = value ?? Identity.DV_ID;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      spaceW4,
                      GestureDetector(
                        onTap: () {
                          cubit.type = Identity.DV_ID;
                          setState(() {});
                        },
                        child: Text(
                          'Driver license',
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            spaceH20,
            Row(
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor:
                          AppTheme.getInstance().whiteColor(),
                    ),
                    child: Radio<Identity>(
                      activeColor: AppTheme.getInstance().fillColor(),
                      value: Identity.PP_ID,
                      groupValue: cubit.type,
                      onChanged: (Identity? value) {
                        cubit.type = value ?? Identity.PP_ID;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                spaceW4,
                GestureDetector(
                  onTap: () {
                    cubit.type = Identity.PP_ID;
                    setState(() {});
                  },
                  child: Text(
                    'Passport',
                    style: textNormalCustom(
                      null,
                      16,
                      FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            spaceH27,
            if (cubit.type == Identity.CC_ID ||
                cubit.type == Identity.DV_ID) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  formatImage(
                    cubit.type == Identity.CC_ID
                        ? ImageAssets.img_id_good
                        : ImageAssets.img_dr_good,
                    true,
                    'Good',
                    png: false,
                  ),
                  formatImage(
                    cubit.type == Identity.CC_ID
                        ? ImageAssets.img_id_not_cropped
                        : ImageAssets.img_dr_not_cropped,
                    false,
                    'Not cropped',
                    png: false,
                  ),
                ],
              ),
              spaceH20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  formatImage(
                    cubit.type == Identity.CC_ID
                        ? ImageAssets.img_id_not_blur
                        : ImageAssets.img_dr_not_blur,
                    false,
                    'Not blur',
                    png: true,
                  ),
                  formatImage(
                    cubit.type == Identity.CC_ID
                        ? ImageAssets.img_id_not_reflective
                        : ImageAssets.img_dr_not_reflective,
                    false,
                    'Not reflective',
                    png: true,
                  ),
                ],
              ),
              spaceH27,

              /// Upload Image
              Row(
                children: [
                  Text(
                    cubit.type == Identity.CC_ID
                        ? 'ID number'
                        : 'Driver license number',
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
                        controller: cubit.type == Identity.CC_ID
                            ? ccIdController
                            : drIdController,
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
                          hintText: cubit.type == Identity.CC_ID
                              ? 'Enter ID number'
                              : 'Enter driver license number',
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
                stream: cubit.errorId,
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
              spaceH36,
              Text(
                'Maximum file size is 10Mb (allow GIF,PNG,JPG,PDF)',
                style: textNormal(
                  AppTheme.getInstance().whiteColor(),
                  16,
                ),
              ),
              spaceH16,
              uploadFile(
                'Upload front of photo',
                () {
                  cubit.pickImage(isBackMedia: true);
                },
                true,
              ),
              StreamBuilder<String>(
                stream: cubit.errorFrontPhoto,
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
              spaceH32,
              uploadFile(
                'Upload back of photo',
                () {
                  cubit.pickImage();
                },
                false,
              ),
              StreamBuilder<String>(
                stream: cubit.errorBackPhoto,
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
            if (cubit.type == Identity.PP_ID) ...[
              Align(
                child: Column(
                  children: [
                    formatImage(
                      ImageAssets.img_pp_good,
                      true,
                      'Good',
                      png: false,
                    ),
                    spaceH20,
                    formatImage(
                      ImageAssets.img_pp_cropped,
                      false,
                      'Not cropped',
                      png: false,
                    ),
                    spaceH20,
                    formatImage(
                      ImageAssets.img_pp_too_small,
                      false,
                      'Not too small',
                      png: false,
                    ),
                    spaceH20,
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Passport number',
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
                        controller: ppIdController,
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
                          hintText: 'Enter passport number',
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
                stream: cubit.errorId,
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
              spaceH36,
              Text(
                'Maximum file size is 10Mb (allow GIF,PNG,JPG,PDF)',
                style: textNormal(
                  AppTheme.getInstance().whiteColor(),
                  16,
                ),
              ),
              spaceH16,
              uploadFile(
                'Upload photo',
                () {
                  cubit.pickImage(isBackMedia: true);
                },
                true,
              ),
              StreamBuilder<String>(
                stream: cubit.errorFrontPhoto,
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
            spaceH32,
            const CheckboxItemTab(
              nameCheckbox:
                  'This information is kept private and confidential by DeFi For You.',
              isSelected: true,
            ),
            spaceH32,
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
          const SuccessCkcCreateNft(),
          dividerVerifySuccess,
          CircleStepCreateNft(
            circleStatus: CircleStatus.IS_CREATING,
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

  Widget formatImage(String svgImage, bool good, String title, {bool? png}) {
    return Column(
      children: [
        if (png == false)
          SizedBox(
            height: 104.h,
            width: 156.w,
            child: sizedSvgImage(w: 156.w, h: 104.h, image: svgImage),
          )
        else
          SizedBox(
            height: 104.h,
            child: sizedPngImage(
              image: svgImage,
              h: 104,
              w: 156,
            ),
          ),
        spaceH16,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 16.h,
              width: 16.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.getInstance().whiteColor(),
              ),
              child: sizedSvgImage(
                w: 16,
                h: 16,
                image: good
                    ? ImageAssets.ic_transaction_success_svg
                    : ImageAssets.ic_transaction_fail_svg,
              ),
            ),
            spaceW8,
            Text(
              title,
              style: textNormal(
                Colors.white,
                16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget uploadFile(String title, Function pickFile, bool frontPhoto) {
    return DottedBorder(
      radius: Radius.circular(20.r),
      borderType: BorderType.RRect,
      color: AppTheme.getInstance().dashedColorContainer(),
      child: InkWell(
        onTap: () {
          if ((frontPhoto && cubit.mediaFrontFilePath == '') ||
              (!frontPhoto && cubit.mediaBackFilePath == '')) {
            pickFile();
          }
        },
        child: SizedBox(
          width: 343.w,
          height: 170.h,
          child: StreamBuilder<String>(
            stream: frontPhoto ? cubit.pickFrontFile : cubit.pickBackFile,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != '') {
                final imageFile = File(snapshot.data!);
                return Stack(
                  children: [
                    Align(
                      child: Image.file(
                        imageFile,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap: () {
                            cubit.clearImage(frontPhoto);
                          },
                          child: Image.asset(
                            ImageAssets.ic_close,
                          )),
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageAssets.createNft,
                    ),
                    spaceH12,
                    Text(
                      title,
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        14,
                        FontWeight.w400,
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
