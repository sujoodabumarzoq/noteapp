import 'package:flutter/material.dart';
import 'package:noteapp/Features/home/presentation/home.dart';
import 'package:noteapp/core/widgets/textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class updata extends StatefulWidget {
//   const updata({super.key,required this.docid, required this.oidname});
//
//   final String? docid;
//   final String? oidname;
//
//   @override
//   updataState createState() => updataState();
// }
//
// class updataState extends State<updata> {
//   TextEditingController add = TextEditingController();
//   CollectionReference categories =
//       FirebaseFirestore.instance.collection('categories');
//
//   Future<void> editUser() async {
//     // Call the user's CollectionReference to add a new user
//    await categories
//       .doc(widget.docid)
//       .update({"addcetogry ": add.text}).then((value) {
//     print("User Added");
//
//     // Navigator.of(context).pushNamedAndRemoveUntil(
//     //   "Home",
//     //       (route) => false,
//     // );
//     Navigator.of(context).pop(); // عائد إلى واجهة Home
//
//    })  .catchError((error) => print("Failed to add user: $error"));
//
//   }
//
// @override
//   void initState() {
//     super.initState();
//     add.text = widget.oidname!;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Add Cetogry",
//           style: TextStyle(
//               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           children: [
//             CustomTextForm(
//               hinttext: "Add New Name Cetogry",
//               mycontroller: add,
//               validator: (val) {
//                 if (val == "") {
//                   return " Name Cetogry not empty";
//                 }
//                 return null;
//               },
//               // mycontroller: password,
//             ),
//             TextButton(
//               onPressed: () {
//                 editUser();
//                 // Navigator.of(context).pushReplacementNamed("Home");
//               },
//               child: const Text(
//                 "Save Edita",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class UpdateCategory extends StatefulWidget {
  final String oidname;
  final String docid;

  const UpdateCategory({super.key, required this.oidname, required this.docid});

  @override
  UpdateCategoryState createState() => UpdateCategoryState();
}

class UpdateCategoryState extends State<UpdateCategory> {
  TextEditingController update = TextEditingController();
  CollectionReference categories =
  FirebaseFirestore.instance.collection('categories');

  @override
  void initState() {
    super.initState();
    update.text = widget.oidname;
  }
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    update.dispose();
  }
  Future<void> updateCategory() async {
    await categories.doc(widget.docid).set({'addcetogry': update.text},SetOptions(merge: true)).then(
          (value) {
        print("Category Updated");
        Navigator.of(context).pushNamedAndRemoveUntil("Home", (route) => false);
        // Navigator.of(context).pushReplacementNamed("Home");
      },
    ).catchError((error) => print("Failed to update category: $error"));
  }
//set بتشتغل في add, updata
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Update Category",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            CustomTextForm(
              hinttext: "Update Category Name",
              mycontroller: update,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Category Name cannot be empty";
                }
                return null;
              },
            ),
            TextButton(
              onPressed: () {
                updateCategory();
              },
              child: const Text(
                "Update Category",
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