import 'package:flutter/material.dart';
import 'package:quiz_app/models/constants.dart';
import 'package:quiz_app/screens/create_quiz.dart';

import 'package:quiz_app/screens/home_screen.dart';

import 'package:quiz_app/screens/landing.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? Key}) : super(key: Key);

  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QUIZ APP',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF1F8FF), Color(0xFFE3EEFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => CreateQuizPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'Create Quiz',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomeScreen(
                        parse: textEditingController.text,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: secondaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: const Color.fromARGB(255, 255, 176, 31),
                  ),
                ),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Enter quiz name',
                  ),
                  controller: textEditingController,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
