import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/import_account_login_bts/bloc/import_cubit.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChoiceDialog extends StatefulWidget {
  const ChoiceDialog({
    Key? key,
    required this.cubit,
    required this.controller1,
    required this.controller2,
  }) : super(key: key);
  final ImportCubit cubit;
  final TextEditingController controller1;
  final TextEditingController controller2;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<ChoiceDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124.h,
      width: 323.w,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().selectDialogColor(),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          InkWell(
            onTap: () {
              widget.cubit.stringSink.add(S.current.seed_phrase);
              widget.cubit.typeSink.add(FormType.PASS_PHRASE);
              widget.cubit.listStringSink.add(
                [S.current.only_desc],
              );
              widget.controller1.clear();
              widget.cubit.boolSink.add(false);
            },
            child: Container(
              margin: EdgeInsets.only(left: 24.w),
              height: 44.h,
              width: 323.w,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.current.seed_phrase,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16.sp,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          InkWell(
            onTap: () {
              widget.cubit.stringSink.add(S.current.private_key);
              widget.cubit.typeSink.add(FormType.PRIVATE_KEY);
              widget.cubit.listStringSink.add(
                [S.current.imported],
              );
              widget.controller2.clear();
              widget.cubit.boolSink.add(false);
            },
            child: Container(
              margin: EdgeInsets.only(left: 24.w),
              height: 44.h,
              width: 323.w,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.current.private_key,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16.sp,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
