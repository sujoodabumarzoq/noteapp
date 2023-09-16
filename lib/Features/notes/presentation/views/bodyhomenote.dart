import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:noteapp/Features/notes/presentation/homenote.dart';
import 'package:noteapp/Features/notes/presentation/views/updatanote.dart';

class BodyHomenote extends StatelessWidget {
  final List<QueryDocumentSnapshot> data;
  final String categoriesid;

  BodyHomenote({required this.data, required this.categoriesid});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 160,
      ),
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
                await FirebaseFirestore.instance
                    .collection('categories')
                    .doc(categoriesid)
                    .collection("note")
                    .doc(data[i].id)
                    .delete();

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Homenots(categoriesid: categoriesid,
                    )
                ));
              },
              btnCancelText: "Delete",
              btnOkText: "Update",
              btnOkOnPress: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UpdateNote(
                    noteoidname: data[i]["notename"],
                    notedocid: data[i].id,
                    categoriesid: categoriesid, // تم تمريره هنا
                  ),
                ));
              },
            )..show();
          },
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "${data[i]["notename"]}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
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
