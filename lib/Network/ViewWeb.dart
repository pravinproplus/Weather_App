import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    get_da();
    super.initState();
  }

  get_da() {
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
