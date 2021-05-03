import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news/bloc/get_topHeadlines_bloc.dart';
import 'package:news/elements/error_element.dart';
import 'package:news/elements/loader_element.dart';
import 'package:news/model/article.dart';
import 'package:news/model/article_response.dart';
import 'package:news/screens/news_details.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadlineSlider extends StatefulWidget {
  @override
  _HeadlineSliderState createState() => _HeadlineSliderState();
}

class _HeadlineSliderState extends State<HeadlineSlider> {
  @override
  void initState() {
    getTopHeadlinesBloc..getHeadlines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getTopHeadlinesBloc.subject.stream,
      builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return BuildErrorwidget(snapshot.data.error);
          }
          return _headlineSliderState(snapshot.data);
        } else if (snapshot.hasError) {
          return BuildErrorwidget(snapshot.error);
        } else {
          return BuildLoadingWidget();
        }
      },
    );
  }

  Widget _headlineSliderState(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: false,
          height: 200,
          viewportFraction: 0.9,
        ),
        items: getExpenseSliders(articles),
      ),
    );
  }

  getExpenseSliders(List<ArticleModel> articles) {
    return articles.map(
      (article) => GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetail(articles: article),),);
        },
        child: Container(
          padding: EdgeInsets.only(
            left: 5,
            right: 5,
            top: 10,
            bottom: 10,
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: article.img == null
                        ? AssetImage("assets/img/placeholder.jpg")
                        : NetworkImage(article.img),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [
                      0.1,
                      0.9
                    ],
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.white.withOpacity(0.0),
                    ]
                  ),
                ),
              ),
              Positioned(
                  bottom: 30,
                  child: Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    width: 250,
                    child: Column(
                      children: [
                        Text(article.title,style: TextStyle(height: 1.5,fontWeight:FontWeight.bold,fontSize: 12,color: Colors.white),),
                      ],
                    ),
                  )
              ),
              Positioned(
                  bottom: 10,
                  left: 5,
                  child: Text(
                    article.source.name,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 9,
                    ),
                  ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child:Text(
                  timeAgo(DateTime.parse(article.date)),
                  style: TextStyle(color: Colors.white54,fontSize: 9),
                ),),
            ],
          ),
        ),
      ),
    ).toList();
  }
  String timeAgo(DateTime date){
    return timeago.format(date,allowFromNow: true,locale: 'en');
  }
}
