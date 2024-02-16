import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saheli_app/views/home_screen.dart';
import 'package:saheli_app/views/signup.dart';
import 'package:saheli_app/widgets/bottomNavBar.dart';

import '../common/widgets/customBtn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.70,
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please enter a valid email");
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _isObscure3,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(
                                  _isObscure3
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).colorScheme.primary),
                              onPressed: () {
                                setState(() {
                                  _isObscure3 = !_isObscure3;
                                });
                              }),
                          filled: true,
                          fillColor: Colors.transparent,
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 15.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          }
                          if (!regex.hasMatch(value)) {
                            return ("please enter valid password min. 6 character");
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New Here? ", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()));
                              },
                              child: Text("Register", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),)),
                          SizedBox(width: 60,),
                          CustomBtn(
                              msg: "Login",
                              onTap: () {
                                login(emailController.text,
                                    passwordController.text);
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: visible,
                          child: Container(
                              child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ))),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void login(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Fluttertoast.showToast(
            msg: "Logged in successfully", toastLength: Toast.LENGTH_SHORT);
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  void route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavBar(),
      ),
    );
  }
}
