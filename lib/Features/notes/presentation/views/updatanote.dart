import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteapp/Features/notes/presentation/homenote.dart';
import 'package:noteapp/core/widgets/textformfield.dart';

class UpdateNote extends StatefulWidget {
  final String noteoidname;
  final String notedocid;
  final String categoriesid;

  const UpdateNote({Key? key, required this.noteoidname, required this.notedocid, required this.categoriesid});

  @override
  UpdateNoteState createState() => UpdateNoteState();
}

class UpdateNoteState extends State<UpdateNote> {
  TextEditingController noteupdate = TextEditingController();
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');

  @override
  void initState() {
    super.initState();
    noteupdate.text = widget.noteoidname;
  }

  @override
  void dispose() {
    super.dispose();
    noteupdate.dispose();
  }

  Future<void> updateNote() async {
    try {
      final noteDocRef = categories
          .doc(widget.categoriesid)
          .collection("note")
          .doc(widget.notedocid);

      final noteDocSnapshot = await noteDocRef.get();
      if (noteDocSnapshot.exists) {
        await noteDocRef.update({
          'notename': noteupdate.text,
        }).then((value) {
          print("Note Updated");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Homenots(categoriesid: widget.categoriesid),
          ));
        }).catchError((error) {
          print("Failed to update note: $error");
          // يمكنك إضافة تعامل مع الأخطاء هنا إذا كنت ترغب
        });
      } else {
        print("Document not found: ${widget.notedocid}/${widget.noteoidname}");
        // يمكنك إظهار رسالة للمستخدم أو اتخاذ إجراء آخر في حالة عدم وجود الوثيقة.
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Update Note",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            CustomTextForm(
              hinttext: "Update Note Name",
              mycontroller: noteupdate,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Note Name cannot be empty";
                }
                return null;
              },
            ),
            TextButton(
              onPressed: () {
                updateNote();
              },
              child: const Text(
                "Update Note",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
