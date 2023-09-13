import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            GoogleSignIn googlesignin = GoogleSignIn();
            googlesignin.disconnect();
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed("login");

          }, icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: ListView(

        children: [
      const Text("welcoom ?"),
        ],
      ),
    );
  }
}
