import 'package:ai_chatboot/Component/TextMessage.dart';
import 'package:ai_chatboot/Component/UserInput.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yoo Bro !"), centerTitle: true),
      drawer: Drawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) =>Container(
                  // color: Colors.orange,
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                        Textmessage(msg: 'Yoo!',isUser: false,),
                        SizedBox(height: 7,),
                        Textmessage(msg: controller.text,isUser: true,),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
            flex: 1,
            child:Userinput(
              controller: controller,
            ),
            ),
          ],
        ),
      ),
    );
  }
}
