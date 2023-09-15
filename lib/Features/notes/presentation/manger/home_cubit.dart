// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'home_state.dart';
//
// class HomeCubit extends Cubit<HomeStates> {
//   HomeCubit() : super(HomeInitial());
//   // List getdatalist = [];
//
//   static HomeCubit get(context) => BlocProvider.of(context);
//   CollectionReference categories =
//       FirebaseFirestore.instance.collection('categories');
//   List<QueryDocumentSnapshot> data = [];
//   TextEditingController add = TextEditingController(); // إضافة المتغير هنا
//
//   getdata() async {
//     // isloading = false;
//
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('categories').get();
//     data.addAll(querySnapshot.docs);
//     emit(HomeCREATData());
//   }
//
//   Future<void> addcategories() {
//     return categories.add({
//       'addcetogry': add.text,
//       'id': FirebaseAuth.instance.currentUser!.uid,
//     }).then((value) {
//       print("User Added");
//       emit(HomeaddData()); // إصدار التحديث هنا بعد النجاح
//     }).catchError((error) => print("Failed to add user: $error"));
//   }
//
//   Future<void> getdataadd() async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('categories')
//           .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//           .get();
//       data.addAll(querySnapshot.docs);
//       emit(Homegetdataadd());
//     } catch (error) {
//       print("Failed to get data: $error");
//     }
//   }
//
// }
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  CollectionReference categories =
  FirebaseFirestore.instance.collection('categories');
  List<QueryDocumentSnapshot> data = [];
  TextEditingController add = TextEditingController();

  getdata() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('categories').get();
      data.addAll(querySnapshot.docs);
      emit(HomeCREATData());
    } catch (error) {
      print("Failed to get data: $error");
    }
  }

  Future<void> addcategories() {
    return categories.add({
      'addcetogry': add.text,
      'id': FirebaseAuth.instance.currentUser!.uid,
    }).then((value) {
      print("User Added");
      emit(HomeaddData());
    }).catchError((error) => print("Failed to add user: $error"));
  }
}
