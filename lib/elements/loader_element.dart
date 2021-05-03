import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget BuildLoadingWidget(){
  return Center(
    child: Column(
      children: [
        CupertinoActivityIndicator(),
      ],
    ),
  );
}