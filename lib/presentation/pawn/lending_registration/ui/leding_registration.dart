import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/add_more_collateral/ui/add_more_collateral.dart';
import 'package:Dfy/presentation/pawn/lending_registration/bloc/leding_registration_bloc.dart';
import 'package:Dfy/presentation/pawn/lending_registration_accept/ui/leding_registration_accept.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LendingRegistration extends StatefulWidget {
  const LendingRegistration({Key? key}) : super(key: key);

  @override
  _LendingRegistrationState createState() => _LendingRegistrationState();
}

class _LendingRegistrationState extends State<LendingRegistration> {
  late TextEditingController emailEditingController;
  late LendingRegistrationBloc bloc;

  @override
  void initState() {
    super.initState();
    emailEditingController = TextEditingController();
    bloc = LendingRegistrationBloc();
    bloc.getListWallet();
    final profileJson = PrefsService.getUserProfile();
    final UserProfileModel profile = userProfileFromJson(
      profileJson,
    );
    emailEditingController.text = profile.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: () {
              closeKey(context);
              bloc.isChooseAcc.add(false);
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 812.h,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().bgBtsColor(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.h),
                    topRight: Radius.circular(30.h),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        spaceH16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 16.w,
                                ),
                                width: 24.w,
                                height: 24.h,
                                child: Image.asset(
                                  ImageAssets.ic_back,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 250.w,
                              child: Text(
                                S.current.lending_registration,
                                style: textNormalCustom(
                                  null,
                                  20.sp,
                                  FontWeight.w700,
                                ).copyWith(
                                  overflow: TextOverflow.ellipsis,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: 16.w,
                                ),
                                width: 24.w,
                                height: 24.h,
                                child: Image.asset(
                                  ImageAssets.ic_close,
                                ),
                              ),
                            ),
                          ],
                        ),
                        spaceH20,
                        line,
                        spaceH24,
                        Container(
                          height: 64.h,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: AppTheme.getInstance().itemBtsColors(),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: TextFormField(
                            enabled: false,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.emailAddress,
                            style: textNormal(
                              AppTheme.getInstance().textThemeColor(),
                              16,
                            ),
                            onChanged: (value) {
                              bloc.checkValidate(value);
                            },
                            controller: emailEditingController,
                            cursorColor:
                                AppTheme.getInstance().textThemeColor(),
                            maxLength: 50,
                            decoration: InputDecoration(
                              hintText: S.current.enter_email,
                              counterText: '',
                              hintStyle: textNormal(
                                AppTheme.getInstance()
                                    .whiteWithOpacityFireZero(),
                                16,
                              ),
                              prefixIcon: ImageIcon(
                                const AssetImage(ImageAssets.ic_email),
                                color: AppTheme.getInstance().whiteColor(),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        StreamBuilder<String>(
                          stream: bloc.validateTextSubject,
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.data ?? '',
                              style: textNormal(
                                AppTheme.getInstance().wrongColor(),
                                12,
                              ).copyWith(fontWeight: FontWeight.w400),
                            );
                          },
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              if (bloc.checkWalletAddress) {
                                bloc.isChooseAcc.sink.add(true);
                              }
                            },
                            child: StreamBuilder<String>(
                              stream: bloc.textAddress,
                              builder: (context, snapshot) {
                                final String address =
                                    bloc.checkAddress(snapshot.data ?? '');
                                return Container(
                                  margin: EdgeInsets.only(
                                    bottom: 12.h,
                                  ),
                                  height: 64.h,
                                  width: 343.w,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.5.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        AppTheme.getInstance().itemBtsColors(),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.r),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            child: Image.asset(
                                              ImageAssets.ic_wallet,
                                              height: 20.67.h,
                                              width: 20.14.w,
                                            ),
                                          ),
                                          spaceW6,
                                          SizedBox(
                                            child: Text(
                                              address,
                                              style: textNormal(
                                                null,
                                                16,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        child: bloc.checkWalletAddress
                                            ? Image.asset(
                                                ImageAssets.ic_line_down,
                                                height: 20.67.h,
                                                width: 20.14.w,
                                              )
                                            : SizedBox(
                                                height: 20.67.h,
                                                width: 20.14.w,
                                              ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        spaceH24,
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                          ),
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              text: '',
                              style: textNormalCustom(
                                null,
                                14,
                                FontWeight.w500,
                              ),
                              children: [
                                WidgetSpan(
                                  child: Text(
                                    S.current.by_choosing_on_the,
                                    style: textNormalCustom(
                                      null,
                                      14,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    S.current.continue_pawn,
                                    style: textNormalCustom(
                                      AppTheme.getInstance().fillColor(),
                                      14,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    S.current.i_agree_with_the,
                                    style: textNormalCustom(
                                      null,
                                      14,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    S.current.terms_and_conditions,
                                    style: textNormalCustom(
                                      AppTheme.getInstance().blueColor(),
                                      14,
                                      FontWeight.w500,
                                    ).copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    ' ',
                                    style: textNormalCustom(
                                      null,
                                      14,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    S.current.condition,
                                    style: textNormalCustom(
                                      AppTheme.getInstance().blueColor(),
                                      14,
                                      FontWeight.w500,
                                    ).copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    ', ',
                                    style: textNormalCustom(
                                      null,
                                      14,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    S.current.payment_terms,
                                    style: textNormalCustom(
                                      AppTheme.getInstance().blueColor(),
                                      14,
                                      FontWeight.w500,
                                    ).copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    ', ',
                                    style: textNormalCustom(
                                      null,
                                      14,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    S.current.privacy_policy,
                                    style: textNormalCustom(
                                      AppTheme.getInstance().blueColor(),
                                      14,
                                      FontWeight.w500,
                                    ).copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    ' ',
                                    style: textNormalCustom(
                                      null,
                                      14,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    S.current.and,
                                    style: textNormalCustom(
                                      null,
                                      14,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    ' ',
                                    style: textNormalCustom(
                                      null,
                                      14,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    S.current.nondiscrimination_policy,
                                    style: textNormalCustom(
                                      AppTheme.getInstance().blueColor(),
                                      14,
                                      FontWeight.w500,
                                    ).copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: Text(
                                    ' ${S.current.of_de_fi_for_you}',
                                    style: textNormalCustom(
                                      null,
                                      14,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: Column(
                        children: [
                          Text(
                            S.current.we_ll_also_send_you_special_we,
                            style: textNormalCustom(
                              null,
                              14,
                              FontWeight.w500,
                            ),
                          ),
                          spaceH15,
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: textNormalCustom(
                                AppTheme.getInstance().whiteColor(),
                                14,
                                FontWeight.w400,
                              ),
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: StreamBuilder<bool>(
                                    initialData: true,
                                    stream: bloc.isCheckBox,
                                    builder: (context, snapshot) {
                                      return SizedBox(
                                        width: 24.w,
                                        height: 24.h,
                                        child: Transform.scale(
                                          scale: 1.34.sp,
                                          child: Checkbox(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                            ),
                                            fillColor:
                                                MaterialStateProperty.all(
                                              AppTheme.getInstance()
                                                  .fillColor(),
                                            ),
                                            activeColor: AppTheme.getInstance()
                                                .activeColor(),
                                            onChanged: (value) {
                                              bloc.isCheckBox.sink
                                                  .add(value ?? false); //todo.
                                            },
                                            value: snapshot.data ?? false,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                WidgetSpan(
                                  child: spaceW16,
                                ),
                                TextSpan(
                                  text: S.current.i_don_t_want_to_receive,
                                ),
                              ],
                            ),
                          ),
                          spaceH152,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 230.h,
            child: StreamBuilder<bool>(
              initialData: false,
              stream: bloc.isChooseAcc,
              builder: (ctx, snapshot) {
                return Visibility(
                  visible: snapshot.data ?? false,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().colorTextReset(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                    ),
                    width: 343.w,
                    height: 123.h,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: bloc.listAcc.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            bloc.chooseAddressFilter(bloc.listAcc[index]);
                          },
                          child: Container(
                            height: 54.h,
                            padding: EdgeInsets.only(
                              left: 24.w,
                              top: 15.h,
                            ),
                            color:
                                bloc.listAcc[index] == bloc.textAddress.value
                                    ? AppTheme.getInstance()
                                        .whiteColor()
                                        .withOpacity(0.3)
                                    : Colors.transparent,
                            child: Text(
                              bloc.checkAddress(
                                bloc.listAcc[index],
                              ),
                              style: textNormalCustom(null, 16, null),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: StreamBuilder<bool>(
              stream: bloc.isBtn,
              builder: (context, snapshot) {
                return GestureDetector(
                  onTap: () async {
                    goTo(
                      context,
                      const LedingRegistrationAccept(),
                    );//todo
                    if (snapshot.data ?? false) {
                      goTo(
                        context,
                        const LedingRegistrationAccept(),
                      );
                    }
                  },
                  child: Container(
                    color: AppTheme.getInstance().bgBtsColor(),
                    padding: EdgeInsets.only(
                      bottom: 38.h,
                    ),
                    child: ButtonGold(
                      isEnable: snapshot.data ?? false,
                      title: S.current.continue_pawn,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
