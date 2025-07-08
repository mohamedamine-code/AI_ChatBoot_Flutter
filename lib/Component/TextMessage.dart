import 'package:flutter/material.dart';

class Textmessage extends StatelessWidget {
  final String msg;
  final bool isUser;
  Textmessage({required this.msg,required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:isUser?Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.amber,
        ),
        child: Text(msg, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
