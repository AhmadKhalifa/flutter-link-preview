import 'package:flutter/material.dart';
import 'package:link_widget/widget/link_preview/link_preview.dart';
import 'package:link_widget/widget/link_preview/model/web_page_details.dart';
import 'package:link_widget/widget/link_preview/views/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 243, 244, 1.0),
      appBar: AppBar(
        title: const Text('Rich Link Preview example app'),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LinkPreviewWidget(
              url: 'https://whatsapp.com',
              builder: (WebPageDetails webPageDetails) {
                return WhatsAppView(
                  imageUrl: webPageDetails.imageUrl,
                  title: webPageDetails.title.split(':')[0],
                  url: webPageDetails.url,
                  description: webPageDetails.description,
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: LinkPreviewWidget(
                url: "https://whatsapp.com",
                builder: LinkPreviewWidget.whatsAppBuilder,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: LinkPreviewWidget(
                url: "https://telegram.org",
                builder: LinkPreviewWidget.telegramBuilder,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: LinkPreviewWidget(
                url: "https://skype.com",
                builder: LinkPreviewWidget.skypeBuilder,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: LinkPreviewWidget(
                url: "https://twitter.com",
                builder: LinkPreviewWidget.twitterBuilder,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: LinkPreviewWidget(
                url: "https://linkedin.com",
                builder: LinkPreviewWidget.linkedInBuilder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
