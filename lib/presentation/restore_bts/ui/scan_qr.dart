import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MyQRView extends StatefulWidget {
  const MyQRView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyQRViewState();
}

class _MyQRViewState extends State<MyQRView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
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
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 251.0
        : 300.0;
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: const Color(0xff6f6fc5),
              borderRadius: 49,
              borderLength: 80,
              borderWidth: 5,
              cutOutSize: scanArea),
        ),
        Column(
          children: [
            const SizedBox(
              height: 64,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 86,
                ),
                // if (result != null)

                Text(
                  S.current.scan_qr_code,
                  style: textNormalCustom(
                    Colors.white,
                    20,
                    FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
              color: Colors.white.withOpacity(0.5),
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
