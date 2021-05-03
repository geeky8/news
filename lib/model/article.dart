import 'package:news/model/source.dart';

class ArticleModel{
  final SourceModel source;
  final String author;
  final String title;
  final String url;
  final String img;
  final String description;
  final String date;
  final String content;

  ArticleModel({this.source,this.author,this.title,this.img,this.url,this.content,this.date,this.description});

  ArticleModel.fromJson(Map<String,dynamic> json):
      source = SourceModel.fromJson(json["source"]),
      author = json["author"],
      title = json["title"],
      url = json["url"],
      img = json["urlToImage"],
      description = json["description"],
      date = json["publishedAt"],
      content = json["content"];
}