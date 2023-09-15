import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/Features/home/presentation/views/updata.dart';

class bodyhome extends StatefulWidget {
  const bodyhome({
    super.key,
  });

  @override
  State<bodyhome> createState() => _bodyhomeState();
}

class _bodyhomeState extends State<bodyhome> {
  List data = [];

  getdata() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(querySnapshot.docs);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 160),
        itemCount: data.length,
        itemBuilder: (BuildContext context, i) {
          return InkWell(
            onTap: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                title: 'What does he want?',
                // desc: 'Pare sure of the deleting process................',
                btnCancelOnPress: () async {
                  await FirebaseFirestore.instance
                      .collection('categories')
                      .doc(data[i].id)
                      .delete();
                  Navigator.of(context).pushReplacementNamed("Home");

                  // print("$id");
                },
                btnCancelText: "Delet",
                btnOkText: "updata",
                btnOkOnPress: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => updata(
                      oidname:data[i]["addcetogry"],
                      docid: data[i].id,
                    ),
                  ));
                  // print("$id");
                },
              )..show();
            },
            child: Card(
                child: Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("images/folder.png", height: 100, width: 100),
                    Text(
                      "${data[i]['addcetogry']}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            )),
          );
        });
  }
}
