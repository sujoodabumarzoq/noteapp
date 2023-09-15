import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/Features/home/presentation/home.dart';
import 'package:noteapp/Features/home/presentation/manger/home_cubit.dart';
import 'package:noteapp/Features/home/presentation/views/addcetogry.dart';
import 'package:noteapp/Features/home/presentation/views/updata.dart';
import 'package:noteapp/Features/login/presentation/views/login.dart';
import 'package:noteapp/Features/notes/presentation/home.dart';
import 'package:noteapp/core/constants.dart';
import 'package:noteapp/firebase_options.dart';

import 'Features/signup/presentation/views/signup.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('**************************User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(), // تأكد من تقديم HomeCubit هنا
        )

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //لو كام لا يساوي فارغ و هاذا المستخدام تحقق من بريد انقلني ع هوم بيج لو لا انقلني ع لوجن
        home: (FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified)
            ? Home()
            : Login(),
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black, size: 28))),
        // home: FirebaseAuth.instance.currentUser==null? Login():Home(),
        routes: {
          "signup": (context) => const SignUp(),
          "login": (context) => const Login(),
          "Home": (context) => const Home(),
          "Addcetogry": (context) =>  AddCategory(),
        },
      ),
    );
  }
}
