import 'dart:convert';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
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
    if(userInput=='Hi'){
      messages.insert(0, {"data": 0, "message": "Hello! Welcome to Sakha, your Personalised Safety Assistant. How can Sakha help you today?"});
    }
    else if(userInput=='Give me some safety tips'){
      messages.insert(0, {"data": 0, "message": "Sure! Here are some safety tips from Sakha: Always be aware of your surroundings, avoid poorly lit areas, and share your location with someone you trust when heading out."});
    }
    else {
      setState(() {
        messages.insert(0, {"data": 0, "message": "..."});
      });
      final response = await http.post(
        Uri.parse("https://saheli-backend-ufs3.onrender.com/chat"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'userInput': userInput}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        String textResponse = data['response'];
        print(textResponse);

        // Parse special characters and apply formatting
        textResponse =
            textResponse.replaceAll('**', ''); // Remove the ** for bold text
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Sakha AI'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sakha AI',
                style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
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
                      child: chatBubble(
                          messages[index]["message"].toString(),
                          messages[index]["data"]),
                    ),
                  ),
                ),
                Container(
                  child: ListTile(
                    title: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffF2F4F6),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                            hintText: "Ask anything...",
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
                          messages.insert(0, {"data": 1, "message": messageController.text});
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
          color: (data==1)?Colors.pinkAccent: Colors.pink,
          isSender: data==1,
          text: message,
          textStyle: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          );


  }
  }
