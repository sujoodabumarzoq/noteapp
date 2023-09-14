import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
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
                title: 'ERROR',
                desc: 'Pare sure of the deleting process................',
                btnCancelOnPress: () {},
                btnOkOnPress: () async {
                  await FirebaseFirestore.instance
                      .collection('categories')
                      .doc(data[i].id)

                      .delete();
                  Navigator.of(context).pushReplacementNamed("Home");

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
