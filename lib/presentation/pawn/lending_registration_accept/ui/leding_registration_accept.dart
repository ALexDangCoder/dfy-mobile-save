import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/add_more_collateral/ui/add_more_collateral.dart';
import 'package:Dfy/presentation/pawn/lending_registration_accept/bloc/leding_registration_accpet_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    bloc = LendingRegistrationAcceptBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().bgBtsColor(),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Scaffold(
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
                        top: MediaQuery.of(context).padding.top),
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().bgBtsColor(),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.h),
                        topRight: Radius.circular(30.h),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          spaceH24,
                          FormInputBase(
                            title: S.current.and,
                            hintText: S.current.and,
                            validateFun: (value) {
                              return 'hahahah';
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
                    },
                    child: Container(
                      color: AppTheme.getInstance().bgBtsColor(),
                      child: ButtonGold(
                        isEnable: snapshot.data ?? false,
                        title: S.current.create_collateral,
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
