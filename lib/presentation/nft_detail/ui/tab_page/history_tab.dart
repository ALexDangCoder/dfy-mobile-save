import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/base_items/base_item.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key, required this.listHistory}) : super(key: key);
  final List<HistoryNFT> listHistory;

  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listHistory.isEmpty) {
      return Center(
        child: SizedBox(
          height: 300.h,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 100.h),
            children: [
              Center(
                child: sizedPngImage(
                  w: 94,
                  h: 94,
                  image: ImageAssets.icNoTransaction,
                ),
              ),
              Center(
                child: Text(
                  S.current.no_transaction,
                  style: tokenDetailAmount(
                    color: AppTheme.getInstance().currencyDetailTokenColor(),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        shrinkWrap: true,
        itemCount: widget.listHistory.length,
        itemBuilder: (context, index) {
          return _buildItemHistory(widget.listHistory[index]);
        },
      );
    }
  }
}

Widget _buildItemHistory(HistoryNFT historyNFT) {
  return BaseItem(
    child: InkWell(
      onTap: () {
        launch(
          Get.find<AppConstants>().bscScan +
              ApiConstants.BSC_SCAN_TX +
              (historyNFT.txnHash ?? ''),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getHistory(historyNFT.historyType ?? 20),
              Text(
                formatDateTime.format(
                  DateTime.fromMillisecondsSinceEpoch(
                    historyNFT.eventDateTime ?? 0,
                  ),
                ),
                style: textNormalCustom(
                  Colors.white.withOpacity(0.5),
                  14,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
          spaceH7,
          status(
            historyNFT,
          ),
        ],
      ),
    ),
  );
}

Widget getHistory(int historyType) {
  switch (historyType) {
    case 0:
      return Text(
        'Create',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 1:
      return Text(
        'Transfer',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 2:
      return Text(
        'Burn',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 3:
      return Text(
        'Put on sale',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 4:
      return Text(
        'pawnPut on pawn',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 5:
      return Text(
        'Cancel sale',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 6:
      return Text(
        'Cancel pawn',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 7:
      return Text(
        'Cancel auction',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 8:
      return Text(
        'Buy NFT',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 9:
      return Text(
        'Sign contract',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 10:
      return Text(
        'End contract',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 11:
      return Text(
        'Auction win',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 12:
      return Text(
        'With draw',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    case 13:
      return Text(
        'Put on auction',
        style: textNormal(
          Colors.white,
          14,
        ),
      );
    default:
      return const SizedBox();
  }
}

Widget status(HistoryNFT historyNFT) {
  final String walletAddress = historyNFT.walletAddress ?? '';
  final String price = '${historyNFT.price?.stringNumFormat ?? ''} '
      '${historyNFT.priceSymbol ?? ''}';
  final String expectedLoan = (historyNFT.exceptedLoan?.stringNumFormat ?? '') +
      (historyNFT.priceSymbol ?? '');
  switch (historyNFT.historyType) {
    case 0:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Create by ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.walletAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            )
          ],
        ),
      );
    case 1:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Transfer from ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.fromAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
            TextSpan(
              text: ' to',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.toAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
          ],
        ),
      );
    case 2:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Burn by ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.walletAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
          ],
        ),
      );
    case 3:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Put on sale by ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.walletAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
            TextSpan(
              text: ' for ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: price,
              style: textNormal(
                amountColor,
                14,
              ),
            ),
          ],
        ),
      );
    case 4:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Put on pawn by ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.walletAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
            TextSpan(
              text: ' for ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: price,
              style: textNormal(
                amountColor,
                14,
              ),
            ),
            TextSpan(
              text: ' expected loan',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
          ],
        ),
      );
    case 13:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Put on auction by ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.walletAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
            TextSpan(
              text: ' for ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: price,
              style: textNormal(
                amountColor,
                14,
              ),
            ),
          ],
        ),
      );
    case 5:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Cancel sale by  ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.walletAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
          ],
        ),
      );
    case 6:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Cancel pawn by  ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.walletAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
          ],
        ),
      );
    case 7:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Cancel auction review by ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.walletAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
          ],
        ),
      );
    case 8:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Bought NFT for ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: price,
              style: textNormal(
                amountColor,
                14,
              ),
            ),
            TextSpan(
              text: ' by ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.toAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
          ],
        ),
      );
    case 9:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Signed between ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.fromAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
            TextSpan(
              text: ' and ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.toAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
            TextSpan(
              text: ' for ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: price,
              style: textNormal(
                amountColor,
                14,
              ),
            ),
            TextSpan(
              text: ' contract value',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
          ],
        ),
      );
    case 10:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Contract between ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.fromAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
            TextSpan(
              text: ' and ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.toAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
            TextSpan(
              text: ' has end. Collateral transferred to ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: historyNFT.fromAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
          ],
        ),
      );
    case 11:
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: historyNFT.walletAddress!.formatAddress(index: 4),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(
                      Get.find<AppConstants>().bscScan +
                          ApiConstants.BSC_SCAN_ADDRESS +
                          walletAddress,
                    ),
              style: richTextBlue,
            ),
            TextSpan(
              text: ' has won NFT auction for ',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            TextSpan(
              text: price,
              style: textNormal(
                amountColor,
                14,
              ),
            ),
          ],
        ),
      );
    default:
      return const SizedBox();
  }
}
