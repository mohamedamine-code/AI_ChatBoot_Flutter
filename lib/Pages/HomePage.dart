import 'package:ai_chatboot/Component/TextMessage.dart';
import 'package:ai_chatboot/Component/UserInput.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  //[[user,reponse]]
  List<List<String>> converstion = [];


  void tiggerConverstion(TextEditingController controller) {
    final String userInput = controller.text;
    String reponse;
    if (userInput == "yoo") {
      reponse = "hh Bro yoo";
    } else {
      reponse = "Noo bro do it agian !";
    }
    setState(() {
      converstion.add([userInput, reponse]);
    });
    controller.clear();
    // 👇 Scroll to bottom after short delay
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

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
                controller: _scrollController,
                itemCount: converstion.length,
                itemBuilder: (context, index) => Container(
                  child: Column(
                    children: [
                      Textmessage(msg: converstion[index][0], isUser: true),
                      SizedBox(height: 7),
                      Textmessage(msg: converstion[index][1], isUser: false),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Userinput(
                controller: controller,
                onTap: () {
                  tiggerConverstion(controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
