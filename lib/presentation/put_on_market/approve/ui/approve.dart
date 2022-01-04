import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/wallet_view_approve/ui/wallet_view_approve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Approve extends StatefulWidget {
  final String title;
  final List<DetailItemApproveModel>? listDetail;
  final Widget? warning;

  const Approve({Key? key, required this.title, this.listDetail, this.warning})
      : super(key: key);

  @override
  _ApproveState createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 48),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              header(),
              Divider(
                thickness: 1,
                color: AppTheme.getInstance().divideColor(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...(widget.listDetail ?? []).map(
                              (item) =>
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          item.title,
                                          style: textNormal(
                                            AppTheme.getInstance()
                                                .whiteColor()
                                                .withOpacity(0.7),
                                            14.sp,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          item.value,
                                          style: item.isToken ?? false
                                              ? textNormalCustom(
                                            AppTheme.getInstance()
                                                .fillColor(),
                                            20.sp,
                                            FontWeight.w600,
                                          )
                                              : textNormal(
                                            AppTheme.getInstance()
                                                .whiteColor(),
                                            16.sp,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16)
                                ],
                              ),
                        ),
                        if (widget.warning != null) Column(
                          children: [
                            const SizedBox (height: 4),
                            widget.warning ??  const SizedBox (height : 0),
                            const SizedBox(height: 20),
                          ],
                        ) else const SizedBox (height :4),
                        Divider(
                          thickness: 1,
                          color: AppTheme.getInstance().divideColor(),
                        ),
                        const SizedBox(height: 16),
                        const WalletViewApprove()
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: ButtonGold(
                        title: S.current.continue_s,
                        isEnable: false,
                        fixSize: false,
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: ButtonGold(
                        fixSize: false,
                        title: S.current.continue_s,
                        isEnable: true,
                      ),
                      onTap: () {},
                    ),
                  )
                ],
              ),
              const SizedBox(height: 38)
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      height: 40,
      // height: 28.h,
      margin: const EdgeInsets.only(
        top: 16,
        // bottom: 20.h,
        left: 16,
        right: 16,
      ),
      // EdgeInsets.only(left: 0),
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.ic_back),
          ),
          Center(
            child: Text(
              widget.title,
              style: textNormal(AppTheme.getInstance().textThemeColor(), 20.sp)
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
