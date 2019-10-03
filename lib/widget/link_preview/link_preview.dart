import 'package:flutter/material.dart';
import 'package:link_widget/widget/link_preview/scraper/index.dart';
import 'package:link_widget/widget/link_preview/views/index.dart';

import 'model/web_page_details.dart';

class LinkPreviewWidget extends StatelessWidget {
  final String url;
  final Widget Function(WebPageDetails) builder;

  const LinkPreviewWidget({Key key, this.url, this.builder}) : super(key: key);

  static var linkedInBuilder = (WebPageDetails webPageDetails) => LinkedInView(
        imageUrl: webPageDetails.imageUrl,
        title: webPageDetails.title.split(':')[0],
        url: webPageDetails.url,
        description: webPageDetails.description,
      );

  static var skypeBuilder = (WebPageDetails webPageDetails) => SkypeView(
        imageUrl: webPageDetails.imageUrl,
        title: webPageDetails.title.split(':')[0],
        url: webPageDetails.url,
        description: webPageDetails.description,
        favUrl: webPageDetails.favicon,
      );

  static var telegramBuilder = (WebPageDetails webPageDetails) => TelegramView(
        imageUrl: webPageDetails.imageUrl,
        title: webPageDetails.title.split(':')[0],
        url: webPageDetails.url,
        description: webPageDetails.description,
      );

  static var twitterBuilder = (WebPageDetails webPageDetails) => TwitterView(
        imageUrl: webPageDetails.imageUrl,
        title: webPageDetails.title.split(':')[0],
        url: webPageDetails.url,
        description: webPageDetails.description,
      );

  static var whatsAppBuilder = (WebPageDetails webPageDetails) => WhatsAppView(
        imageUrl: webPageDetails.imageUrl,
        title: webPageDetails.title.split(':')[0],
        url: webPageDetails.url,
        description: webPageDetails.description,
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HtmlWebScraper().getPageDetails(url),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? snapshot.hasError ? Container() : builder(snapshot.data)
            : Container();
      },
    );
  }
}
