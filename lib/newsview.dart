import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class Newsview extends StatefulWidget {
  String url;
  // ignore: use_key_in_widget_constructors
  Newsview(this.url);
  @override
  _NewsviewState createState() => _NewsviewState();
}

class _NewsviewState extends State<Newsview> {
  late String finalUrl;
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  @override
  void initState() {
    if (widget.url.toString().contains("http://")) {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");
    } else {
      finalUrl = widget.url;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: WebView(
          initialUrl: finalUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            setState(() {
              controller.complete(webViewController);
            });
          },
        ),
      ),
    );
  }
}
