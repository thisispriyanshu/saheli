import 'dart:convert';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatScreen> {
  Color clr1 = Colors.pinkAccent;
  final messageController = TextEditingController();
  List<Map> messages = [];

  Future<void> getResponse(String userInput) async {

      setState(() {
        messages.insert(0, {"data": 0, "message": "..."});
      });
      final response = await http.post(
        Uri.parse("https://gemini-chatbot-e4no.onrender.com/chat"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'query': userInput}),
      );

      if (response.statusCode == 200) {
        // Map<String, dynamic> data = jsonDecode(response.body);
        // String textResponse = data['response'];
        String textResponse =jsonDecode(response.body);

        // Parse special characters and apply formatting
        textResponse =
            textResponse.replaceAll('', ''); // Remove the ** for bold text
        textResponse = textResponse.replaceAll(
            '\n\n', ''); // Split text by double newline to separate steps
        textResponse = textResponse.replaceAll('*', '');
        setState(() {
          messages.removeAt(0);
          messages.insert(0, {"data": 0, "message": textResponse});
        });
      } else {
        throw Exception('Failed to load response');
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     "Kiran",
      //     style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 24),
      //   ),
      //   backgroundColor: Theme.of(context).colorScheme.tertiary,
      // ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Expanded(
              child: Image.asset('lib/assets/images/KiranBg.png', fit: BoxFit.cover,)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kiran AI',
                style: GoogleFonts.outfit(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Your personalised chat bot \n'
                    'ready to help you anytime',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, bottom: 10, top: 0.0),
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: chatBubble(messages[index]["message"].toString(),
                          messages[index]["data"]),
                    ),
                  ),
                ),
                Container(
                  child: ListTile(
                    title: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                            hintText: "Ask anything...",
                            hintStyle: GoogleFonts.outfit(),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none),
                        cursorColor: clr1,
                      ),
                    ),
                    trailing: GestureDetector(
                      child: Icon(Icons.send_outlined, color: clr1),
                      onTap: () {
                        setState(() {
                          messages.insert(0,
                              {"data": 1, "message": messageController.text});
                        });
                        getResponse(messageController.text);
                        messageController.clear();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chatBubble(String message, int data) {
    // final alignment = data == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    // / Add space on the left for received messages
    return BubbleSpecialOne(
      color: (data == 1) ? Colors.pinkAccent : Colors.pink,
      isSender: data == 1,
      text: message,
      textStyle: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}
