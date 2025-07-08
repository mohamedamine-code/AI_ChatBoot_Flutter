import 'package:flutter/material.dart';

class Userinput extends StatelessWidget {
  final VoidCallback onTap;
  TextEditingController controller =TextEditingController();
  Userinput({required this.controller,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Ask anything",
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          suffixIcon: IconButton(
            onPressed: onTap,
            icon: Icon(Icons.arrow_forward),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
