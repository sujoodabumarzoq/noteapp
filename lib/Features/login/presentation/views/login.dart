import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/core/widgets/custombuttonauth.dart';
import 'package:noteapp/core/widgets/customlogoauth.dart';
import 'package:noteapp/core/widgets/textformfield.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool isloading = false ;

  Future signInWithGoogle() async {
    // Trigger the authentication flow'
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushReplacementNamed("Home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   isloading ==true?Center(
          child: CircularProgressIndicator()
      ): Container(
        padding: const EdgeInsets.all(20),
        color: Colors.transparent,
        child: ListView(children: [
          Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 50),
                const CustomLogoAuth(),
                Container(height: 20),
                const Text("Login",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Container(height: 10),
                const Text("Login To Continue Using The App",
                    style: TextStyle(color: Colors.grey)),
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
                      return " password not empty";
                    }
                    return null;
                  },
                ),
                InkWell(
                  onTap: () async {
                    if (email.text == null){
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'ERROR',
                        desc:
                        'Please write an email................',
                        // btnCancelOnPress: () {},
                        // btnOkOnPress: () {},
                      )..show();
                    }
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.text);
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Check email',
                        desc:
                        'Check the email we sent the code................',
                        // btnCancelOnPress: () {},
                        // btnOkOnPress: () {},
                      )..show();
                    } catch(e) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Email not found',
                            desc: 'No user found for that email...............',
                            // btnCancelOnPress: () {},
                            // btnOkOnPress: () {},
                          )..show();
                    }

                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomButtonAuth(
              title: "login",
              onPressed: () async {
                // Navigator.of(context).pushReplacementNamed("Home",arguments: email);

                if (formState.currentState!.validate()) {
                  try {
                    isloading = true ;
setState(() {

});
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                    isloading = false ;
                    setState(() {

                    });
                    if (credential.user!.emailVerified) {
                  Navigator.of(context)
                          .pushReplacementNamed("Home", arguments: email);
                    } else {
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
                    isloading = false ;
                    setState(() {

                    });
                    if (e.code == 'user-not-found') {

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Email not found',
                        desc: 'No user found for that email...............',
                        // btnCancelOnPress: () {},
                        // btnOkOnPress: () {},
                      )..show();

                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Wrong password',
                        desc:
                            'Wrong password provided for that user................',
                        // btnCancelOnPress: () {},
                        // btnOkOnPress: () {},
                      )..show();

                      print('Wrong password provided for that user.');
                    }
                  }
                }
              }),
          Container(height: 20),

          MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.red[700],
              textColor: Colors.white,
              onPressed: () {
                signInWithGoogle();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login With Google  "),
                  Image.asset(
                    "images/4.png",
                    width: 20,
                  )
                ],
              )),
          Container(height: 20),
          // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("signup");
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Don't Have An Account ? ",
                ),
                TextSpan(
                    text: "Register",
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
