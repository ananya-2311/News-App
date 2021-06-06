import 'package:flutter/cupertino.dart';
import 'package:news2_app/article_model.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class ArticlePage extends StatefulWidget {
  final String postUrl;

  ArticlePage({@required this.postUrl});

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
          child: Row(
            children: <Widget>[
              Text("News", style: TextStyle(
                color: Colors.black,
              ),),
              Text("TODAY",
                style: TextStyle(
                  color: Colors.red,
                ),)
            ],
          ),
        ),

        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl:  widget.postUrl,
          onWebViewCreated: (WebViewController webViewController){
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}