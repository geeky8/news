import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news/model/article.dart';
import 'package:news/style/theme.dart' as Style;
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatefulWidget {
  final ArticleModel articles;

  NewsDetail({Key key, @required this.articles}) : super();

  @override
  _NewsDetailState createState() => _NewsDetailState(articles);
}

class _NewsDetailState extends State<NewsDetail> {
  final ArticleModel articles;
  _NewsDetailState(this.articles);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: (){
          launch(articles.url);
        },
        child: Container(
          height: 48,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Style.Colors.mainColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Read More",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Style.Colors.mainColor,
        title: Text(
          articles.title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
              aspectRatio: 16/9,
              child: FadeInImage.assetNetwork(placeholder: 'assets/img/placeholder.jpg', image: articles.img,fit: BoxFit.cover,),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text(
                  articles.date.substring(0,10),
                  style: TextStyle(color: Style.Colors.mainColor,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Text(
                  articles.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10,),
                Html(data: articles.content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
