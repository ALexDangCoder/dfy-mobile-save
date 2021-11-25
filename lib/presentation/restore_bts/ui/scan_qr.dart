import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400.w ||
            MediaQuery.of(context).size.height < 400.w)
        ? 251.0.w
        : 300.0.w;
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: AppTheme.getInstance().bgBtsColor(),
            borderRadius: 49.r,
            borderLength: 80.r,
            borderWidth: 5.w,
            cutOutSize: scanArea,
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 64.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 25.w,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: AppTheme.getInstance().whiteColor(),
                  ),
                ),
                SizedBox(
                  width: 86.w,
                ),
                // if (result != null)

                Text(
                  S.current.scan_qr_code,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    20.sp,
                    FontWeight.w700,
                  ),
                ),
              ],
            ),
            spaceH20,
            Divider(
              height: 1.h,
              color: AppTheme.getInstance().whiteWithOpacityFireZero(),
            )
          ],
        )
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        controller.pauseCamera();
        result = scanData;
        if (result!.code!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result?.code ?? S.current.no_data),
            ),
          );
        } else {
          widget.controller.text = result?.code ?? '';
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
