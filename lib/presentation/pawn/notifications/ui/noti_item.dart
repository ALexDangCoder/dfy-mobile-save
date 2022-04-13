import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/pawn/notification.dart';
import 'package:Dfy/presentation/pawn/borrow_result/ui/borrow_result.dart';
import 'package:Dfy/presentation/pawn/collateral_detail/ui/collateral_detail.dart';
import 'package:Dfy/presentation/pawn/collateral_detail_my_acc/ui/collateral_detail_my_acc.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/contract_detail.dart';
import 'package:Dfy/presentation/pawn/loan_package_detail/ui/loan_package_detail.dart';
import 'package:Dfy/presentation/pawn/notifications/cubit/notifications_cubit.dart';
import 'package:Dfy/presentation/pawn/offer_detail/ui/offer_detail_my_acc.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/view_other_profile.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/pawn_list.dart';
import 'package:Dfy/presentation/pawn/personal_lending/ui/personal_lending_screen.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NotiItem extends StatefulWidget {
  const NotiItem({
    Key? key,
    required this.cubit,
    required this.notificationDetail,
    required this.index,
  }) : super(key: key);

  final NotificationsCubit cubit;
  final NotificationDetail notificationDetail;
  final int index;

  @override
  _NotiItemState createState() => _NotiItemState();
}

