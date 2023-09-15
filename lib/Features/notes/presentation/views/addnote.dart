import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/Features/notes/presentation/homenote.dart';
import 'package:noteapp/core/widgets/textformfield.dart';

class AddNote extends StatefulWidget {
  final String docid;

  const AddNote({Key? key, required this.docid}) : super(key: key);
  @override
  AddNoteState createState() => AddNoteState();
}

class AddNoteState extends State<AddNote> {
  TextEditingController notename = TextEditingController();

  Future<void> addnotes() async {
    try {
      CollectionReference note = FirebaseFirestore.instance
          .collection('categories')
          .doc(widget.docid)
          .collection("note");
      await note.add({
        'notename': notename.text,
      }).then((value) {
        print("notename Added");
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Homenots(categoriesid: widget.docid,);
        },));
      }).catchError((error) {
        print("Failed to add note: $error");
        // يمكنك إضافة تعامل مع الأخطاء هنا إذا كنت ترغب
      });
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  void dispose() {
    super.dispose();
    notename.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Add Note",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            CustomTextForm(
              hinttext: "Add Note Name",
              mycontroller: notename,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Note Name cannot be empty";
                }
                return null;
              },
            ),
            TextButton(
              onPressed: () {
                addnotes();
              },
              child: const Text(
                "Add Note",
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
