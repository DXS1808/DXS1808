import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../config/constants/constants.dart';


class PreviewWeb extends StatefulWidget {
  String url;
  PreviewWeb({Key? key,required this.url}) : super(key: key);

  @override
  State<PreviewWeb> createState() => _PreviewWebState();
}

class _PreviewWebState extends State<PreviewWeb> {

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller =
    Completer<WebViewController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kBackgroundColor,
      ),
      body: WebView(
          initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
      ),
    );
  }
}
