import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteapp/Features/home/presentation/views/addcetogry.dart';
import 'package:noteapp/Features/home/presentation/views/bodyhome.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Home",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googlesignin = GoogleSignIn();
                googlesignin.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed("login");
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      body: bodyhome(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addcetogry()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