class _NotiItemState extends State<NotiItem> {
  bool _customTileExpanded = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 3,
            onPressed: (context) {
              if (widget.notificationDetail.isRead == false) {
                widget.cubit.updateNoti(widget.notificationDetail.id);
                widget.notificationDetail.isRead = true;
                setState(() {});
              }
            },
            spacing: 6.r,
            backgroundColor: Colors.white.withOpacity(0.2),
            foregroundColor: Colors.white,
            label: 'Mark as read',
          ),
          SlidableAction(
            flex: 2,
            spacing: 4.r,
            onPressed: (context) {
              widget.cubit.listNotificationDetail.removeAt(widget.index);
              widget.cubit.delete.add('delete');
            },
            backgroundColor: redMarketColor.withOpacity(0.2),
            foregroundColor: redMarketColor,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          if (widget.notificationDetail.isRead == false) {
            widget.cubit.updateNoti(widget.notificationDetail.id);
            widget.notificationDetail.isRead = true;
            setState(() {});
          }
          setState(() {
            _customTileExpanded = !_customTileExpanded;
          });
        },
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 8.h,
                  width: 8.w,
                  decoration: BoxDecoration(
                    color: !(widget.notificationDetail.isRead ?? false)
                        ? successTransactionColor
                        : grey3,
                    shape: BoxShape.circle,
                  ),
                ),
                spaceW4,
                Text(
                  getTitle(
                    widget.notificationDetail.txType ?? 0,
                    widget.notificationDetail.userType ?? 0,
                  ),
                  style: textNormalCustom(
                    Colors.white,
                    16,
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
            spaceH8,
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getDetail(
                    widget.notificationDetail.txType ?? 0,
                    widget.notificationDetail.userType ?? 0,
                  ),
                  spaceH10,
                  Row(
                    children: [
                      Text(
                        formatDateTime3.format(
                          DateTime.fromMillisecondsSinceEpoch(
                            widget.notificationDetail.createAt ?? 0,
                          ),
                        ),
                        style: textNormalCustom(
                          Colors.white.withOpacity(0.5),
                          14,
                          FontWeight.w400,
                        ),
                      ),
                      spaceW10,
                      Icon(
                        _customTileExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        size: 24.sp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTitle(int txType, int userType) {
    switch (txType) {
      case 1:
        return 'Create collateral successfully';
      case 2:
        if (userType == 1) {
          return 'Submit collateral successfully';
        } else {
          return 'Review a collateral';
        }
      case 3:
        if (userType == 1) {
          return 'Submit collateral successfully';
        } else {
          return 'Review a collateral';
        }
      case 4:
        return 'Withdraw collateral successfully';
      case 5:
        if (userType == 1) {
          return 'Receive a loan offer';
        } else {
          return 'Send loan offer';
        }
      case 6:
        return 'Create loan package';
      case 7:
        return 'Cancel loan package successfully';
      case 8:
        return 'Re-open loan package';
      case 9:
        return 'New loan contract generated';
      case 10:
        return 'New loan contract generated';
      case 11:
        return 'New loan contract generated';
      case 12:
        return 'Loan request rejected';
      case 13:
        return 'Loan offer rejected';
      case 14:
        return 'Loan due payment';
      case 15:
        return 'Partial loan payment';
      case 16:
        return 'Period loan payment complete';
      case 17:
        return 'Your loan is due soon';
      case 18:
        return 'Urgent: Your loan is due soon';
      case 19:
        return 'Urgent: You current LTV is about to reach LTV liquidate threshold';
      case 20:
        return 'Add more collateral';
      case 21:
        return 'Borrow contract liquidated';
      case 22:
        return 'Borrow contract completed';
      case 23:
        return 'Review received';
      case 24:
        return 'Review received';
      case 25:
        return 'Request KYC';
      case 26:
        return 'Approve KYC';
      case 27:
        return 'Reject KYC';
      case 28:
        return 'Login new IP';
      case 29:
        return 'Create Pawnshop';
      case 30:
        return 'Connect to new wallet';
      case 31:
        return 'Disconnect wallet';
      case 32:
        return 'Create new account';
      default:
        return '';
    }
  }

  Widget getDetail(int txType, int userType) {
    switch (txType) {
      case 1:
        return RichText(
          maxLines: _customTileExpanded ? 2 : 5,
          text: TextSpan(
            children: [
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.amount} ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.cryptoAsset}',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: ' has been set as collateral.Submit loan request at',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: ' Loan package',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(context, const PawnList());
                  },
                style: richTextOrange,
              ),
              TextSpan(
                text: ' or ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: ' personal lending',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(context, const PersonalLendingScreen());
                  },
                style: richTextOrange,
              ),
              TextSpan(
                text: '\n\nView your collateral',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      CollateralDetailMyAccScreen(
                        id: widget.notificationDetail.notiDTO?.collateralNotiDTO
                                ?.idCollateral
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
            ],
          ),
        );
      case 2:
        if (userType == 1) {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Submit collateral successfully to ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.packageNotiDTO?.namePackage}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        LoanPackageDetail(
                          packageType: 0,
                          packageId: widget.notificationDetail.notiDTO
                                  ?.packageNotiDTO?.idPackage
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: '. Find more chances to submit your collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: 'here',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(context, const BorrowResult());
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: '\n\nView your collateral',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You receive a collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.nameCollateral}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        LoanPackageDetail(
                          packageType: 0,
                          packageId: widget.notificationDetail.notiDTO
                                  ?.packageNotiDTO?.idPackage
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: ' to ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.packageNotiDTO?.namePackage}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        LoanPackageDetail(
                          packageType: 0,
                          packageId: widget.notificationDetail.notiDTO
                                  ?.packageNotiDTO?.idPackage
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: '.Click ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: 'here',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ///goTo(context, const BorrowResult());
                      /// TODO go to list my collateral
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: ' to view all collateral send to you.',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
              ],
            ),
          );
        }
      case 3:
        if (userType == 1) {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Submit collateral successfully to ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.packageNotiDTO?.namePackage}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        OtherProfile(
                          userId: widget.notificationDetail.notiDTO
                                  ?.packageNotiDTO?.idUser
                                  .toString() ??
                              '',
                          pageRouter: PageRouter.MARKET,
                          index: 1,
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: '. Find more chances to submit your collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: 'here',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(context, const BorrowResult());
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: '\n\nView your collateral',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You receive a collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.nameCollateral}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        LoanPackageDetail(
                          packageType: 0,
                          packageId: widget.notificationDetail.notiDTO
                                  ?.packageNotiDTO?.idPackage
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: '.Click ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: 'here',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ///goTo(context, const BorrowResult());
                      /// TODO go to list loan request
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: ' to view all collateral send to you.',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
              ],
            ),
          );
        }
      case 4:
        return RichText(
          maxLines: _customTileExpanded ? 2 : 5,
          text: TextSpan(
            children: [
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.amount} ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.cryptoAsset}',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    ' has been withdraw to your wallet. You will not receive any offer from this collateral.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: '\n\nCreate new collateral',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // goTo(
                    //   context,
                    //   CollateralDetailMyAccScreen(
                    //     id: widget.notificationDetail.notiDTO
                    //         ?.collateralNotiDTO?.idCollateral
                    //         .toString() ??
                    //         '',
                    //   ),
                    // );
                    /// TODO goto create new collateral
                  },
                style: richTextOrange,
              ),
            ],
          ),
        );
      case 5:
        if (userType == 1) {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You received an offer to your collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.nameCollateral}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: '.Find more chances to submit your collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: 'here',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(context, const BorrowResult());
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: '\n\nView list offer',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You have sent offer ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.offerNotiDTO?.nameOffer}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        OfferDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO?.offerNotiDTO
                                  ?.idOffer
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: ' to the collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.nameCollateral}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        }
      case 6:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'You have created a package ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.packageNotiDTO?.namePackage}',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      LoanPackageDetail(
                        packageType: 0,
                        packageId: widget.notificationDetail.notiDTO
                                ?.packageNotiDTO?.idPackage
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
              TextSpan(
                text: '.Collateral can be sent to this package.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: '\n\nClick',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: ' here ',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      LoanPackageDetail(
                        packageType: 0,
                        packageId: widget.notificationDetail.notiDTO
                                ?.packageNotiDTO?.idPackage
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
              TextSpan(
                text: 'to view loan package detail.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
            ],
          ),
        );
      case 7:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'You have cancel a loan package ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.packageNotiDTO?.namePackage}',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      LoanPackageDetail(
                        packageType: 0,
                        packageId: widget.notificationDetail.notiDTO
                                ?.packageNotiDTO?.idPackage
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
              TextSpan(
                text: '.Collateral can not be sent to this package.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: '\n\nClick',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: ' here ',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      LoanPackageDetail(
                        packageType: 0,
                        packageId: widget.notificationDetail.notiDTO
                                ?.packageNotiDTO?.idPackage
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
              TextSpan(
                text: 'to view loan package detail.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
            ],
          ),
        );
      case 8:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'You have re-opened a loan package ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.packageNotiDTO?.namePackage}',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      LoanPackageDetail(
                        packageType: 0,
                        packageId: widget.notificationDetail.notiDTO
                                ?.packageNotiDTO?.idPackage
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
              TextSpan(
                text: '.Collateral can be sent to this package.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: '\n\nClick',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: ' here ',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      LoanPackageDetail(
                        packageType: 0,
                        packageId: widget.notificationDetail.notiDTO
                                ?.packageNotiDTO?.idPackage
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
              TextSpan(
                text: 'to view loan package detail.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
            ],
          ),
        );
      case 9:
        if (userType == 1) {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Send collateral',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.nameCollateral}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: ' successfully to ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.packageNotiDTO?.namePackage},',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        LoanPackageDetail(
                          packageType: 0,
                          packageId: widget.notificationDetail.notiDTO
                                  ?.packageNotiDTO?.idPackage
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: 'Follow your interest payment schedule',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: ' here',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        ContractDetail(
                          id: widget.notificationDetail.notiDTO?.contractNotiDTO
                                  ?.idContract ??
                              0,
                          type: TypeBorrow.CRYPTO_TYPE,
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Collateral',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      ' ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.amount} ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.cryptoAsset}',
                  style: richTextOrange,
                ),
                TextSpan(
                  text: ' has been sent to your package',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.packageNotiDTO?.namePackage},',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        LoanPackageDetail(
                          packageType: 0,
                          packageId: widget.notificationDetail.notiDTO
                                  ?.packageNotiDTO?.idPackage
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: 'new loan contract has been generated.',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '\n\nView your contract',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        ContractDetail(
                          id: widget.notificationDetail.notiDTO?.contractNotiDTO
                                  ?.idContract ??
                              0,
                          type: TypeBorrow.CRYPTO_TYPE,
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        }
      case 10:
        if (userType == 1) {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You have accepted an offer ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      ' ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.amount} ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.cryptoAsset}',
                  style: richTextOrange,
                ),
                TextSpan(
                  text: ' for collateral',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.nameCollateral},',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text:
                      'new loan contract has been generated. Follow your interest payment schedule',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: 'here',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        ContractDetail(
                          id: widget.notificationDetail.notiDTO?.contractNotiDTO
                                  ?.idContract ??
                              0,
                          type: TypeBorrow.CRYPTO_TYPE,
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Offer ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.offerNotiDTO?.nameOffer}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        OfferDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO?.offerNotiDTO
                                  ?.idOffer
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: ' has been accepted.',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '\n\nView your contract',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        ContractDetail(
                          id: widget.notificationDetail.notiDTO?.contractNotiDTO
                                  ?.idContract ??
                              0,
                          type: TypeBorrow.CRYPTO_TYPE,
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        }
      case 11:
        if (userType == 1) {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Your collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.nameCollateral}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: 'has been accepted from package ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.packageNotiDTO?.namePackage},',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        LoanPackageDetail(
                          packageType: 0,
                          packageId: widget.notificationDetail.notiDTO
                                  ?.packageNotiDTO?.idPackage
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text:
                      'new loan contract has been generated. Follow your interest payment schedule ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: 'here',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        ContractDetail(
                          id: widget.notificationDetail.notiDTO?.contractNotiDTO
                                  ?.idContract ??
                              0,
                          type: TypeBorrow.CRYPTO_TYPE,
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You have accepted a collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      ' ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.amount} ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.cryptoAsset}',
                  style: richTextOrange,
                ),
                TextSpan(
                  text: ' sent to your package ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.packageNotiDTO?.namePackage},',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        LoanPackageDetail(
                          packageType: 0,
                          packageId: widget.notificationDetail.notiDTO
                                  ?.packageNotiDTO?.idPackage
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: '\n\nView your contract',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        ContractDetail(
                          id: widget.notificationDetail.notiDTO?.contractNotiDTO
                                  ?.idContract ??
                              0,
                          type: TypeBorrow.CRYPTO_TYPE,
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        }
      case 12:
        if (userType == 1) {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Your collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.nameCollateral}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: ' sent to package ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.packageNotiDTO?.namePackage},',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        LoanPackageDetail(
                          packageType: 0,
                          packageId: widget.notificationDetail.notiDTO
                                  ?.packageNotiDTO?.idPackage
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: 'has been rejected. Find more chances to borrow ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: 'here',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(context, const BorrowResult());
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You have rejected collateral',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.nameCollateral}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: ' from ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.packageNotiDTO?.namePackage}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        LoanPackageDetail(
                          packageType: 1,
                          packageId: widget.notificationDetail.notiDTO
                                  ?.packageNotiDTO?.idPackage
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: '.Click ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: 'here',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ///goTo(context, const BorrowResult());
                      /// TODO go to list my collateral
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: ' to view all collateral send to you.',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
              ],
            ),
          );
        }
      case 13:
        if (userType == 1) {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You have rejected  ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.offerNotiDTO?.nameOffer}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: '.Find more chances to submit your collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: 'here',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(context, const BorrowResult());
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Your offer ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.offerNotiDTO?.nameOffer}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        OfferDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO?.offerNotiDTO
                                  ?.idOffer
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: ' sent to collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.nameCollateral}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
                TextSpan(
                  text: ' has been rejected',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
              ],
            ),
          );
        }
      case 14:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Due date: ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.repaymentNotiDTO?.dueDate}',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '.If you do not fully repay the interest before the due date, the payment period will be marked as late payment.'
                    ' If you made 3 times late payment, your contract will be liquidated.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: '\n\nRepay now',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      CollateralDetailMyAccScreen(
                        id: widget.notificationDetail.notiDTO?.collateralNotiDTO
                                ?.idCollateral
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
            ],
          ),
        );
      case 15:
        if (userType == 1) {
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Remaining due date: ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.repaymentNotiDTO?.dueDate}',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '.If you do not fully repay the interest before the due date, the payment period will be marked as late payment.'
                      ' If you made 3 times late payment, your contract will be liquidated.',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '\n\nRepay now',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You received the amount from loan contract. TXN hash:',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.repaymentNotiDTO?.txnHash}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_TX +
                            (widget.notificationDetail.notiDTO?.repaymentNotiDTO
                                    ?.txnHash ??
                                ''),
                      );
                    },
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '\n\nView contract',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        }
      case 16:
        if (userType == 1) {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'TXN hash ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.repaymentNotiDTO?.txnHash}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_TX +
                            (widget.notificationDetail.notiDTO?.repaymentNotiDTO
                                    ?.txnHash ??
                                ''),
                      );
                    },
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '.Next due date of loan period: ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.repaymentNotiDTO?.dueDate}',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '\n\nView contract',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You received the amount from loan contract. TXN hash:',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.repaymentNotiDTO?.txnHash}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_TX +
                            (widget.notificationDetail.notiDTO?.repaymentNotiDTO
                                    ?.txnHash ??
                                ''),
                      );
                    },
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '\n\nView contract',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        }
      case 17:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'You have a loan contract that is due for repayment.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: '\n\nRepay now',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      CollateralDetailMyAccScreen(
                        id: widget.notificationDetail.notiDTO?.collateralNotiDTO
                                ?.idCollateral
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
            ],
          ),
        );
      case 18:
        final String date = widget.notificationDetail.notiDTO?.repaymentNotiDTO?.dueDate ?? '0';
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text:
                    'You have a loan contract thai is due for repayment, due date: ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    formatDateTime.format(DateTime.fromMillisecondsSinceEpoch(int.parse(date))),
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '.If you do not pay the loan, your loan contract will be liquidated.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: '\n\nRepay now',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      CollateralDetailMyAccScreen(
                        id: widget.notificationDetail.notiDTO?.collateralNotiDTO
                                ?.idCollateral
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
            ],
          ),
        );
      case 19:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'CurrentLTV = ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.contractNotiDTO?.ltvCurrent}',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: ', LTV liquidation threshold = ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.contractNotiDTO?.ltvLiquidation}',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '. Please repay a part of your loan or depositing more collateral. This action will ensure LTV index will be in safe zone.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: '\n\nView your contract',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      CollateralDetailMyAccScreen(
                        id: widget.notificationDetail.notiDTO?.collateralNotiDTO
                                ?.idCollateral
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
            ],
          ),
        );
      case 20:
        if (userType == 1) {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.amount} ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.cryptoAsset}',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      ' as collateral has been added into the contract. Current LTV = ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.contractNotiDTO?.ltvCurrent}',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '\n\nView your contract',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.amount} ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.cryptoAsset}',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      ' as collateral has been added into the contract by the borrower. Current LTV = ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.contractNotiDTO?.ltvCurrent}',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '\n\nView your contract',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        }
      case 21:
        if (userType == 1) {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Default reason ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.contractNotiDTO?.reason}',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '. Your collateral has been transferred to lender`s wallet.TXN hash ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.repaymentNotiDTO?.txnHash}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_TX +
                            (widget.notificationDetail.notiDTO?.repaymentNotiDTO
                                    ?.txnHash ??
                                ''),
                      );
                    },
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '\n\nView your contract',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Default reason ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.contractNotiDTO?.reason}.',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.amount} ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.cryptoAsset} ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      ' as collateral has been liquidated. You received 80% of collateral '
                      '(20% value of the collateral is collected as a system maintenance fee). TXN hash',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.repaymentNotiDTO?.txnHash}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_TX +
                            (widget.notificationDetail.notiDTO?.repaymentNotiDTO
                                    ?.txnHash ??
                                ''),
                      );
                    },
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '\n\nView your contract',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        }
      case 22:
        if (userType == 1) {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You received back your collateral ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.amount} ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.cryptoAsset} ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '.TXN hash ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.repaymentNotiDTO?.txnHash}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_TX +
                            (widget.notificationDetail.notiDTO?.repaymentNotiDTO
                                    ?.txnHash ??
                                ''),
                      );
                    },
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '\n\nView your contract',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        } else {
          return RichText(
            maxLines: _customTileExpanded ? 2 : 5,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You received back your collateral lent loan amount ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.collateralNotiDTO?.amount} ${widget.notificationDetail.notiDTO?.collateralNotiDTO?.cryptoAsset} ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '.TXN hash ',
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.notificationDetail.notiDTO?.repaymentNotiDTO?.txnHash}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_TX +
                            (widget.notificationDetail.notiDTO?.repaymentNotiDTO
                                    ?.txnHash ??
                                ''),
                      );
                    },
                  style: textNormal(
                    textHistory,
                    14,
                  ),
                ),
                TextSpan(
                  text: '\n\nView your contract',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      goTo(
                        context,
                        CollateralDetailMyAccScreen(
                          id: widget.notificationDetail.notiDTO
                                  ?.collateralNotiDTO?.idCollateral
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                  style: richTextOrange,
                ),
              ],
            ),
          );
        }
      case 23:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Point: ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.reviewNotiDTO?.points}*,',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: ' comment:',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.reviewNotiDTO?.points}',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: ' from',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.reviewNotiDTO?.nameReviewer}',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      OtherProfile(
                        userId: widget.notificationDetail.notiDTO
                                ?.packageNotiDTO?.idUser
                                .toString() ??
                            '',
                        pageRouter: PageRouter.MARKET,
                        index: 1,
                      ),
                    );
                  },
                style: richTextOrange,
              ),
              TextSpan(
                text: '\n\nView your contract',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      CollateralDetailMyAccScreen(
                        id: widget.notificationDetail.notiDTO?.collateralNotiDTO
                                ?.idCollateral
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
            ],
          ),
        );
      case 24:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Point: ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.reviewNotiDTO?.points}*,',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: ' comment:',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.reviewNotiDTO?.points}',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: ' from',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text:
                    '${widget.notificationDetail.notiDTO?.reviewNotiDTO?.nameReviewer}',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      OtherProfile(
                        userId: widget.notificationDetail.notiDTO
                                ?.packageNotiDTO?.idUser
                                .toString() ??
                            '',
                        pageRouter: PageRouter.MARKET,
                        index: 0,
                      ),
                    );
                  },
                style: richTextOrange,
              ),
              TextSpan(
                text: '\n\nView your contract',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    goTo(
                      context,
                      CollateralDetailMyAccScreen(
                        id: widget.notificationDetail.notiDTO?.collateralNotiDTO
                                ?.idCollateral
                                .toString() ??
                            '',
                      ),
                    );
                  },
                style: richTextOrange,
              ),
            ],
          ),
        );
      case 25:
      case 26:
      case 27:
      case 28:
      case 29:
      case 30:
      case 31:
      case 32:
      default:
        return const SizedBox();
    }
  }
}
