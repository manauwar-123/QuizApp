import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/auth.dart';
import 'login_screen.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({Key? key}) : super(key: key);

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  final _emailcontroller1 = TextEditingController();
  final _passwordcontroller1 = TextEditingController();
  final _passwordcontroller2 = TextEditingController();

  @override
  void dispose() {
    _emailcontroller1.dispose();
    _passwordcontroller1.dispose();
    _passwordcontroller2.dispose();
    super.dispose();
  }

  Future<void> cuweap() async {
    try {
      await Authentication().createUserWithEmailAndPassword(
          email: _emailcontroller1.text.trim(),
          password: _passwordcontroller1.text.trim());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => const MyLoginPage())));
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Already email exist", "Invalid Details",
          backgroundColor: Colors.red, colorText: Colors.white);
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
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
                        margin: const EdgeInsets.only(top: 40),
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextField(
                          controller: _emailcontroller1,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.people),
                              fillColor: Colors.blue,
                              hintText: "Enter E-mail",
                              labelText: "Enter Email",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextField(
                          controller: _passwordcontroller1,
                          obscureText: true,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Enter Password",
                              labelText: "Enter Password",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextField(
                          controller: _passwordcontroller2,
                          obscureText: true,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Confirm Password",
                              labelText: "Confirm Password",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        )),
                    InkWell(
                      onTap: () => {
                        if (_passwordcontroller1.text ==
                            _passwordcontroller2.text)
                          {cuweap()}
                        else
                          {
                            Get.snackbar(
                                "PASSWORD NOT MATCH", "Re-Enter PassWord",
                                backgroundColor: Colors.red,
                                colorText: Colors.white)
                          }
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 83, 175, 149),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                            child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const MyLoginPage())));
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: const Text(
                          "Already have an account || Press Here ||",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
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
