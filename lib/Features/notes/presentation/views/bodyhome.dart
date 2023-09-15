import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/Features/home/presentation/views/updata.dart';

class BodyHomenote extends StatelessWidget {
  final List<QueryDocumentSnapshot> data =[];

   BodyHomenote({super.key,});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
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
              btnCancelOnPress: () async {
                // await FirebaseFirestore.instance
                //     .collection('categories')
                //     .doc(data[i].id)
                //     .delete();
                // Navigator.of(context).pushReplacementNamed("Home");
              },
              btnCancelText: "Delete",
              btnOkText: "Update",
              btnOkOnPress: () async {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => UpdateCategory(
                //     oidname: data[i]["addcetogry"],
                //     docid: data[i].id,
                //   ),
                // ));
              },
            )..show();
          },
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Image.asset("images/folder.png", height: 100, width: 100),
                    Text(
                      "${data[i]['note']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}