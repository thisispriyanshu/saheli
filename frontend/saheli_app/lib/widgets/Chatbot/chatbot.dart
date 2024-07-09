import 'dart:convert';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  bool isChatLoaded = false;
  bool progressBar = false;

  final List<String> suggestions = [
    'Feeling Alone',
    'Feeling Unconfident',
    'I am Panicked',
    'Need Self Defense Tips',
    'Need Insight On Women Safety',
    'Feeling Uneasy'
  ];

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
      String textResponse = jsonDecode(response.body);

      // Parse special characters and apply formatting
      textResponse =
          textResponse.replaceAll('', ''); // Remove the ** for bold text
      textResponse = textResponse.replaceAll(
          '\n\n', ''); // Split text by double newline to separate steps
      textResponse = textResponse.replaceAll('*', '');
      setState(() {
        isChatLoaded = true;
        messages.removeAt(0);
        messages.insert(0, {"data": 0, "message": textResponse});
      });
    } else {
      throw Exception('Failed to load response');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChatLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sakha",
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 32),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: isChatLoaded
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      spacing: 2.0,
                      children: suggestions.map((text) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffF7EDF5),
                                elevation: 0,
                                side: BorderSide(color: Colors.black54)),
                            onPressed: () {
                              setState(() {
                                messages.insert(0, {
                                  "data": 1,
                                  "message": text
                                });
                              });
                              getResponse(text);
                            },
                            child: Text(
                              text,
                              style: GoogleFonts.outfit(color: Colors.black45),
                            ));
                      }).toList(),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: 520,
                      child: Stack(
                        //fit: StackFit.expand,
                        children: [
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                      child: chatBubble(
                                          messages[index]["message"].toString(),
                                          messages[index]["data"]),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: progressBar
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Chat is loading...',
                          style: GoogleFonts.outfit(fontSize: 16),
                        )
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          progressBar = true;
                        });
                        getResponse('hello');
                      },
                      child: Text(
                        'Load Chat',
                        style: GoogleFonts.outfit(
                            color: Colors.white, fontSize: 20),
                      )),
            ),
        bottomNavigationBar: Container(
          child: ListTile(
            title: Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .tertiary,
                  border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                      width: 1),
                  borderRadius: BorderRadius.all(
                      Radius.circular(18))),
              child: TextFormField(
                controller: messageController,
                decoration: InputDecoration(
                    hintText: "Ask anything...",
                    hintStyle: GoogleFonts.outfit(),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary),
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none),
                cursorColor: clr1,
              ),
            ),
            trailing: GestureDetector(
              child:
              Icon(Icons.send_outlined, color: clr1),
              onTap: () {
                setState(() {
                  messages.insert(0, {
                    "data": 1,
                    "message": messageController.text
                  });
                });
                getResponse(messageController.text);
                messageController.clear();
              },
            ),
          ),
        ),
    );
  }

  Widget chatBubble(String message, int data) {
    // final alignment = data == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    // / Add space on the left for received messages
    return BubbleSpecialOne(
      color: (data == 1) ? Color(0xffFEECEB) : Color(0xffF7EDF5),
      isSender: data == 1,
      text: message,
      textStyle: GoogleFonts.outfit(
        fontSize: 18,
        color: Colors.black54,
      ),
    );
  }
}