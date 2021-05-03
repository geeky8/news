import 'package:flutter/material.dart';
import 'package:news/bloc/get_sources_bloc.dart';
import 'package:news/elements/error_element.dart';
import 'package:news/elements/loader_element.dart';
import 'package:news/model/source.dart';
import 'package:news/model/source_response.dart';
import 'package:news/screens/source_details.dart';

class SourceScreen extends StatefulWidget {
  @override
  _SourceScreenState createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {

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
          return _buildSources(snapshot.data);
        } else if (snapshot.hasError) {
          return BuildErrorwidget(snapshot.error);
        } else {
          return BuildLoadingWidget();
        }
      },
    );
  }
  Widget _buildSources(SourceResponse data){
    List<SourceModel> sources = data.sources;
    return GridView.builder(
        itemCount: sources.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.86,
        ),
        itemBuilder: (context,index){
          return Padding(
            padding: EdgeInsets.only(left: 5,right: 5,top: 10),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SourceDetail(source: sources[index]),),);
              },
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5),),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[100],
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(1,1),
                    ),
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                        tag: sources[index].id,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/logos/${sources[index].id}.png"),fit: BoxFit.cover),
                          ),
                        ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                      child: Text(
                        sources[index].name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
