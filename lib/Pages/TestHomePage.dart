import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestHomePage extends StatefulWidget {
  const TestHomePage({super.key});

  @override
  State<TestHomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [];
  final ScrollController _scrollController = ScrollController();
  final String apiKey = ''; // 👈 Paste your OpenRouter API key here
  Future<void> sendMessage(String userMessage) async {
    setState(() {
      messages.add({'role': 'user', 'msg': userMessage});
      messages.add({'role': 'ai', 'msg': 'Typing...'});
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
          {"role": "system", "content": "You are a helpful assistant."},
          ...messages.where((m) => m['role'] != 'ai').map((m) => {
                "role": m['role'],
                "content": m['msg'],
              }),
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reply = data['choices'][0]['message']['content'];
      setState(() {
        messages.removeLast(); // remove "Typing..."
        messages.add({'role': 'ai', 'msg': reply.trim()});
      });
    } else {
      setState(() {
        messages.removeLast();
        messages.add({'role': 'ai', 'msg': '❌ Error: ${response.statusCode}'});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DeepSeek AI Chat"),
        ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Container(
                  margin: EdgeInsets.all(8),
                  alignment: msg['role'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: msg['role'] == 'user'
                          ? Colors.blue[100]
                          : Colors.green[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(msg['msg']),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        InputDecoration(hintText: 'Type your message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      sendMessage(text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
