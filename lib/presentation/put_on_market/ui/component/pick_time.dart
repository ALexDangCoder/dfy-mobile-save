import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PickTime extends StatefulWidget {
  const PickTime({Key? key, required this.onChange}) : super(key: key);
  final Function onChange;

  @override
  _PickTimeState createState() => _PickTimeState();
}

class _PickTimeState extends State<PickTime> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController editHourController = TextEditingController();
    final TextEditingController editMinuteController = TextEditingController();
    editMinuteController.text = DateTime.now().minute < 10
        ? '0${DateTime.now().minute}'
        : DateTime.now().minute.toString();
    editHourController.text = DateTime.now().hour.toString();
    return Container(
      constraints: const BoxConstraints(maxWidth: 430),
      width: MediaQuery.of(context).size.width - 64,
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
              height: 48,
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        counter: SizedBox(height: 0),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 5),
                      ),
                      style: textNormalCustom(
                        fillYellowColor,
                        28,
                        FontWeight.w600,
                      ),
                      onChanged: (text) {
                        final int hour = int.parse(text) % 24;
                        editHourController
                          ..text = editHourController.text = hour < 10
                              ? '0${hour.toString()}'
                              : hour.toString()
                          ..selection = TextSelection.collapsed(
                            offset: editHourController.text.length,
                          );
                      },
                      controller: editHourController,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                    child: Text(
                      ':',
                      style: textNormalCustom(
                        fillYellowColor,
                        28,
                        FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        counter: SizedBox(height: 0),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 5),
                      ),
                      style: textNormalCustom(
                        fillYellowColor,
                        28,
                        FontWeight.w600,
                      ),
                      controller: editMinuteController,
                      onChanged: (text) {
                        final int minute = int.parse(text) % 60;
                        editMinuteController
                          ..text = editMinuteController.text = minute < 10
                              ? '0${minute.toString()}'
                              : minute.toString()
                          ..selection = TextSelection.collapsed(
                            offset: editMinuteController.text.length,
                          );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 37,
          ),
          Container(
            height: 1,
            color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
          ),
          SizedBox(
            height: 64,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        S.current.cancel,
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          20,
                          FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        S.current.ok,
                        style: textNormalCustom(
                          fillYellowColor,
                          20,
                          FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
