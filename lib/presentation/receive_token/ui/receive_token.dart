import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/receive_token/bloc/receive_cubit.dart';
import 'package:Dfy/presentation/receive_token/ui/set_amount_pop_up.dart';
import 'package:Dfy/utils/animate/custom_rect_tween.dart';
import 'package:Dfy/utils/animate/hero_dialog_route.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/pull_to_refresh/custom_refresh_indicator.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

final formatCoin = NumberFormat('#,##0.#####', 'en_US');
final formatUSD = NumberFormat('########,##0.#####\$', 'en_US');
enum TokenType { DFY, NFT, QR }

class Receive extends StatefulWidget {
  const Receive({
    Key? key,
    required this.walletAddress,
    required this.type,
    this.symbol = 'BNB',
    this.nameToken = 'Binance',
    this.price,
  }) : super(key: key);
  final String walletAddress;
  final TokenType type;
  final String? symbol;
  final String? nameToken;
  final double? price;

  @override
  _ReceiveState createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
  late final TextEditingController amountController;
  late final ReceiveCubit receiveCubit;
  late final FToast toast;
  String? amount;
  late final GlobalKey globalKey;
  double price = 1.0;
  num quantity = 1.0;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    receiveCubit = ReceiveCubit();
    globalKey = GlobalKey();
    toast = FToast();
    toast.init(context);
    receiveCubit.showContent();
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    receiveCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StateStreamLayout(
        stream: receiveCubit.stateStream,
        error: AppException('', S.current.something_went_wrong),
        retry: () async {
          await receiveCubit.getListPrice(widget.symbol ?? '');
        },
        textEmpty: '',
        child: BaseBottomSheet(
          title: textTitle(widget.type),
          child: CustomRefreshIndicator(
            onRefresh: widget.type == TokenType.QR
                ? () {}
                : () async {
                    await receiveCubit.getListPrice(widget.symbol ?? '');
                  },
            child: Column(
              children: [
                SizedBox(
                  height: 41.h,
                ),
                RepaintBoundary(
                  key: globalKey,
                  child: Container(
                    width: 311.w,
                    padding: EdgeInsets.only(
                      top: 16.h,
                      bottom: 12.h,
                      right: 40.w,
                      left: 40.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().selectDialogColor(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(36),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 125.w,
                          height: 29.h,
                          child: Image.asset(ImageAssets.defiText),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        StreamBuilder(
                          stream: receiveCubit.amountStream,
                          builder: (context, snapshot) {
                            return QrImage(
                              data: receiveCubit.value?.isEmpty ?? true
                                  ? widget.walletAddress
                                  : '${widget.nameToken}:'
                                      '${widget.walletAddress}'
                                      '?amount=${receiveCubit.value}',
                              size: 230.w,
                              gapless: false,
                              backgroundColor: Colors.white,
                            );
                          },
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        SizedBox(
                          width: 232.w,
                          child: Text(
                            widget.walletAddress,
                            textAlign: TextAlign.center,
                            style: textNormalCustom(
                              null,
                              18,
                              FontWeight.w300,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        StreamBuilder<String>(
                          stream: receiveCubit.amountStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              amount = snapshot.data;
                              if (snapshot.data!.isNotEmpty) {
                                quantity = double.parse(snapshot.data!);
                              }
                            } else {
                              amount = '';
                            }
                            return Visibility(
                              visible: amount!.isNotEmpty,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 12.h,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '${formatCoin.format(quantity)}'
                                      ' ${widget.symbol}',
                                      style: textNormal(
                                        AppTheme.getInstance().fillColor(),
                                        24,
                                      ).copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    StreamBuilder<double>(
                                      stream: receiveCubit.priceStream,
                                      initialData: widget.price,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          price = snapshot.data!;
                                        } else {
                                          price = widget.price ?? 0.0;
                                        }
                                        return Text(
                                          formatUSD.format(
                                            price * quantity,
                                          ),
                                          style: textNormal(
                                            Colors.grey.withOpacity(0.5),
                                            16,
                                          ).copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 24.w,
                    right: 24.w,
                  ),
                  width: 311.w,
                  height: 78.h,
                  child: Row(
                    mainAxisAlignment: widget.type == TokenType.DFY
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      _buildColumnButton(
                        path: ImageAssets.ic_save,
                        label: S.current.save,
                        callback: () async {
                          final RenderRepaintBoundary? boundary =
                              globalKey.currentContext!.findRenderObject()
                                  as RenderRepaintBoundary?;
                          final image = await boundary!.toImage();
                          final ByteData? byteData = await image.toByteData(
                            format: ImageByteFormat.png,
                          );
                          if (byteData != null) {
                            await ImageGallerySaver.saveImage(
                              byteData.buffer.asUint8List(),
                            );
                            toast.showToast(
                              child: popMenu(),
                              toastDuration: const Duration(seconds: 2),
                              gravity: ToastGravity.CENTER,
                            );
                          }
                        },
                      ),
                      if (widget.type == TokenType.DFY)
                        Flexible(
                          child: _buildColumnButton(
                            path: ImageAssets.ic_set_amount,
                            label: S.current.set_amount,
                            callback: () {
                              Navigator.of(context).push(
                                HeroDialogRoute(
                                  builder: (context) {
                                    return SetAmountPopUp(
                                      controller: amountController,
                                      cubit: receiveCubit,
                                      symbol: widget.symbol,
                                    );
                                  },
                                  isNonBackground: false,
                                ),
                              );
                            },
                          ),
                        )
                      else
                        spaceW60,
                      _buildColumnButton(
                        path: ImageAssets.ic_share,
                        label: S.current.share,
                        callback: () async {
                          final RenderRepaintBoundary? boundary =
                              globalKey.currentContext!.findRenderObject()
                                  as RenderRepaintBoundary?;
                          final image = await boundary!.toImage();
                          final ByteData? byteData = await image.toByteData(
                            format: ImageByteFormat.png,
                          );
                          final Uint8List pngBytes =
                              byteData!.buffer.asUint8List();

                          final tempDir = await getTemporaryDirectory();
                          final file =
                              await File('${tempDir.path}/image.png').create();
                          await file.writeAsBytes(pngBytes);
                          await Share.shareFiles(
                            ['${tempDir.path}/image.png'],
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell _buildColumnButton({
    required String path,
    required String label,
    Function()? callback,
  }) {
    return InkWell(
      onTap: callback,
      child: Column(
        children: [
          Container(
            height: 48.h,
            width: 48.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.getInstance().columnButtonColor(),
              image: DecorationImage(image: AssetImage(path)),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Expanded(
            child: Text(
              label,
              style: textNormalCustom(
                null,
                16,
                FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center popMenu() => Center(
        child: Hero(
          tag: '',
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: buildBlur(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              color: Colors.white.withOpacity(0.6),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: 232.w,
                height: 83.h,
                child: Center(
                  child: Text(
                    S.current.saved,
                    style: textNormal(
                      null,
                      20,
                    ).copyWith(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildBlur({
    required Widget child,
    BorderRadius borderRadius = BorderRadius.zero,
    double sigmaX = 4,
    double sigmaY = 4,
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: sigmaX,
          sigmaY: sigmaY,
        ),
        child: child,
      ),
    );
  }

  String textTitle(TokenType type) {
    if (type == TokenType.DFY) {
      return '${S.current.receive} ${widget.symbol!}';
    } else if (type == TokenType.NFT) {
      return S.current.receive_nft;
    } else if (type == TokenType.QR) {
      return S.current.scan_qr_code;
    } else {
      return '';
    }
  }
}
