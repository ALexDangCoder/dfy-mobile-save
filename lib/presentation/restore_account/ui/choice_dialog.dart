import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/restore_account/bloc/restore_cubit.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChoiceDialog extends StatefulWidget {
  ChoiceDialog({
    Key? key,
    required this.cubit,
    required this.controller1,
    required this.controller2,
  }) : super(key: key);
  final RestoreCubit cubit;
  final TextEditingController controller1;
  final TextEditingController controller2;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<ChoiceDialog> {
  @override
  Widget build(BuildContext context) {
    final RestoreCubit _cubit = widget.cubit;
    return Container(
      height: 124.h,
      width: 343.w,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().selectDialogColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          InkWell(
            onTap: () {
              if (_cubit.type != FormType.PASS_PHRASE) {
                _cubit.stringSink.add(S.current.seed_phrase);
                _cubit.typeSink.add(FormType.PASS_PHRASE);
                _cubit.listStringSink.add(
                  [S.current.restore_with_seed, S.current.only_first],
                );
                _cubit.matchSink.add(false);
                _cubit.validateSink.add(false);
                _cubit.seedSink.add(false);
                _cubit.ckcSink.add(true);
                widget.controller2.clear();
              }
              _cubit.boolSink.add(false);
            },
            child: Container(
              margin: EdgeInsets.only(left: 24.w),
              height: 44.h,
              width: 343.w,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.current.seed_phrase,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16,
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
              if (_cubit.type != FormType.PRIVATE_KEY) {
                _cubit.stringSink.add(S.current.private_key);
                _cubit.typeSink.add(FormType.PRIVATE_KEY);
                _cubit.listStringSink.add(
                  [S.current.restore_with_private],
                );
                _cubit.matchSink.add(false);
                _cubit.validateSink.add(false);
                _cubit.ckcSink.add(true);
                _cubit.seedSink.add(false);
                widget.controller1.clear();
              }
              _cubit.boolSink.add(false);
            },
            child: Container(
              margin: EdgeInsets.only(left: 24.w),
              height: 44.h,
              width: 343.w,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.current.private_key,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16,
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
