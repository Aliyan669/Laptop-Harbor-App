import 'package:flutter/material.dart';

class Utils {
  static showMessage(context, message) {
    return ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static showCustomDailog(context,{title,name,email}){
    return showDialog(context:context , builder: (context) => AlertDialog(title:Text(title),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('name is ${name}'),
        Text('email is :${email}'),
      ],
    ),
     ),);
  }
}
