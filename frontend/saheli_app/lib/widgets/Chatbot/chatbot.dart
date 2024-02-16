import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatScreen> {
  Color clr1 = Colors.pinkAccent;
  late DialogFlowtter instance;
  final messageController = new TextEditingController();
  Future<void> getInstance() async {
    instance = await DialogFlowtter.fromFile(
        path: "assets/dialog_flow_auth.json",
        sessionId: "any_random_string_will_do");
  }

  @override
  void initState() {
    getInstance();
    super.initState();
  }

  @override
  void dispose() {
    instance.dispose();
    super.dispose();
  }

  List<Map> messsages = [];

  Future<void> getResponse() async {
    DetectIntentResponse response = await instance.detectIntent(
      queryInput: QueryInput(text: TextInput(text: messageController.text)),
    );
    String? textResponse = response.text;
    print(textResponse);
    setState(() {
      messsages.insert(0, {"data": 0, "message": textResponse});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
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
                        hintText: "Send Message",
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
                    getResponse();
                    setState(() {
                      messsages.insert(
                          0, {"data": 1, "message": messageController.text});
                    });
                    messageController.clear();
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundColor: clr1,
                    child: Text("Sakha", style: TextStyle(color: Colors.white)),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: Card(
                color: data == 0 ? Colors.white : clr1,
                elevation: 0.0,
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 10.0, top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: data == 0
                              ? TextStyle(
                                  color: clr1, fontWeight: FontWeight.bold)
                              : TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
                  child: CircleAvatar(
                    minRadius: 30,
                    child: CircleAvatar(
                      minRadius: 29,
                      backgroundColor: Colors.white,
                      child: Text("You", style: TextStyle(color: clr1)),
                    ),
                    backgroundColor: clr1,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
