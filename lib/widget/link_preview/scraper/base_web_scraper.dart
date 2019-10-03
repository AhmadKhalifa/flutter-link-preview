import 'package:link_widget/widget/link_preview/model/web_page_details.dart';

abstract class WebScraper {
  Future<WebPageDetails> getPageDetails(String url);
}
