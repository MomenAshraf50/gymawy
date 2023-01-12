import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialWebView extends StatelessWidget {
  SocialWebView({Key? key,required this.socialUrl}) : super(key: key);

  String socialUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: socialUrl,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          )
        ],
      ),
    );
  }
}
