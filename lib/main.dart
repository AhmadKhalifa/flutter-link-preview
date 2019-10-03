import 'package:flutter/material.dart';
import 'package:link_widget/widget/link_preview/link_preview.dart';

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
            Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: LinkPreview.of('https://whatsapp.com',
                    style: Style.WHATSAPP)),
            Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: LinkPreview.of('https://telegram.org')),
            Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: LinkPreview.of('https://skype.com', style: Style.SKYPE)),
            Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: LinkPreview.of('https://twitter.com',
                    style: Style.TWITTER)),
            Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: LinkPreview.of('https://linkedin.com',
                    style: Style.LINKEDIN)),
          ],
        ),
      ),
    );
  }
}
