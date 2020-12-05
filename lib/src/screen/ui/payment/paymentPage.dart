import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cybernotes/src/screen/Widget/bezierContainer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:cybernotes/src/screen/ui/login/loginPage.dart';
import 'package:cybernotes/src/screen/styles/app_colors.dart';

// ignore: camel_case_types
class paymentPage extends StatefulWidget {
  const paymentPage(this.htmlCode);
  final htmlCode;
  @override
  _paymentPageState createState() => _paymentPageState(this.htmlCode);
}

// ignore: camel_case_types
class _paymentPageState extends State<paymentPage>{
  WebViewController _controller;
  _paymentPageState(htmlCode);

  @override
  void initState() {
    //_controller.loadUrl(widget.htmlCode);
    super.initState();
  }

  bool visible = false;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      /*body: WebviewScaffold(
        url: widget.htmlCode,
        withJavascript: true,
        withZoom: false,
        withLocalUrl: widget.htmlCode,
        appBar: AppBar(
          title: Text("Payment"),
          backgroundColor: Color((0xfff7892b)),
          elevation: 1
        ),
      ),*/
        appBar: AppBar(
            title: Text("Payment"),
            backgroundColor: Color((0xfff7892b)),
            elevation: 1
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 9,
                child: WebView(
                  initialUrl: widget.htmlCode,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                  },
                  onPageFinished: (htmlCode) {
                    if(htmlCode.contains('success.php')){
                      return Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    } else {
                      _controller.evaluateJavascript("console.log('Hello')");
                    }
                  },
                  navigationDelegate: (action) {
                    print('Action:');print(action.url);
                    if (action.url ==
                        "https://stackoverflow.com/users/login?ssrc=head&returnurl=https%3a%2f%2fstackoverflow.com%2f") {
                      print('true:');
                      return NavigationDecision.prevent;
                    } else {
                      return Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  },
                  debuggingEnabled: true,
                )),
            /*Expanded(
              flex: 1,
              child: RaisedButton(
                child: Text("Open StackOverFlowPage"),
                onPressed: () {
                  _controller.loadUrl("https://stackoverflow.com/");
                },
              ),
            )*/
          ],
        ));
  }
}