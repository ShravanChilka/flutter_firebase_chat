import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List messages = [
      [true, "Heyy"],
      [false, "Heyy there!"],
      [false, "How was your day"],
      [true, "Great, wbu"],
      [true, "Lets meet"],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fire Chat"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (messages[index][0]) {
                  return sentLayout(messages[index][1]);
                } else {
                  return receivedLayout(messages[index][1]);
                }
              },
              itemCount: messages.length,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/fire.png",
                width: 50,
                height: 50,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Send Message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.deepOrangeAccent,
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget sentLayout(String message) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    alignment: Alignment.centerRight,
    child: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          color: Colors.deepOrangeAccent),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 13),
      child: Text(message),
    ),
  );
}

Widget receivedLayout(String message) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    alignment: Alignment.centerLeft,
    child: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Colors.white),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 13),
      child: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
    ),
  );
}
