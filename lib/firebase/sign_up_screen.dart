import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapp/firebase/auth/auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color color = Colors.deepOrangeAccent;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "images/fire.png",
              height: 200,
              width: 200,
            ),
          ),
          Center(
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(text: "Welcome to ", style: TextStyle(fontSize: 26)),
                  TextSpan(
                    text: "Fire Chat",
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Enter email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: "Enter password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => ResetPasswordClicked(),
                child: const Text(
                  "forgot password?",
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
              ),
              onPressed: () => loginClicked(),
              child: const Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => registerClicked(),
            child: const Text(
              "Register",
              style: TextStyle(
                  color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Future<void> loginClicked() async {
    try {
      await Auth().signIn(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
    } on FirebaseException catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  Future<void> registerClicked() async {
    try {
      await Auth().createAccount(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
    } on FirebaseException catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  Future<void> ResetPasswordClicked() async {
    try {
      await Auth().createAccount(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
    } on FirebaseException catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }
}
