import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/home_pawn/send_to_loan_package_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemSendTo extends StatelessWidget {
  const ItemSendTo({
    Key? key,
    required this.obj,
  }) : super(key: key);
  final SendToLoanPackageModel obj;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 343.w,
        margin: EdgeInsets.only(
          bottom: 20.h,
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
        child: Container(
          margin: EdgeInsets.only(
            right: 16.w,
            left: 16.w,
            top: 18.h,
            bottom: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${S.current.name}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().pawnItemGray(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceW4,
                  Expanded(
                    flex: 6,
                    child: Text(
                      obj.name.toString(),
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              spaceH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${S.current.type}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().pawnItemGray(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceW4,
                  Expanded(
                    flex: 6,
                    child: Text(
                      "obj.description.toString()", //todo
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              spaceH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${S.current.date}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().pawnItemGray(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceW4,
                  Expanded(
                    flex: 6,
                    child: Text(
                      0.formatDateTimeMy(obj.createdAt ?? 0),
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
