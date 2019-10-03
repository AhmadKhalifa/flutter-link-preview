import 'dart:collection';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:link_widget/widget/link_preview/model/web_page_details.dart';
import 'package:link_widget/widget/link_preview/scraper/base_web_scraper.dart';

class HtmlWebScraper extends WebScraper {
  HashMap<String, String> _properties = HashMap<String, String>();

  String _getProperty(String url, List<String> propertiesName,
      {bool resolve = false, bool urlFallback = false}) {
    String value;
    for (var propertyName in propertiesName) {
      value = _properties[propertyName];
      if (!_isEmpty(value)) {
        break;
      }
    }
    if (_isEmpty(value) && urlFallback) {
      value = url;
    }
    return resolve ? _resolveUrl(url, value) : value;
  }

  bool _isEmpty(String str) => str == null || str.isEmpty;

  String _resolveUrl(String baseUrl, String endpoint) {
    try {
      Uri.parse(endpoint ?? "");
      return endpoint;
    } on Exception {
      Uri baseUri;
      try {
        baseUri = Uri.http(baseUrl, endpoint);
        return baseUri.toString();
      } on Exception {
        return "";
      }
    }
  }

  @override
  Future<WebPageDetails> getPageDetails(String url) async {
    WebPageDetails webPageDetails = WebPageDetails();
    Client client = Client();
    Response response = await client.get(url);
    Document document = parse(response.body);
    List<Element> elements = document.getElementsByTagName("meta");
    List<Element> links = document.getElementsByTagName("link");
    List<Element> titleElements = document.getElementsByTagName("title");
    if (titleElements != null && titleElements.isNotEmpty) {
      NodeList firstTitleElementNodes = titleElements[0].nodes;
      if (firstTitleElementNodes != null && firstTitleElementNodes.isNotEmpty) {
        _properties['page_title'] =
            document.getElementsByTagName("title")[0].nodes[0].toString();
      }
    }
    for (int i = elements.length - 1; i >= 0; i--) {
      var attributes = elements[i].attributes.entries.toList();
      if (attributes.length == 2) {
        _properties[attributes[0].value] = attributes[1].value;
      }
    }
    for (int i = links.length - 1; i >= 0; i--) {
      var attributes = links[i].attributes.entries.toList();
      var attributesMap = HashMap<String, String>();
      attributes.forEach((entry) {
        attributesMap[entry.key] = entry.value;
      });
      _properties[attributesMap['rel']] = attributesMap['href'];
    }

    webPageDetails.title = _getProperty(
        url, ['og:title', 'og:name', 'og:site_name', 'page_title'],
        urlFallback: true);
    webPageDetails.description = _getProperty(
        url,
        [
          'page_title',
          'description',
          'Description',
          'og:description',
          'og:Description',
        ],
        urlFallback: true);
    webPageDetails.siteName =
        _getProperty(url, ['og:site_name', 'page_title'], urlFallback: true);
    var mediaType =
        _getProperty(url, ['medium', 'type', 'og:medium', 'og:type']);
    webPageDetails.mediaType = mediaType == "image" ? "photo" : mediaType;
    webPageDetails.imageUrl = _getProperty(
        url, ['og:image', 'image', 'image_src', 'apple-touch-icon', 'icon'],
        resolve: true);
    webPageDetails.favicon =
        _getProperty(url, ['apple-touch-icon', 'icon'], resolve: true);
    webPageDetails.url = _getProperty(url, ['og:url'], urlFallback: true);
    return Future.value(webPageDetails);
  }
}
