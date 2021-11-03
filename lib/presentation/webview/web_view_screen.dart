import 'dart:async';
import 'dart:io';

import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/locals/logger.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/app_bar.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/get_ext.dart';
import 'package:Dfy/widgets/views/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({required this.url, required this.title, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebViewScreenState();
  }
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  StateLayout _stateLayout = StateLayout.showLoading;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNormal(
        title: widget.title,
        leading: ImageAssets.svgAssets(ImageAssets.icBack),
        context: context,
      ),
      body: StateFullLayout(
        stateLayout: _stateLayout,
        retry: () {
          reload();
        },
        error: AppException('', S.current.something_went_wrong),
        textEmpty: '',
        child: WillPopScope(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                logger.d('WebView is loading (progress : $progress%)');
              },
              javascriptChannels: const <JavascriptChannel>{},
              navigationDelegate: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                showLoading();
              },
              onPageFinished: (String url) {
                hideLoading();
              },
              onWebResourceError: (error) {
                showError();
              },
              gestureNavigationEnabled: true,
            ),
            onWillPop: () async {
              await backToPreScreen();
              return true;
            },),
      ),
    );
  }

  void showLoading() {
    if (_stateLayout != StateLayout.showLoading) {
      _stateLayout = StateLayout.showLoading;
    }
    setState(() {});
  }

  void hideLoading() {
    if (_stateLayout == StateLayout.showLoading) {
      _stateLayout = StateLayout.showContent;
    }
    setState(() {});
  }

  void showError() {
    _stateLayout = StateLayout.showError;
    setState(() {});
  }

  Future<void> reload() async {
    final WebViewController controller = await _controller.future;
    await controller.loadUrl(widget.url);
  }

  Future<void> backToPreScreen() async => finish();
}
