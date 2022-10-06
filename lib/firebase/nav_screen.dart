import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapp/firebase/chat_screen.dart';
import 'package:flutter_mapp/firebase/sign_up_screen.dart';
import 'package:provider/provider.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    return FutureBuilder(
      future: _reload(user: user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (user != null) {
            // user already logged in
            return const ChatScreen();
          } else {
            // new user
            return const SignUpScreen();
          }
        }
      },
    );
  }

  Future _reload({User? user}) async {
    await user?.reload();
  }
}
