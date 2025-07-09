import 'package:flutter/material.dart';

class Userinput extends StatelessWidget {
  TextEditingController controller =TextEditingController();
  Userinput({required this.controller,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        controller: controller,
        decoration: InputDecoration(
          
          hintText: "Ask anything",
          hintStyle: TextStyle(color: Color.fromARGB(131, 255, 255, 255)),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
