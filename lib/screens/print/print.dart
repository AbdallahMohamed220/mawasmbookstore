import 'package:flutter/material.dart';
import 'package:mawasmbookstore/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrintingScreen extends StatefulWidget {
  PrintingScreen({Key key}) : super(key: key);

  @override
  _PrintingScreenState createState() => _PrintingScreenState();
}

class _PrintingScreenState extends State<PrintingScreen> {
  @override
  Widget build(BuildContext context) {
    var userToken = Provider.of<Auth>(context, listen: false).token;
    return Scaffold(
      body: WebView(
        initialUrl:
            'https://mawasmbookstore.com/?rest_route=/simple-jwt-login/v1/autologin&jwt=$userToken',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
