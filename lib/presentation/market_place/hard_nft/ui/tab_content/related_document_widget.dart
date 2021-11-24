import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RelatedDocument extends StatelessWidget {
  const RelatedDocument({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related documents',
          style: tokenDetailAmount(
            color: AppTheme.getInstance().whiteColor(),
            fontSize: 14,
          ),
        ),
        documentWidget(
          title: 'GiayPhepKinhDoanh.pdf',
          type: DocumentType.PDF,
          createDate: DateTime.now(),
        ),
        documentWidget(
          title: 'dieukhoan.doc',
          type: DocumentType.DOC,
          createDate: DateTime.now(),
        ),
        documentWidget(
          title: 'DanhSach.xls',
          type: DocumentType.XLS,
          createDate: DateTime.now(),
        ),

      ],
    );
  }

  Widget documentWidget({
    required String title,
    required DocumentType type,
    required DateTime createDate,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 12.h,
      ),
      height: 61.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedSvgImage(
            w: 24,
            h: 24,
            image: type.getIcon,
          ),
          spaceW10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: tokenDetailAmount(
                  color: AppTheme.getInstance().whiteColor(),
                  weight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              Text(
                'Created on ${createDate.stringFromDateTime}',
                style: tokenDetailAmount(
                  color: AppTheme.getInstance().currencyDetailTokenColor(),
                  weight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum DocumentType { DOC, PDF, XLS }

extension DocumentTypeExtension on DocumentType {
  String get getIcon {
    switch (this) {
      case DocumentType.DOC:
        return ImageAssets.ic_doc_svg;
      case DocumentType.PDF:
        return ImageAssets.ic_pdf_svg;
      case DocumentType.XLS:
        return ImageAssets.ic_xls_svg;
    }
  }
}
