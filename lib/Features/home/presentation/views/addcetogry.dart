import 'package:flutter/material.dart';
import 'package:noteapp/core/widgets/textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Addcetogry extends StatefulWidget {
  const Addcetogry({super.key});

  @override
  AddcetogryState createState() => AddcetogryState();
}

class AddcetogryState extends State<Addcetogry> {
  TextEditingController add = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return categories
        .add({
          'addcetogry': add.text, // John Doe
        })
        .then((value) => print("User Added")

    )

        .catchError((error) => print("Failed to add user: $error"));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Add Cetogry",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            CustomTextForm(
              hinttext: "Add Name Cetogry",
              mycontroller: add,
              validator: (val) {
                if (val == "") {
                  return " Name Cetogry not empty";
                }
                return null;
              },
              // mycontroller: password,
            ),
            TextButton(
              onPressed: () {
                addUser();
                Navigator.of(context).pushReplacementNamed("Home");

              },
              child: const Text(
                "Add Cetogry",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
