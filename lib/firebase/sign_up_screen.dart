import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Enter email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Enter password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          const Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "forgot password?",
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent, ),
              onPressed: () {},
              child: const Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const Text(
            "Register",
            style: TextStyle(
                color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}
