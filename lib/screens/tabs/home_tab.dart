import 'package:flutter/material.dart';
import 'package:news/widgets/headline_slider.dart';
import 'package:news/widgets/hot_news.dart';
import 'package:news/widgets/top_channels.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadlineSlider(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Top Channels',
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        TopChannels(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Hot News",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        HotNews(),
      ],
    );
  }
}
