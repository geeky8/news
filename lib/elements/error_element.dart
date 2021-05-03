import 'package:flutter/material.dart';

Widget BuildErrorwidget(String error){
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(error,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
      ],
    ),
  );
}