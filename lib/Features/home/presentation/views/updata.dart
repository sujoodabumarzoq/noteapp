import 'package:flutter/material.dart';
import 'package:noteapp/core/widgets/textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class updata extends StatefulWidget {
  const updata({super.key,required this.docid, required this.oidname});

  final String? docid;
  final String? oidname;

  @override
  updataState createState() => updataState();
}

class updataState extends State<updata> {
  TextEditingController add = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Future<void> editUser() async {
    // Call the user's CollectionReference to add a new user
   await categories
      .doc(widget.docid)
      .update({"addcetogry ": add.text}).then((value) {
    print("User Added");

    Navigator.of(context).pushNamedAndRemoveUntil(
      "Home",
          (route) => false,
    );
  })  .catchError((error) => print("Failed to add user: $error"));

  }

@override
  void initState() {
    super.initState();
    add.text = widget.oidname!;
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
              hinttext: "Add New Name Cetogry",
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
                editUser();
                // Navigator.of(context).pushReplacementNamed("Home");
              },
              child: const Text(
                "Save Edita",
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
