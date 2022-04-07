import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/add_more_collateral/ui/add_more_collateral.dart';
import 'package:Dfy/presentation/pawn/lending_registration/ui/register_successfully_step.dart';
import 'package:Dfy/presentation/pawn/lending_registration_accept/bloc/leding_registration_accpet_bloc.dart';
import 'package:Dfy/presentation/pawn/lending_registration_accept/bloc/leding_registration_accpet_state.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'form_input_base.dart';

class LedingRegistrationAccept extends StatefulWidget {
  const LedingRegistrationAccept({Key? key}) : super(key: key);

  @override
  _LedingRegistrationAcceptState createState() =>
      _LedingRegistrationAcceptState();
}

class _LedingRegistrationAcceptState extends State<LedingRegistrationAccept> {
  late LendingRegistrationAcceptBloc bloc;
  late TextEditingController textPhoneController;
  late String phone;

  @override
  void initState() {
    super.initState();
    textPhoneController = TextEditingController();
    bloc = LendingRegistrationAcceptBloc();
    bloc.getPhonesApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          StateStreamLayout(
            error:
                AppException(S.current.error, S.current.something_went_wrong),
            retry: () {},
            stream: bloc.stateStream,
            textEmpty: '',
            child: Scaffold(
              backgroundColor: AppTheme.getInstance().bgBtsColor(),
              body: Container(
                color: AppTheme.getInstance().blackColor(),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      closeKey(context);
                    },
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          spaceH16,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 16.w),
                                  width: 24.w,
                                  height: 24.h,
                                  child: Image.asset(ImageAssets.ic_back),
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
                                  Navigator.of(context)
                                    ..pop()
                                    ..pop();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 16.w),
                                  width: 24.w,
                                  height: 24.h,
                                  child: Image.asset(ImageAssets.ic_close),
                                ),
                              ),
                            ],
                          ),
                          spaceH20,
                          line,
                          BlocBuilder<LendingRegistrationAcceptBloc,
                              LendingRegistrationAcceptState>(
                            bloc: bloc,
                            builder: (context, state) {
                              if (state is LendingRegistrationAcceptSuccess) {
                                phone = bloc.listPhone.first;
                                return Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        spaceH24,
                                        FormInputBase(
                                          isClose: true,
                                          title: S.current.name,
                                          hintText: S.current.enter_name,
                                          validateFun: (value) {
                                            return '';
                                          },
                                        ),
                                        spaceH24,
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                          ),
                                          child: Text(
                                            S.current.phone_num,
                                            style: textNormalCustom(
                                              null,
                                              16,
                                              FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        spaceH4,
                                        Container(
                                          height: 64.h,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppTheme.getInstance()
                                                .backgroundBTSColor(),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                20.r,
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                            child: TextFormField(
                                              controller: textPhoneController,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              cursorColor:
                                                  AppTheme.getInstance()
                                                      .whiteColor(),
                                              style: textNormal(
                                                AppTheme.getInstance()
                                                    .whiteColor(),
                                                16,
                                              ),
                                              decoration: InputDecoration(
                                                prefixIcon: Padding(
                                                  padding: EdgeInsets.only(
                                                    right: 10.w,
                                                  ),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButton<String>(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20.r),
                                                      ),
                                                      dropdownColor: AppTheme
                                                              .getInstance()
                                                          .backgroundBTSColor(),
                                                      items: bloc.listPhone
                                                          .map((String item) {
                                                        return DropdownMenuItem(
                                                          value: item,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Text(
                                                                item,
                                                                style:
                                                                    textNormal(
                                                                  Colors.white
                                                                      .withOpacity(
                                                                    0.5,
                                                                  ),
                                                                  16,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          phone = newValue
                                                              .toString();
                                                        });
                                                      },
                                                      value: phone,
                                                      icon: Image.asset(
                                                        ImageAssets
                                                            .ic_line_down,
                                                        height: 24.h,
                                                        width: 24.w,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                contentPadding: EdgeInsets.zero,
                                                isCollapsed: true,
                                                counterText: '',
                                                hintText:
                                                    S.current.enter_phone_num,
                                                hintStyle: textNormal(
                                                  AppTheme.getInstance()
                                                      .whiteWithOpacityFireZero(),
                                                  16,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        spaceH4,
                                        //todo validate phone
                                        spaceH24,
                                        FormInputBase(
                                          isClose: true,
                                          title: S.current.email,
                                          hintText: S.current.enter_email,
                                          validateFun: (value) {
                                            return '';
                                          },
                                        ),
                                        spaceH24,
                                        FormInputBase(
                                          isClose: true,
                                          title: S.current.address,
                                          hintText: S.current.enter_address,
                                          validateFun: (value) {
                                            return '';
                                          },
                                        ),
                                        spaceH24,
                                        FormInputBase(
                                          isClose: true,
                                          title: S.current.description,
                                          hintText: S.current.enter_description,
                                          validateFun: (value) {
                                            return '';
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(
                bottom: 38.h,
              ),
              color: AppTheme.getInstance().bgBtsColor(),
              child: StreamBuilder<bool>(
                stream: bloc.isCheckBtn,
                builder: (context, snapshot) {
                  return GestureDetector(
                    onTap: () async {
                      //todo
                      goTo(context, RegisterSuccessfullyStep());
                    },
                    child: Container(
                      color: AppTheme.getInstance().bgBtsColor(),
                      child: ButtonGold(
                        isEnable: snapshot.data ?? false,
                        title: S.current.accept_continue,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
