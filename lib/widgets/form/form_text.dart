import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/widget/Copied.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum TypeText { address, key }

class FromText extends StatefulWidget {
  final String urlPrefixIcon;
  final String title;
  final String urlSuffixIcon;
  final TypeText type;

  const FromText({
    Key? key,
    required this.urlPrefixIcon,
    required this.title,
    required this.urlSuffixIcon,
    required this.type,
  }) : super(key: key);

  @override
  State<FromText> createState() => _FromTextState();
}

class _FromTextState extends State<FromText> {
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 64.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 15.5.w, vertical: 23.h),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().itemBtsColors(),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                widget.urlPrefixIcon,
                height: 20.h,
                width: 20.14.w,
              ),
              SizedBox(
                width: 17.5.w,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  widget.title.formatAddressWalletConfirm(),
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              FlutterClipboard.copy(widget.title);
              fToast.showToast(
                child: Copied(
                  title: widget.type == TypeText.address
                      ? S.current.copied_address
                      : S.current.copied_private_key,
                ),
                gravity: ToastGravity.CENTER,
                toastDuration: const Duration(
                  seconds: 2,
                ),
              );
            },
            child: Container(
              child: widget.urlSuffixIcon.isNotEmpty
                  ? Image.asset(
                      widget.urlSuffixIcon,
                      height: 20.67.h,
                      width: 20.14.w,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
