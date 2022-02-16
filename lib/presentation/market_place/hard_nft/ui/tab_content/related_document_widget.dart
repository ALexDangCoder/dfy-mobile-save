import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class RelatedDocument extends StatelessWidget {
  const RelatedDocument({Key? key, required this.evaluation}) : super(key: key);
  final Evaluation evaluation;

  @override
  Widget build(BuildContext context) {
    if (evaluation.document?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          divide,
          spaceH20,
          Text(
            'Related documents',
            style: textNormalCustom(
              AppTheme.getInstance().whiteColor(),
              14,
              FontWeight.w600,
            ),
          ),
          if (evaluation.document?.isNotEmpty ?? false)
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: evaluation.document!.length,
              itemBuilder: (BuildContext context, int index) {
                return documentWidget(
                  title: evaluation.document![index].name ?? '',
                  type: evaluation.document![index].type ?? DocumentType.DOC,
                  createDate: evaluation.evaluatedTime ?? 0,
                  urlDocument: evaluation.document![index].urlDocument ?? '',
                );
              },
            ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget documentWidget({
    required String title,
    required DocumentType type,
    required String urlDocument,
    required int createDate,
  }) {
    return InkWell(
      onTap: () {
        launch(urlDocument);
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: 12.h,
        ),
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
                SizedBox(
                  width: 305.w,
                  child: Text(
                    title,
                    style: tokenDetailAmount(
                      color: AppTheme.getInstance().whiteColor(),
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  'Created on ${formatDateTime.format(
                    DateTime.fromMillisecondsSinceEpoch(createDate),
                  )}',
                  style: tokenDetailAmount(
                    color: AppTheme.getInstance().currencyDetailTokenColor(),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
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
