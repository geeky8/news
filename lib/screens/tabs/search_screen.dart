import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news/bloc/get_sourceNews_bloc.dart';
import 'package:news/bloc/get_topHeadlines_bloc.dart';
import 'package:news/bloc/search_bloc.dart';
import 'package:news/elements/error_element.dart';
import 'package:news/elements/loader_element.dart';
import 'package:news/model/article.dart';
import 'package:news/model/article_response.dart';
import 'package:news/screens/news_details.dart';
import 'package:news/style/theme.dart' as Style;
import 'package:timeago/timeago.dart' as timeago;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    searchBloc..search("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              controller: _searchController,
              onChanged: (changed){
                searchBloc..search(_searchController.text);
              },
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Colors.grey[100],
                suffixIcon: _searchController.text.length > 0? IconButton(icon: Icon(EvaIcons.backspaceOutline), onPressed: (){
                  setState(() {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _searchController.clear();
                    searchBloc..search(_searchController.text);
                  });
                },) :
                    Icon(EvaIcons.searchOutline,color: Colors.grey[500],size: 16,),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[100].withOpacity(0.3),
                    ),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[100].withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.only(left: 15,right: 10),
                labelText: "Search...",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Style.Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              autocorrect: false,
              autovalidate: true,
            ),
        ),
        Expanded(
            child: StreamBuilder<ArticleResponse>(
          stream: searchBloc.subject.stream,
          builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null && snapshot.data.error.length > 0) {
                return BuildErrorwidget(snapshot.data.error);
              }
              return _buildSearchedNews(snapshot.data);
            } else if (snapshot.hasError) {
              return BuildErrorwidget(snapshot.error);
            } else {
              return BuildLoadingWidget();
            }
          },
        ),
        ),
      ],

    );
  }
  Widget _buildSearchedNews(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    if (articles.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('No News'),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetail(articles: articles[index]),),);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[200], width: 1),
                ),
                color: Colors.white,
              ),
              width: 150,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 3 / 5,
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          Text(
                            articles[index].title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  Text(
                                    timeAgo(DateTime.parse(articles[index].date)),
                                    style: TextStyle(
                                      color: Colors.black26,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    width: MediaQuery.of(context).size.width * 2 / 5,
                    height: 130,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/img/placeholder.jpg',
                      image: articles[index].img==null?"assets/img/placeholder.jpg":articles[index].img,
                      fit: BoxFit.fitHeight,
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height * 1/3,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
