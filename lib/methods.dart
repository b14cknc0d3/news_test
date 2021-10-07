class MyNewsQueryModel {
  String newsHeading;
  String newsDescription;
  String newsImage;
  String newsUrl;
  MyNewsQueryModel(
      {this.newsHeading = "headlines",
      this.newsDescription = "my news",
      this.newsImage = "img",
      this.newsUrl = "SOME URL"});

  factory MyNewsQueryModel.fromMap(Map news) {
    return MyNewsQueryModel(
        newsHeading: news["title"],
        newsDescription: news["description"],
        newsImage: news["urlToImage"],
        newsUrl: news["url"]);
  }
}
