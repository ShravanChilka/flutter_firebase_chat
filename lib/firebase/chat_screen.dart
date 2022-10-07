import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapp/firebase/auth/auth.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();
  List<MessageData> list = [];

  // Future<void> getMessages() async {
  //   CollectionReference collectionRef =
  //       FirebaseFirestore.instance.collection('messages');
  //   QuerySnapshot querySnapshot = await collectionRef.get();
  //   final allData = querySnapshot.docs
  //       .map((doc) => MessageData.fromMap(doc.data() as Map<String, dynamic>))
  //       .toList();
  //   setState(() {
  //     list = allData;
  //   });
  //
  //   await db
  //       .collection("messages")
  //       .get()
  //       .then(
  //         (value) => (doc) {
  //           setState(() {
  //             list.add(MessageData(
  //                 uid: '${doc["uid"]}', message: "${doc["message"]}"));
  //           });
  //         },
  //       )
  //       .then((value) => printMessages());
  // }

  printMessages() {
    for (int i = 0; i < list.length; i++) {
      debugPrint(list[i].message.toString());
    }
  }

  Future<void> sendClicked(String message) async {
    await db.collection("messages").add({
      "uid": Auth().currentUser!.uid.toString(),
      "message": message,
    });
    messageController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fire Chat"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => signOutClicked(),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: db.collection("messages").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final allData = snapshot.data?.docs
                  .map((doc) =>
                      MessageData.fromMap(doc.data() as Map<String, dynamic>))
                  .toList();
              list = allData!;
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (list[index].uid ==
                          Auth().currentUser!.uid.toString()) {
                        return sentLayout(list[index].message);
                      } else {
                        return receivedLayout(list[index].message);
                      }
                    },
                    itemCount: list.length,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => sendClicked("fire"),
                      child: Image.asset(
                        "images/fire.png",
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: messageController,
                          decoration: const InputDecoration(
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
                          onPressed: () =>
                              sendClicked(messageController.text.toString()),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }

  Future<void> signOutClicked() async {
    await Auth().signOut();
  }
}

class MessageData {
  String uid;
  String message;

  MessageData({required this.uid, required this.message});

  static MessageData fromMap(Map<String, dynamic> map) {
    return MessageData(uid: map["uid"], message: map["message"]);
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
      child: message == "fire"
          ? Image.asset("images/fire.png", width: 100, height: 100)
          : Text(message),
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
      child: message == "fire"
          ? Image.asset("images/fire.png", width: 100, height: 100)
          : Text(message, style: const TextStyle(color: Colors.black)),
    ),
  );
}
