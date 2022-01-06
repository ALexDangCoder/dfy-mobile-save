import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/base_items/base_item.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
      );
    } else {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
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
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              historyNFT.eventName ?? '',
              style: textNormalCustom(
                Colors.white.withOpacity(0.5),
                14,
                FontWeight.w400,
              ),
            ),
            Text(
              DateFormat('HH:mm - đ/MM/yyyy').format(
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
        status(
          historyNFT.eventName ?? '',
          historyNFT,
        ),
      ],
    ),
  );
}

Widget status(String eventName, HistoryNFT historyNFT) {
  final bool isYou = historyNFT.isYou ?? false;
  final String walletAddress = historyNFT.walletAddress ?? '';
  final String fromAddress = historyNFT.fromAddress ?? '';
  final String toAddress = historyNFT.toAddress ?? '';
  const String urlWeb = 'https://testnet.bscscan.com/address/';
  switch (eventName.toLowerCase()) {
    case 'create':
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
            if (!isYou)
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => WebView(
                        initialUrl: urlWeb + walletAddress,
                      ),
                style: const TextStyle(
                  fontSize: 14,
                  color: textHistory,
                ),
              )
            else
              TextSpan(
                text: 'you.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
          ],
        ),
      );
    case 'transfer':
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
            if (!isYou)
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => WebView(
                        initialUrl: urlWeb + fromAddress,
                      ),
                style: const TextStyle(
                  fontSize: 14,
                  color: textHistory,
                ),
              )
            else
              TextSpan(
                text: ' you ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
            TextSpan(
              text: ' to',
              style: textNormal(
                textHistory,
                14,
              ),
            ),
            if (!isYou)
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => WebView(
                        initialUrl: urlWeb + toAddress,
                      ),
                style: const TextStyle(
                  fontSize: 14,
                  color: textHistory,
                ),
              )
            else
              TextSpan(
                text: ' you.',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
          ],
        ),
      );
    case 'burn':
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
            if (!isYou)
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => WebView(
                        initialUrl: urlWeb + walletAddress,
                      ),
                style: const TextStyle(
                  fontSize: 14,
                  color: textHistory,
                ),
              )
            else
              TextSpan(
                text: ' you ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
          ],
        ),
      );
    case 'put on sale':
      return RichText(
        text: TextSpan(children: [
          TextSpan(),
        ]),
      );
    case 'put on pawn':
      return RichText(
        text: TextSpan(children: [
          TextSpan(),
        ]),
      );
    case 'put on auction':
      return RichText(
        text: TextSpan(children: [
          TextSpan(),
        ]),
      );
    case 'cancel sale':
      return RichText(
        text: TextSpan(children: [
          TextSpan(),
        ]),
      );
    case 'cancel pawn':
      return RichText(
        text: TextSpan(children: [
          TextSpan(),
        ]),
      );
    case 'cancel auction':
      return RichText(
        text: TextSpan(children: [
          TextSpan(),
        ]),
      );
    case 'buy nft':
      return RichText(
        text: TextSpan(children: [
          TextSpan(),
        ]),
      );
    case 'sign contract':
      return RichText(
        text: TextSpan(children: [
          TextSpan(),
        ]),
      );
    case 'end contract':
      return RichText(
        text: TextSpan(children: [
          TextSpan(),
        ]),
      );
    case 'auction win':
      return RichText(
        text: TextSpan(children: [
          TextSpan(),
        ]),
      );
    default:
      return const SizedBox();
  }
}
