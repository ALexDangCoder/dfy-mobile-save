import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/request/pawn/review_create_request.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/pawn/contract_detail_pawn.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/contract_detail.dart';
import 'package:Dfy/presentation/pawn/review_borrower/bloc/review_borrower_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReviewBorrower extends StatefulWidget {
  const ReviewBorrower({
    Key? key,
    required this.type,
    required this.objDetail,
    required this.typeBorrow,
  }) : super(key: key);
  final TypeNavigator type;
  final TypeBorrow typeBorrow;
  final ContractDetailPawn objDetail;

  @override
  _ReviewBorrowerState createState() => _ReviewBorrowerState();
}

class _ReviewBorrowerState extends State<ReviewBorrower> {
  late ReviewBorrowerBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ReviewBorrowerBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      backgroundColor: Colors.transparent,
      title: S.current.review_borrower,
      text: ImageAssets.ic_close,
      onRightClick: () {
        Navigator.pop(context);
      },
      isImage: true,
      child: Stack(
        children: [
          Container(
            height: 812.h,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceH24,
                  Container(
                    width: 343.w,
                    padding: EdgeInsets.only(
                      left: 16.w,
                      bottom: 4.h,
                      right: 16.w,
                      top: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().borderItemColor(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                      border: Border.all(
                        color: AppTheme.getInstance().divideColor(),
                      ),
                    ),
                    child: Column(
                      children: [
                        StreamBuilder<int>(
                          stream: bloc.rateNumber,
                          builder: (context, snapshot) {
                            final rate = snapshot.data ?? 0;
                            return SizedBox(
                              height: 50.h,
                              child: ListView.builder(
                                itemCount: 5,
                                itemExtent: 60.w,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    bloc.rateNumber.add(index);
                                  },
                                  child: rate >= index
                                      ? Image.asset(
                                          ImageAssets.img_rate,
                                          height: 48.h,
                                          width: 48.w,
                                        )
                                      : Image.asset(
                                          ImageAssets.img_rate2,
                                          height: 48.h,
                                          width: 48.w,
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                        spaceH27,
                        Text(
                          S.current.tap_to_review,
                          style: textNormalCustom(
                            AppTheme.getInstance().gray3Color(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  spaceH32,
                  Padding(
                    padding: EdgeInsets.only(
                      right: 16.w,
                    ),
                    child: Text(
                      S.current.your_comment,
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceH4,
                  Container(
                    width: 343.w,
                    height: 148.h,
                    padding: EdgeInsets.only(
                      left: 16.w,
                      bottom: 16.h,
                      right: 16.w,
                      top: 16.h,
                    ),
                    margin: EdgeInsets.only(
                      bottom: 35.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().backgroundBTSColor(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      cursorColor: AppTheme.getInstance().whiteColor(),
                      style: textNormal(
                        AppTheme.getInstance().whiteColor(),
                        16,
                      ),
                      onChanged: (value) {
                        bloc.note.add(value);
                      },
                      maxLines: 8,
                      maxLength: 150,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isCollapsed: true,
                        counterText: '',
                        hintText: S.current.enter_your_comment,
                        hintStyle: textNormal(
                          Colors.white.withOpacity(0.5),
                          16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
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
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    fillColor: MaterialStateProperty.all(
                                      AppTheme.getInstance().fillColor(),
                                    ),
                                    activeColor:
                                        AppTheme.getInstance().activeColor(),
                                    // checkColor: const Colors,
                                    onChanged: (value) {
                                      bloc.isCheckBox.sink.add(value ?? false);
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
                          text: S.current.please_do_not_show_again,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                color: AppTheme.getInstance().bgBtsColor(),
                padding: EdgeInsets.only(
                  bottom: 16.h,
                ),
                width: 343.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        PrefsService.savePleaseRate(
                          bloc.isCheckBox.value.toString(),
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 64.h,
                        width: 159.w,
                        decoration: BoxDecoration(
                          color: AppTheme.getInstance().borderItemColor(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.r),
                          ),
                          border: Border.all(
                            color: AppTheme.getInstance().fillColor(),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            S.current.skip_review,
                            style: textNormalCustom(
                              AppTheme.getInstance().fillColor(),
                              20,
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final NavigatorState navigator = Navigator.of(context);
                        await bloc.getHexString(
                          bcContractAddress: widget
                                  .objDetail.contractTerm?.walletAddress
                                  .toString() ??
                              '',
                          bcContractId:
                              widget.objDetail.bcContractId.toString(),
                          typeBorrow: widget.typeBorrow,
                        );
                        unawaited(
                          navigator.push(
                            MaterialPageRoute(
                              builder: (context) => Approve(
                                textActiveButton:
                                    '${S.current.confirm} ${S.current.add_more_collateral.toLowerCase()}',
                                spender: Get.find<AppConstants>()
                                    .crypto_pawn_contract,
                                hexString: bloc.hexString,
                                tokenAddress:
                                    Get.find<AppConstants>().contract_defy,
                                title: S.current.confirm_send_offer,
                                listDetail: [],
                                onErrorSign: (context) {},
                                onSuccessSign: (context, data) {
                                  bloc.postReview(
                                    reviewCreateRequest: ReviewCreateRequest(
                                      contractId: widget.objDetail.bcContractId,
                                      type: widget.type ==
                                              TypeNavigator.BORROW_TYPE
                                          ? 0
                                          : 1,
                                      content: bloc.note.value,
                                      point: bloc.rateNumber.value,
                                      reviewee: ReviewerRequest(
                                        id: widget.objDetail.lenderUserId,
                                        walletAddress: widget
                                            .objDetail.lenderWalletAddress,
                                      ),
                                      reviewer: ReviewerRequest(
                                        id: widget.objDetail.borrowerUserId,
                                        walletAddress: widget
                                            .objDetail.borrowerWalletAddress,
                                      ),
                                    ),
                                  );
                                  showLoadSuccess(context).then((value) {
                                    Navigator.of(context).popUntil((route) {
                                      return route.settings.name ==
                                          AppRouter.contract_detail_my_acc;
                                    });
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                        await PrefsService.savePleaseRate(
                          bloc.isCheckBox.value.toString(),
                        );
                      },
                      child: SizedBox(
                        width: 159.w,
                        child: ButtonGold(
                          isEnable: true,
                          fixSize: false,
                          haveMargin: false,
                          title: S.current.review_claim_reward,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
