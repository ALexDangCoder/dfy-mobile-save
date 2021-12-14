import 'dart:developer';
import 'dart:io';
import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/token_price_model.dart';
import 'package:Dfy/domain/repository/price_repository.dart';
import 'package:Dfy/presentation/receive_token/bloc/receive_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rxdart/rxdart.dart';

class ReceiveCubit extends BaseCubit<ReceiveState> {
  ReceiveCubit() : super(ReceiveInitial());

  final BehaviorSubject<String> _amountSubject = BehaviorSubject.seeded('');
  final BehaviorSubject<double> _priceSubject = BehaviorSubject();

  Stream<String> get amountStream => _amountSubject.stream;
  Stream<double> get priceStream => _priceSubject.stream;

  Sink<String> get amountSink => _amountSubject.sink;
  Sink<double> get priceSink => _priceSubject.sink;

  String? get value => _amountSubject.valueOrNull;
  Future<String> createPath() async {
    final tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    final String path = '$tempPath/$ts.png';
    return path;
  }
  PriceRepository get _priceRepository => Get.find();

  Future<void> getListPrice(String symbols) async {
    showLoading();
    final Result<List<TokenPrice>> result =
    await _priceRepository.getListPriceToken(symbols);
    result.when(
      success: (res) {
        priceSink.add(res.first.price ?? 0);
        if(res.first.isBlank ?? true){
          showEmpty();
        }
      },
      error: (error) {
        updateStateError();
      },
    );
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
        final picData = await painter.toImageData(2048);
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
      buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
    );
  }

  void dispose() {
    _amountSubject.close();
    super.close();
  }
}
