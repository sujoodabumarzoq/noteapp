import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/core/widgets/custombuttonauth.dart';
import 'package:noteapp/core/widgets/customlogoauth.dart';
import 'package:noteapp/core/widgets/textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 50),
                const CustomLogoAuth(),
                Container(height: 20),
                const Text("SignUp",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Container(height: 10),
                const Text("SignUp To Continue Using The App",
                    style: TextStyle(color: Colors.grey)),
                Container(height: 20),
                const Text(
                  "username",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your username",
                  mycontroller: username,
                  validator: (val) {
                    if (val == "") {
                      return " name not empty";
                    }
                    return null;
                  },
                ),
                Container(height: 20),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your Email",
                  mycontroller: email,
                  validator: (val) {
                    if (val == "") {
                      return " email not empty";
                    }
                    return null;
                  },
                ),
                Container(height: 10),
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your Password",
                  mycontroller: password,
                  validator: (val) {
                    if (val == "") {
                      return " email not empty";
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  alignment: Alignment.topRight,
                  child: const Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomButtonAuth(
              title: "SignUp",
              onPressed: () async {
                if (formState.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    if (credential.user!.emailVerified) {
                      Navigator.of(context).pushReplacementNamed("Home");
                    } else {
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Check email',
                        desc:
                        'Verify your e-mail by clicking on the link in the e-mail................',
                        // btnCancelOnPress: () {},
                        // btnOkOnPress: () {},
                      )..show();

                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Password weak',
                        desc: 'The password provided is too weak..............',
                        // btnCancelOnPress: () {},
                        // btnOkOnPress: () {},
                      )..show();
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'EmailAlreadyinuse',
                        desc:
                            'The account already exists for that email...............',
                        // btnCancelOnPress: () {},
                        // btnOkOnPress: () {},
                      )..show();

                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              }),

          Container(height: 20),

          Container(height: 20),
          // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("login");
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Have An Account ? ",
                ),
                TextSpan(
                    text: "Login",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
              ])),
            ),
          )
        ]),
      ),
    );
  }
}
