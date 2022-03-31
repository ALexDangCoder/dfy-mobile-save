import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/presentation/pawn/verification/cubit/verification_cubit.dart';
import 'package:Dfy/presentation/pawn/verification/ui/step_one_verify.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  late VerificationCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = VerificationCubit();
    cubit.getDetailKYC();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationCubit, VerificationState>(
      bloc: cubit,
      builder: (context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException(S.current.error, ''),
          retry: () {},
          textEmpty: '',
          child: BaseDesignScreen(
            title: 'Verification',
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: (state is VerificationSuccess)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spaceH24,
                        Container(
                          clipBehavior: Clip.hardEdge,
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            left: 16.w,
                            top: 12.h,
                            right: 10.w,
                            bottom: 20.h,
                          ),
                          decoration: BoxDecoration(
                            color: borderItemColors,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.r)),
                            border: Border.all(color: dialogColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email verification',
                                style: textNormalCustom(
                                  Colors.white,
                                  16,
                                  FontWeight.w600,
                                ),
                              ),
                              spaceH3,
                              Text(
                                'Login using email',
                                style: textNormalCustom(
                                  Colors.white.withOpacity(0.7),
                                  14,
                                  FontWeight.w400,
                                ),
                              ),
                              spaceH12,
                              Text(
                                cubit.userProfile.email ?? '',
                                style: textNormalCustom(
                                  Colors.white,
                                  16,
                                  FontWeight.w400,
                                ),
                              ),
                              spaceH18,
                              Align(
                                child: Image.asset(
                                  ImageAssets.img_verification,
                                  height: 65.h,
                                  width: 52.w,
                                ),
                              ),
                              Align(
                                child: Text(
                                  'Verified',
                                  style: textNormalCustom(
                                    successTransactionColor,
                                    14,
                                    FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        spaceH20,
                        Container(
                          clipBehavior: Clip.hardEdge,
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            left: 16.w,
                            top: 12.h,
                            right: 10.w,
                            bottom: 20.h,
                          ),
                          decoration: BoxDecoration(
                            color: borderItemColors,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.r)),
                            border: Border.all(color: dialogColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Identity verification',
                                style: textNormalCustom(
                                  Colors.white,
                                  16,
                                  FontWeight.w600,
                                ),
                              ),
                              spaceH3,
                              Text(
                                'Verification is required to comply with KYC/AML regulations and to protect your account from unauthorized access',
                                style: textNormalCustom(
                                  Colors.white.withOpacity(0.7),
                                  14,
                                  FontWeight.w400,
                                ),
                              ),
                              spaceH20,
                              if (cubit.userProfile.kyc?.status == 2) ...[
                                Align(
                                  child: Image.asset(
                                    ImageAssets.img_verification,
                                    height: 65.h,
                                    width: 52.w,
                                  ),
                                ),
                                Align(
                                  child: Text(
                                    'Verified',
                                    style: textNormalCustom(
                                      successTransactionColor,
                                      14,
                                      FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ] else ...[
                                if (cubit.userProfile.kyc?.status != 1) ...[
                                  Align(
                                    child: Image.asset(
                                      ImageAssets.img_pending,
                                      height: 65.h,
                                      width: 52.w,
                                    ),
                                  ),
                                  Align(
                                    child: Text(
                                      'Pending',
                                      style: textNormalCustom(
                                        orangeColor,
                                        14,
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ] else ...[
                                  Align(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => StepOneVerify(
                                              kyc: cubit.userProfile.kyc,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ButtonRadial(
                                        height: 40.h,
                                        width: 106.w,
                                        radius: 12,
                                        child: Center(
                                          child: Text(
                                            'Verify now',
                                            style: textNormalCustom(
                                              Colors.white,
                                              16,
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  spaceH12,
                                  if (cubit.userProfile.kyc?.status == 3)
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'Your last verification is rejected. ',
                                            style: textNormalCustom(
                                              redMarketColor,
                                              14,
                                              FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'See reason',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => showDialogSuccess(
                                                    context,
                                                    alert: 'Reason reject',
                                                    text: cubit.userProfile.kyc
                                                            ?.reason ??
                                                        '',
                                                    onlyPop: true,
                                                  ),
                                            style: textNormalCustom(
                                              redMarketColor,
                                              14,
                                              FontWeight.w400,
                                            ).copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ]
                              ],
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
        );
      },
    );
  }
}
