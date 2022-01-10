import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';

class PickTime extends StatelessWidget {
  const PickTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController editHourController = TextEditingController();
    final TextEditingController editMinuteController = TextEditingController();
    editMinuteController.text = DateTime.now().minute.toString();
    editHourController.text = DateTime.now().hour.toString();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: colorSkeleton,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 26, top: 21),
            child: Text(
              S.current.time,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                24,
                FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: Container(
              height: 49,
              width: 115,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.getInstance().whiteColor(),
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 35,
                    width: 40,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: textNormalCustom(
                        fillYellowColor,
                        28,
                        FontWeight.w600,
                      ),
                      controller: editHourController,
                    ),
                  ),
                  Text(
                    ':',
                    style: textNormalCustom(
                      fillYellowColor,
                      28,
                      FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 40,
                    child: Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: textNormalCustom(
                          fillYellowColor,
                          28,
                          FontWeight.w600,
                        ),
                        controller: editMinuteController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 37,
          ),
        ],
      ),
    );
  }
}
