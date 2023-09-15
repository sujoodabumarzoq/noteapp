// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:noteapp/Features/home/presentation/manger/home_cubit.dart';
// import 'package:noteapp/Features/home/presentation/views/updata.dart';
//
// class bodyhome extends StatefulWidget {
//   const bodyhome({
//     super.key,
//   });
//
//   @override
//   State<bodyhome> createState() => _bodyhomeState();
// }
//
// class _bodyhomeState extends State<bodyhome> {
//   // List data = [];
//
//   // getdata() async {
//   //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//   //       .collection('categories')
//   //       .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//   //       .get();
//   //   data.addAll(querySnapshot.docs);
//   // }
//   //
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   //   HomeCubit.get(context).  getdataadd();
//   // }
//   void initState() {
//     super.initState();
//     HomeCubit.get(context).getdataadd();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//   create: (context) => HomeCubit()..getdata(),
//   child: BlocConsumer<HomeCubit, HomeStates>(
//   listener: (context, state) {
//     // TODO: implement listener
//   },
//   builder: (context, state) {
//     return GridView.builder(
//         padding: EdgeInsets.all(10),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, mainAxisExtent: 160),
//         itemCount: HomeCubit.get(context).data.length,
//         // data.length,
//         itemBuilder: (BuildContext context, i) {
//           return InkWell(
//             onTap: () {
//               // AwesomeDialog(
//               //   context: context,
//               //   dialogType: DialogType.warning,
//               //   animType: AnimType.rightSlide,
//               //   title: 'What does he want?',
//               //   // desc: 'Pare sure of the deleting process................',
//               //   btnCancelOnPress: () async {
//               //     await FirebaseFirestore.instance
//               //         .collection('categories')
//               //         .doc(HomeCubit. get(context).data[i].id)
//               //         .delete();
//               //     Navigator.of(context).pushReplacementNamed("Home");
//               //
//               //     // print("$id");
//               //   },
//               //   btnCancelText: "Delet",
//               //   btnOkText: "updata",
//               //   btnOkOnPress: () async {
//               //     Navigator.of(context).push(MaterialPageRoute(
//               //       builder: (context) => updata(
//               //         oidname:HomeCubit. get(context).data[i]["addcetogry"],
//               //         docid: HomeCubit. get(context).data[i].id,
//               //       ),
//               //     ));
//               //     // print("$id");
//               //   },
//               // )..show();
//             },
//             child: Card(
//                 child: Container(
//               padding: EdgeInsets.all(10),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Image.asset("images/folder.png", height: 100, width: 100),
//                     Text(
//                       "${HomeCubit.get(context).data[i]['addcetogry']}",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20),
//                     ),
//                   ],
//                 ),
//               ),
//             )),
//           );
//         });
//   },
// ),
// );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/Features/home/presentation/manger/home_cubit.dart';
import 'package:noteapp/Features/home/presentation/views/updata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:noteapp/Features/notes/presentation/home.dart';


class BodyHome extends StatelessWidget {
  final List<QueryDocumentSnapshot> data;

  BodyHome({required this.data});

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
          Navigator.of(context).
          push(MaterialPageRoute(builder: (context) {
            return Homenots(categoriesid: data[i].id,);
          },));


          // pushReplacementNamed("Homenots");

        },

    onLongPress: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              animType: AnimType.rightSlide,
              title: 'What does he want?',
              btnCancelOnPress: () async {
                await FirebaseFirestore.instance
                    .collection('categories')
                    .doc(data[i].id)
                    .delete();
                Navigator.of(context).pushReplacementNamed("Home");
              },
              btnCancelText: "Delete",
              btnOkText: "Update",
              btnOkOnPress: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UpdateCategory(
                    oidname: data[i]["addcetogry"],
                    docid: data[i].id,
                  ),
                ));
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
            ),
          ),
        );
      },
    );
  }
}

