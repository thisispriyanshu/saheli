// import 'dart:convert';
// import 'package:hive/hive.dart';
// import 'package:http/http.dart' as http;
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
//
// import 'geminiAuth.dart';
//
// // ignore: must_be_immutable
// class GeminiBot extends StatefulWidget {
//   const GeminiBot({super.key});
//
//   @override
//   State<GeminiBot> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<GeminiBot> {
//   List<ChatUser> typing = [];
//
//   List savedMessages = [];
//
//   List<ChatMessage> allMessages = [];
//   //
//   // final box = Hive.box(userData);
//   // final box2 = Hive.box(boxName);
//   ChatUser myself=ChatUser(id: '1',firstName: 'You');
//   ChatUser bot=ChatUser(id: '2', firstName: 'Sakha');
//
//
//   getData() {
//     // return box2.get('name');
//   }
//
//   @override
//   void dispose() async {
//     await Hive.close();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//
//     if (savedMessages.isEmpty) {
//       firstTime();
//     }
//     fetchData();
//   }
//
//   savingData(ChatMessage message) async {
//     var text = message.text;
//     var user = [message.user.id, message.user.firstName, message.user.lastName];
//     var time = message.createdAt.toString();
//
//     savedMessages.add([
//       text,
//       [user, time]
//     ]);
//
//   }
//
//   firstTime() {
//     var mess = ChatMessage(
//         createdAt: DateTime.now(),
//         text: 'Hi ${myself.firstName} I am your Sakha',
//         user: bot);
//     allMessages.insert(0, mess);
//     setState(() {});
//   }
//
//   fetchData() {
//     ChatUser any;
//
//     for (var element in savedMessages) {
//       if (myself.id.toString() == element[1][0][0].toString()) {
//         any = myself;
//       } else {
//         any = bot;
//       }
//       ChatMessage message = ChatMessage(
//           text: element[0],
//           user: any,
//           createdAt: DateTime.parse(element[1][1]));
//       allMessages.insert(0,message);
//       setState(() {});
//     }
//   }
//
//   getdata(ChatMessage message) async {
//     allMessages.insert(0, message);
//     typing.add(bot);
//     setState(() async {
//       await savingData(message);
//     });
//     const headers = {'Content-Type': 'application/json'};
//     const url =

//     var body = {
//       "contents": [
//         {
//           "parts": [
//             {"text": message.text}
//           ]
//         }
//       ]
//     };
//
//     await http
//         .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
//         .then(
//           (value) {
//         var result = jsonDecode(value.body);
//         var output = result["candidates"][0]['content']['parts'][0]['text'];
//         var m = ChatMessage(user: bot, createdAt: DateTime.now(), text: output);
//         typing.remove(bot);
//         allMessages.insert(0, m);
//
//         setState(() async {
//           await savingData(m);
//         });
//       },
//     ).catchError((onError) {
//       ChatMessage errorMessage =
//       ChatMessage(user: bot, createdAt: DateTime.now());
//       allMessages.insert(0, errorMessage);
//       setState(() async {
//         await savingData(errorMessage);
//       });
//     });
//   }
//
//   MessageOptions messageOptions = const MessageOptions(
//       currentUserTextColor: Colors.black,
//       showCurrentUserAvatar: true,
//       currentUserContainerColor: Color.fromARGB(255, 188, 188, 188),
//       containerColor: Colors.pinkAccent);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Gemini Bot'),),
//       backgroundColor:  Colors.white,
//       body: DashChat(
//         currentUser: myself,
//         onSend: (ChatMessage m){
//           getData();
//         },
//         messages: allMessages,
//         typingUsers: typing,
//         messageOptions: messageOptions,
//       ),
//     );
//   }
// }