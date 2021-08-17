import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class ViewWeb extends StatefulWidget {
  ViewWeb({this.lats, this.longs});
  double? lats;
  double? longs;
  @override
  _ViewWebState createState() => _ViewWebState();
}

class _ViewWebState extends State<ViewWeb> {
  double? ws;
  double? hs;

  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() {
    setState(() {
      hs = widget.longs;
      ws = widget.lats;
      print(ws);
      print(hs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl:
              'https://weather.com/en-IN/weather/today/l/$ws,$hs?par=google',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
