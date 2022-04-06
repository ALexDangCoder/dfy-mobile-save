import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/setting_my_acc/cubit/setting_my_acc_cubit.dart';
import 'package:Dfy/presentation/pawn/setting_my_acc/ui/confirm_disconnect_wallet.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingMyAcc extends StatefulWidget {
  const SettingMyAcc({Key? key}) : super(key: key);

  @override
  _SettingMyAccState createState() => _SettingMyAccState();
}

class _SettingMyAccState extends State<SettingMyAcc> {
  late SettingMyAccCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = SettingMyAccCubit();
    cubit.getListWallet();
    cubit.getNotiSetting();
    cubit.getEmailSetting();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingMyAccCubit, SettingMyAccState>(
      bloc: cubit,
      builder: (context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException(S.current.error, ''),
          retry: () {},
          textEmpty: '',
          child: BaseDesignScreen(
            isCustomLeftClick: true,
            onLeftClick: () {
              cubit.putNotiSetting();
              cubit.putEmailSetting();
              Navigator.pop(context);
            },
            title: S.current.setting,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.only(
                      left: 12.w,
                      top: 16.h,
                      bottom: 20.h,
                    ),
                    decoration: BoxDecoration(
                      color: borderItemColors,
                      borderRadius: BorderRadius.all(Radius.circular(14.r)),
                      border: Border.all(color: dialogColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email Push',
                          style: textNormalCustom(
                            Colors.white,
                            16,
                            FontWeight.w600,
                          ),
                        ),
                        spaceH3,
                        Text(
                          'You can set here to refuse to receive emails',
                          style: textNormalCustom(
                            Colors.white.withOpacity(0.7),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                        spaceH20,
                        switchBox(
                          context,
                          cubit.emailSetting.notificationEmail ?? true,
                          'Notification email borrow/lend contract',
                          () {
                            showInfo(context, [
                              'Generate new contract',
                              'Generate Interest/Penalty/Loan period',
                              'Pay Interest/Penalty/Loan',
                              'Warning overdue loan',
                              'Completed Contract',
                              'Liquidated Contract',
                              'Current LTV is about to reach LTV liquidate threshold',
                            ]);
                          },
                          () {},
                          notChange: true,
                        ),
                        spaceH20,
                        switchBox(
                          context,
                          cubit.emailSetting.activitiesEmail ?? false,
                          'Your activities',
                          () {
                            showInfo(context, [
                              'Create your collateral/loan package',
                              'Send your collateral/offer',
                              'Add more your collateral',
                              'Withdraw your collateral',
                              'Cancel your offer',
                              'Re-open your loan package',
                              'Accept/reject other offer',
                              'Accept/reject other collateral',
                            ]);
                          },
                          () {
                            cubit.emailSetting.activitiesEmail =
                                !(cubit.emailSetting.activitiesEmail ?? false);
                            cubit.emit(SettingEmail(cubit.emailSetting));
                          },
                        ),
                        spaceH20,
                        switchBox(
                          context,
                          cubit.emailSetting.otherUserEmail ?? false,
                          'Notification email from other users',
                          () {
                            showInfo(context, [
                              'Your collateral has accepted/rejected',
                              'Your offer has accepted/rejected',
                              'Your verification has accepted/rejected',
                            ]);
                          },
                          () {
                            cubit.emailSetting.otherUserEmail =
                                !(cubit.emailSetting.otherUserEmail ?? false);
                            cubit.emit(SettingEmail(cubit.emailSetting));
                          },
                        ),
                      ],
                    ),
                  ),
                  spaceH20,
                  Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.only(
                      left: 12.w,
                      top: 16.h,
                      bottom: 20.h,
                    ),
                    decoration: BoxDecoration(
                      color: borderItemColors,
                      borderRadius: BorderRadius.all(Radius.circular(14.r)),
                      border: Border.all(color: dialogColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notification',
                          style: textNormalCustom(
                            Colors.white,
                            16,
                            FontWeight.w600,
                          ),
                        ),
                        spaceH3,
                        Text(
                          'Once enable, you will receive relevant notifications within the app and website',
                          style: textNormalCustom(
                            Colors.white.withOpacity(0.7),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                        spaceH20,
                        switchBox(
                          context,
                          cubit.notiSetting.hotNewNoti ?? false,
                          'Hot news',
                          () {
                            showInfo(context, [
                              'Promotions program',
                            ]);
                          },
                          () {
                            cubit.notiSetting.hotNewNoti =
                                !(cubit.notiSetting.hotNewNoti ?? false);
                            cubit.emit(SettingNotification(cubit.notiSetting));
                          },
                        ),
                        spaceH20,
                        switchBox(
                          context,
                          cubit.notiSetting.activitiesNoti ?? false,
                          'Activities',
                          () {
                            showInfo(context, [
                              'Transaction activities',
                            ]);
                          },
                          () {
                            cubit.notiSetting.activitiesNoti =
                                !(cubit.notiSetting.activitiesNoti ?? false);
                            cubit.emit(SettingNotification(cubit.notiSetting));
                          },
                        ),
                        spaceH20,
                        switchBox(
                          context,
                          cubit.notiSetting.newSystemNoti ?? false,
                          'New system',
                          () {
                            showInfo(context, [
                              'New feature & function update',
                            ]);
                          },
                          () {
                            cubit.notiSetting.newSystemNoti =
                                !(cubit.notiSetting.newSystemNoti ?? false);
                            cubit.emit(SettingNotification(cubit.notiSetting));
                          },
                        ),
                        spaceH20,
                        switchBox(
                          context,
                          cubit.notiSetting.warningNoti ?? false,
                          'Warning',
                          () {
                            showInfo(context, [
                              'Login new device',
                            ]);
                          },
                          () {
                            cubit.notiSetting.warningNoti =
                                !(cubit.notiSetting.warningNoti ?? false);
                            cubit.emit(SettingNotification(cubit.notiSetting));
                          },
                        ),
                      ],
                    ),
                  ),
                  spaceH20,
                  Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.only(
                      left: 12.w,
                      top: 16.h,
                      right: 16.w,
                      bottom: 20.h,
                    ),
                    decoration: BoxDecoration(
                      color: borderItemColors,
                      borderRadius: BorderRadius.all(Radius.circular(14.r)),
                      border: Border.all(color: dialogColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wallet',
                          style: textNormalCustom(
                            Colors.white,
                            16,
                            FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 10.h),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.listWallet.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        cubit.listWallet[index].walletAddress
                                                ?.formatAddress(index: 10) ??
                                            '',
                                        style: textNormalCustom(
                                          Colors.white,
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          goTo(
                                            context,
                                            ConfirmDisconnectWallet(
                                              wallet: cubit.listWallet[index]
                                                      .walletAddress ??
                                                  '',
                                              cubit: cubit,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 114.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.r),
                                            ),
                                            border: Border.all(
                                              color: fillYellowColor,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Disassociate',
                                              style: textNormalCustom(
                                                fillYellowColor,
                                                16,
                                                FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  spaceH20,
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  spaceH20,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget switchBox(
    BuildContext context,
    bool value,
    String title,
    Function function,
    Function onchange, {
    bool? notChange,
  }) {
    return SizedBox(
      child: Row(
        children: [
          CupertinoSwitch(
            value: value,
            onChanged: (notChange ?? false)
                ? null
                : (bool value) {
                    cubit.emit(SettingMyAccInitial());
                    onchange();
                  },
            activeColor: AppTheme.getInstance().fillColor(),
            trackColor: colorSwitch,
          ),
          spaceW12,
          SizedBox(
            width: 240.w,
            child: RichText(
              text: TextSpan(
                text: '',
                style: textNormalCustom(
                  AppTheme.getInstance().getGray3(),
                  16,
                  FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: title,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox(
                      width: 4.w,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: () {
                        function();
                      },
                      child: Image.asset(
                        ImageAssets.ic_about_2,
                        height: 17.h,
                        width: 17.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showInfo(BuildContext context, List<String> listInfo) {
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
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.h),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listInfo.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listInfo[index],
                      style: textNormalCustom(
                        Colors.white,
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH10,
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
