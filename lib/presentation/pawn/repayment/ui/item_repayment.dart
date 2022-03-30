import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/offer_detail/ui/offer_detail_my_acc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

class ItemRepayment extends StatelessWidget {
  const ItemRepayment({
    Key? key,
    required this.title,
    required this.value,
    required this.symbol,
    required this.textController,
    required this.funText,
    required this.funMax,
    required this.isCheck,
    this.enabled = true,
  }) : super(key: key);
  final String title;
  final String value;
  final String symbol;
  final TextEditingController textController;
  final Function funText;
  final Function funMax;
  final bool enabled;
  final BehaviorSubject<String> isCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.only(
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: enabled
            ? AppTheme.getInstance().bgErrorLoad()
            : AppTheme.getInstance().bgBtsColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        border: Border.all(
          color: AppTheme.getInstance().divideColor(),
        ),
      ),
      padding: EdgeInsets.only(
        right: 16.w,
        left: 16.w,
        top: 16.h,
        bottom: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textNormalCustom(
              enabled
                  ? null
                  : AppTheme.getInstance().whiteWithOpacityFireZero(),
              20,
              FontWeight.w600,
            ),
          ),
          spaceH16,
          richText(
            opacityIcon: enabled ? 1 : 0.5,
            myColorTitle: enabled
                ? AppTheme.getInstance().whiteColor()
                : AppTheme.getInstance().whiteWithOpacityFireZero(),
            title: '$title:',
            value: value,
            isIcon: true,
            myColor: enabled
                ? AppTheme.getInstance().whiteColor()
                : AppTheme.getInstance().whiteWithOpacityFireZero(),
            url: ImageAssets.getUrlToken(symbol),
          ),
          spaceH16,
          Text(
            S.current.amount,
            style: textNormalCustom(
              enabled
                  ? null
                  : AppTheme.getInstance().whiteWithOpacityFireZero(),
              16,
              FontWeight.w400,
            ),
          ),
          spaceH16,
          Container(
            height: 64.h,
            padding: EdgeInsets.only(right: 15.w, left: 15.w),
            decoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,5}'),
                      ),
                    ],
                    enabled: enabled,
                    controller: textController,
                    maxLength: 50,
                    onChanged: (v) {
                      funText(v);
                    },
                    cursorColor: AppTheme.getInstance().whiteColor(),
                    style: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isCollapsed: true,
                      counterText: '',
                      hintText: S.current.enter_amount,
                      hintStyle: textNormal(
                        Colors.white.withOpacity(0.5),
                        16,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (enabled) funMax();
                      },
                      child: Text(
                        S.current.max,
                        style: textNormalCustom(
                          enabled
                              ? fillYellowColor
                              : fillYellowColor.withOpacity(0.5),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    spaceW10,
                    Row(
                      children: <Widget>[
                        Opacity(
                          opacity: enabled ? 1 : 0.5,
                          child: SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: Image.network(
                              ImageAssets.getUrlToken(symbol),
                              filterQuality: FilterQuality.medium,
                              errorBuilder: (context, url, error) => Container(
                                color:
                                    AppTheme.getInstance().selectDialogColor(),
                              ),
                            ),
                          ),
                        ),
                        spaceW5,
                        Text(
                          symbol,
                          style: textNormal(
                            enabled
                                ? null
                                : AppTheme.getInstance()
                                    .whiteWithOpacityFireZero(),
                            16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder<String>(
            stream: isCheck,
            builder: (context, snapshot) => snapshot.data?.isNotEmpty ?? false
                ? Text(
                    snapshot.data ?? '',
                    style: textNormalCustom(
                      AppTheme.getInstance().redColor(),
                      16,
                      FontWeight.w400,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
