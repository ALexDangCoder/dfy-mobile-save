import 'dart:async';
import 'dart:io';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/presentation/pawn/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/check_tab_bar.dart';
import 'package:Dfy/presentation/pawn/verification/cubit/verification_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/item/successCkcCreateNft.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';

class StepThreeVerify extends StatefulWidget {
  const StepThreeVerify({Key? key, required this.cubit}) : super(key: key);
  final VerificationCubit cubit;

  @override
  _StepThreeVerifyState createState() => _StepThreeVerifyState();
}

class _StepThreeVerifyState extends State<StepThreeVerify> {
  late VerificationCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = widget.cubit;
    cubit.getReward();
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    cubit.getListWallets();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: 'Identity verification',
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
            onTap: () async {
              if(cubit.selectSelfieImage.value == StatusPickFile.PICK_SUCCESS){
                unawaited(showLoadingDialog(context, showLoading: true));
                await cubit.putDataKYC();
                await showLoadSuccess(context, onlySuccess: true).then(
                      (value) {
                        Navigator.of(context)
                          ..pop()..pop()..pop()..pop()
                          ..pop(true);
                      }
                );
              }
              else {
                cubit.errorSelfiePhoto.add('Image is required');
              }
            },
            child: ButtonRadial(
              height: 64.h,
              width: double.infinity,
              child: Center(
                child: Text(
                  S.current.submit,
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
            Align(
              child: Image.asset(
                ImageAssets.img_selfie,
                height: 253.h,
                width: 286.w,
              ),
            ),
            spaceH24,
            description(
              'Take a selfie of yourself with a natural expression',
              true,
            ),
            spaceH12,
            description(
              'Make sure your whole face is visible, centred and your eyes are open',
              true,
            ),
            spaceH12,
            description(
              'Do not crop your ID or use screenshot of your ID',
              false,
            ),
            spaceH12,
            description(
              'Do not hide of alter parts of your face (No hats/beauty images/filters/headgear)',
              false,
            ),
            spaceH27,
            Text(
              'Maximum file size is 10Mb (allow GIF,PNG,JPG,PDF)',
              style: textNormal(
                AppTheme.getInstance().whiteColor(),
                16,
              ),
            ),
            spaceH16,
            uploadFile(
              'Upload a selfie photo',
              () {
                cubit.pickSelfieImage();
              },
            ),
            StreamBuilder<String>(
              stream: cubit.errorSelfiePhoto,
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
            spaceH27,
            StreamBuilder<String>(
              stream: cubit.reward,
              builder: (context, snapshot) {
                return Text(
                  'Connect waller to get ${snapshot.data} DFY as reward',
                  style: textNormal(
                    Colors.white,
                    16,
                  ),
                );
              },
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<String>(
                    stream: cubit.walletAddress,
                    builder: (context, snapshot) {
                      return Text(
                        (snapshot.data ?? '').formatAddress(
                          index: ((snapshot.data?.length ?? 0) > 10) ? 10 : 0,
                        ),
                        style: textNormal(
                          Colors.white,
                          16,
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      showWallet(context, cubit.listWallet);
                    },
                    child: Text(
                      'Change wallet',
                      style: textNormal(
                        fillYellowColor,
                        16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
          const SuccessCkcCreateNft(),
          dividerVerifySuccess,
          CircleStepCreateNft(
            circleStatus: CircleStatus.IS_CREATING,
            stepCreate: S.current.step3,
          ),
        ],
      ),
    );
  }

  Widget description(String text, bool good) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Container(
            height: 16.h,
            width: 16.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.getInstance().whiteColor(),
            ),
            child: sizedSvgImage(
              w: 20,
              h: 20,
              image: good
                  ? ImageAssets.ic_transaction_success_svg
                  : ImageAssets.ic_transaction_fail_svg,
            ),
          ),
        ),
        spaceW10,
        SizedBox(
          width: 317.w,
          child: Text(
            text,
            style: textNormal(
              Colors.white,
              16,
            ),
          ),
        ),
      ],
    );
  }

  Widget uploadFile(String title, Function pickFile) {
    return DottedBorder(
      radius: Radius.circular(20.r),
      borderType: BorderType.RRect,
      color: AppTheme.getInstance().dashedColorContainer(),
      child: InkWell(
        onTap: () {
          if (cubit.mediaSelfiePath == '') {
            cubit.selectSelfieImage.add(StatusPickFile.START);
            pickFile();
          }
        },
        child: SizedBox(
          width: 343.w,
          height: 170.h,
          child: StreamBuilder<String>(
            stream: cubit.pickSelfieFile,
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
                          cubit.clearImageSelfie();
                        },
                        child: Image.asset(
                          ImageAssets.ic_close,
                        ),
                      ),
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

  void showWallet(BuildContext context, List<Wallet> listWallet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0.r,
              ),
            ),
          ),
          backgroundColor: AppTheme.getInstance().selectDialogColor(),
          content: SizedBox(
            width: 343.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select wallet',
                  style: textNormalCustom(
                    fillYellowColor,
                    20,
                    FontWeight.w600,
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.only(top: 10.h),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listWallet.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        cubit.walletAddress.add(listWallet[index].address ?? '');
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          spaceH5,
                          Row(
                            children: [
                              Container(
                                width: 36.w,
                                height: 36.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      '${ImageAssets.image_avatar}${cubit.randomAvatar()}'
                                          '.png',
                                    ),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              spaceW10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listWallet[index].name ?? '',
                                    style: textNormalCustom(
                                      Colors.white,
                                      16,
                                      FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    (listWallet[index].address ?? '').formatAddress(
                                      index:
                                          ((listWallet[index].address?.length ?? 0) > 10)
                                              ? 10
                                              : 0,
                                    ),
                                    style: textNormalCustom(
                                      Colors.white,
                                      16,
                                      FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          spaceH5,
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
