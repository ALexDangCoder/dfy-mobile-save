import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:Dfy/presentation/bottom_sheet_receive_token/bloc/receive_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rxdart/rxdart.dart';

class ReceiveCubit extends Cubit<ReceiveState> {
  ReceiveCubit() : super(ReceiveInitial());

  final BehaviorSubject<String> _amountSubject = BehaviorSubject.seeded('');

  Stream<String> get amountStream => _amountSubject.stream;

  Sink<String> get amountSink => _amountSubject.sink;

  String? get value => _amountSubject.valueOrNull;

  Future<String> createPath() async {
    final tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    final String path = '$tempPath/$ts.png';
    return path;
  }

  Future<String> saveToGallery(String data) async {
    String path = '';
    final qrValidationResult = QrValidator.validate(
      data: data,
    );
    try {
      if (qrValidationResult.status == QrValidationStatus.valid) {
        final qrCode = qrValidationResult.qrCode;
        final painter = QrPainter.withQr(
          qr: qrCode!,
          color: const Color(0xFF000000),
          gapless: true,
        );
        path = await createPath();
        final picData = await painter.toImageData(2048, format: ui.ImageByteFormat.png);
        log(picData.toString());
        await writeToFile(picData!, path);
      }
      return path;
    } catch (_) {
      throw Exception(qrValidationResult.error.toString());
    }
  }

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  void dispose() {
    _amountSubject.close();
    super.close();
  }
}
