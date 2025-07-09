import 'dart:convert';

import 'package:ai_chatboot/Component/TextMessage.dart';
import 'package:ai_chatboot/Component/UserInput.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  //[[user,reponse]]
  List<Map<String, dynamic>> converstion = [];
  final String apiKey =
      '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';
  Future<void> sendMessage(String userMessage) async {
    controller.clear();
    setState(() {
      converstion.add({'role': 'user', 'msg': userMessage});
      converstion.add({'role': 'ai', 'msg': 'Typing...'});
    });

    final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "deepseek/deepseek-r1:free",
        "messages": [
          {
            "role": "system",
            "content": "You are a helpful assistant and be friendly anf ansewer Allawys in short Terms using emojie.",
          },
          ...converstion
              .where((m) => m['role'] != 'ai')
              .map((m) => {"role": m['role'], "content": m['msg']}),
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reply = data['choices'][0]['message']['content'];
      setState(() {
        converstion.removeLast(); // remove "Typing..."
        converstion.add({'role': 'ai', 'msg': reply.trim()});
      });
    } else {
      setState(() {
        converstion.removeLast();
        converstion.add({
          'role': 'ai',
          'msg': '❌ Error: ${response.statusCode}',
        });
      });
    }

    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // void tiggerConverstion(TextEditingController controller) {
  //   final String userInput = controller.text;
  //   String reponse;
  //   if (userInput == "yoo") {
  //     reponse = "hh Bro yoo";
  //   } else {
  //     reponse = "Noo bro do it agian !";
  //   }
  //   setState(() {
  //     converstion.add([userInput, reponse]);
  //   });
  //   controller.clear();
  //   // 👇 Scroll to bottom after short delay
  //   Future.delayed(Duration(milliseconds: 100), () {
  //     _scrollController.animateTo(
  //       _scrollController.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 8, 2, 65),
              const Color.fromARGB(255, 5, 1, 39),
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 108, 50, 158),
                                const Color.fromARGB(255, 78, 32, 187),
                                const Color.fromARGB(255, 79, 66, 197),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Icon(Icons.smart_toy, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'AI Assistant',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Ask me anything',
                              style: TextStyle(
                                color: const Color.fromARGB(131, 255, 255, 255),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      // padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(39, 255, 255, 255),
                      ),
                      child: Center(
                        child: Icon(Icons.more_vert, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 5,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: converstion.length,
                itemBuilder: (context, index) {
                  // Textmessage(msg: converstion[index][0]??'Yoo ', isUser: true),
                  // SizedBox(height: 7),
                  // Textmessage(msg: converstion[index][1], isUser: false),
                  final msg = converstion[index];
                  return Container(
                    margin: EdgeInsets.all(8),
                    alignment: msg['role'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            if (msg['role'] == 'user') ...[
                              const Color.fromARGB(255, 108, 50, 158),
                              const Color.fromARGB(255, 78, 32, 187),
                              const Color.fromARGB(255, 79, 66, 197),
                            ] else
                              const Color.fromARGB(255, 108, 50, 158),
                              const Color.fromARGB(131, 255, 255, 255),
                            const Color.fromARGB(255, 79, 66, 197),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Text(
                        msg['msg'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 13.0),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Userinput(controller: controller)),
                  GestureDetector(
                    onTap: () {
                      sendMessage(controller.text);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 108, 50, 158),
                            const Color.fromARGB(255, 78, 32, 187),
                            const Color.fromARGB(255, 79, 66, 197),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
