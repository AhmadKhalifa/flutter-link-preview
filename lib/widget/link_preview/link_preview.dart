import 'package:flutter/material.dart';
import 'package:link_widget/widget/link_preview/scraper/index.dart';
import 'package:link_widget/widget/link_preview/views/index.dart';

import 'model/web_page_details.dart';

enum Style { LINKEDIN, SKYPE, TELEGRAM, TWITTER, WHATSAPP }

const DEFAULT_STYLE = Style.TELEGRAM;

abstract class LinkPreview {
  static of(url, {Style style = DEFAULT_STYLE}) {
    switch (style) {
      case Style.LINKEDIN:
        return LinkedInLinkPreview().render(url);
      case Style.SKYPE:
        return SkypeLinkPreview().render(url);
      case Style.TELEGRAM:
        return TelegramLinkPreview().render(url);
      case Style.TWITTER:
        return TwitterLinkPreview().render(url);
      case Style.WHATSAPP:
        return WhatsAppLinkPreview().render(url);
    }
  }

  WebScraper _webScraper = HtmlWebScraper();

  Widget render(String url) {
    return FutureBuilder(
      future: _webScraper.getPageDetails(url),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? snapshot.hasError ? Container() : buildWidget(snapshot.data)
            : Container();
      },
    );
  }

  Widget buildWidget(WebPageDetails webPageDetails);
}
