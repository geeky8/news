import 'package:flutter/material.dart';
import 'package:news/bloc/get_sources_bloc.dart';
import 'package:news/elements/error_element.dart';
import 'package:news/elements/loader_element.dart';
import 'package:news/model/article_response.dart';
import 'package:news/model/source.dart';
import 'package:news/model/source_response.dart';
import 'package:news/screens/source_details.dart';

class TopChannels extends StatefulWidget {
  @override
  _TopChannelsState createState() => _TopChannelsState();
}

class _TopChannelsState extends State<TopChannels> {
  @override
  void initState() {
    getSourcesBloc..getSources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getSourcesBloc.subject.stream,
      builder: (context, AsyncSnapshot<SourceResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return BuildErrorwidget(snapshot.data.error);
          }
          return _buildTopChannelsState(snapshot.data);
        } else if (snapshot.hasError) {
          return BuildErrorwidget(snapshot.error);
        } else {
          return BuildLoadingWidget();
        }
      },
    );
  }

  Widget _buildTopChannelsState(SourceResponse data) {
    List<SourceModel> sources = data.sources;
    if (sources.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text('No Sources'),
          ],
        ),
      );
    } else {
      return Container(
        height: 115,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sources.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                width: 80,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SourceDetail(source: sources[index]),),);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: sources[index].id,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1)),
                              ],
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/logos/${sources[index].id}.png"))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        sources[index].name,
                        style: TextStyle(
                            height: 1.4,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 3,),
                      Text(
                        sources[index].category,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    }
  }
}
