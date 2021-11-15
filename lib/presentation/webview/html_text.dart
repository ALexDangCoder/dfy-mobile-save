import 'package:Dfy/config/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlText extends StatelessWidget {
  final String data;
  final int? maxLines;
  final TextOverflow? overflow;

  const HtmlText(this.data, {Key? key, this.maxLines, this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: {
        'p': Style(
          // border: Border.all(color: Colors.grey),
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          lineHeight: LineHeight.em(1.2),
          color: dfTxtColor,
          fontSize: FontSize.medium,
          maxLines: maxLines,
          textOverflow: overflow,
          alignment: Alignment.topLeft,
        ),
        'div': Style(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          lineHeight: LineHeight.em(1.2),
          color: dfTxtColor,
          fontSize: FontSize.medium,
          maxLines: maxLines,
          textOverflow: overflow,
          alignment: Alignment.topLeft,
        ),
      },
    );
  }
}
