import 'dart:ui';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/widget/Copied.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/item_seedphrase/item_seedphrase.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BoxListPassWordPhraseShow extends StatefulWidget {
  final List<String> listTitle;
  final String text;

  const BoxListPassWordPhraseShow({
    Key? key,
    required this.listTitle,
    required this.text,
  }) : super(key: key);

  @override
  State<BoxListPassWordPhraseShow> createState() =>
      _BoxListPassWordPhraseShowState();
}

class _BoxListPassWordPhraseShowState extends State<BoxListPassWordPhraseShow> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 222.h,
        minWidth: 343.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().itemBtsColors(),
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
        ),
        margin: EdgeInsets.only(
          right: 16.w,
          left: 16.w,
          top: 16.h,
          bottom: 16.h,
        ),
        padding: EdgeInsets.only(
          top: 16.h,
          left: 13.w,
          right: 13.w,
          bottom: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.your_seed,
                  style: textNormal(
                    Colors.white,
                    16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FlutterClipboard.copy(widget.text);
                    fToast.showToast(
                      child: Copied(
                        title: S.current.copied_seed_phrase,
                      ),
                      gravity: ToastGravity.CENTER,
                      toastDuration: const Duration(
                        seconds: 2,
                      ),
                    );
                  },
                  child: Image.asset(
                    ImageAssets.ic_copy,
                    height: 20.h,
                    width: 20.14.w,
                    color: AppTheme.getInstance().fillColor(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 21.h,
            ),
            Wrap(
              spacing: 5.w,
              runSpacing: 12.h,
              children: List<Widget>.generate(
                widget.listTitle.length,
                (int index) {
                  return ItemSeedPhrase(
                    title: '${index + 1}. ${widget.listTitle[index]}',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
