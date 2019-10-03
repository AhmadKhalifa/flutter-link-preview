class WebPageDetails {
  String url;
  String imageUrl;
  String title;
  String description;
  String siteName;
  String mediaType;
  String favicon;

  @override
  String toString() {
    return "url: $url\n" +
        "imageUrl: $imageUrl\n" +
        "title: $title\n" +
        "description: $description\n" +
        "siteName: $siteName\n" +
        "mediaType: $mediaType\n" +
        "favicon: $favicon\n";
  }
}
