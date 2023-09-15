import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteapp/Features/home/presentation/views/addcetogry.dart';
import 'package:noteapp/Features/home/presentation/views/bodyhome.dart';
import 'package:noteapp/Features/notes/presentation/views/bodyhome.dart';

class Homenots extends StatefulWidget {
  const Homenots({Key? key, required this.categoriesid}) : super(key: key);
final String categoriesid;
  @override
  HomenotsState createState() => HomenotsState();
}

class HomenotsState extends State<Homenots> {
  bool isloading = true;
  List<QueryDocumentSnapshot> data = [];

  Future<void> getdata() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('categories').doc(widget.categoriesid).collection("note").get();
    data.addAll(querySnapshot.docs);
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Notes",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googlesignin = GoogleSignIn();
              await googlesignin.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed("login");
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
              size: 30,
            ),
          )
        ],
      ),
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : BodyHomenote(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCategory()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
