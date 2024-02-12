import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/auth.dart';

import 'package:quiz_app/screens/landing.dart';
import 'package:quiz_app/screens/signup_screen.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  final User? user = Authentication().currentuser;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  Future<void> siweap() async {
    try {
      log('here');
      await Authentication().signInWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim(),
      );
      log('here 2');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => MyHomePage())),
      );
      log('here 3');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Kuch Tho Gadbad Hai",
        "Invalid Details",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(e);
    } catch (e) {
      // Catch any other unexpected exceptions
      print(e);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 130,
              width: 375,
              child: Image.asset(
                "images/login.png",
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: _emailcontroller,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.people),
                              fillColor: Colors.blue,
                              hintText: "Enter Email",
                              labelText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: _passwordcontroller,
                          obscureText: true,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Enter Password",
                              labelText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => const MySignUpPage())));
                          },
                          child: Container(
                            width: 30 * 6.5,
                            height: 10 * 4.5,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 3, 92, 67),
                                borderRadius: BorderRadius.circular(30)),
                            margin: EdgeInsets.only(left: 20, top: 20),
                            child: const Center(
                                child: Text(
                              "Don't have an account",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            siweap();
                          },
                          child: Container(
                            width: 10 * 4.5,
                            height: 10 * 4.5,
                            margin: EdgeInsets.only(right: 20, top: 20),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 83, 175, 149),
                                borderRadius: BorderRadius.circular(30)),
                            child: const Center(
                                child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            )),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
