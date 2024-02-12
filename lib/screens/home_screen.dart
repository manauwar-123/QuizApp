import 'package:flutter/material.dart';
import 'package:quiz_app/models/constants.dart';
import 'package:quiz_app/widgets/next_button.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../models/db_connect.dart';
import '../models/fetch.dart';
import '../widgets/option_card.dart';
import '../widgets/question_widget.dart';
import '../widgets/result_box.dart';

class HomeScreen extends StatefulWidget {
  String parse;
  HomeScreen({Key? Key, required this.parse}) : super(key: Key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Quiz> fdata;
  final CountdownController _controller = CountdownController(autoStart: true);

  @override
  void initState() {
    super.initState();
    fdata = DBconnect(widget.parse).fetchQuestions();
  }

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;
  int timer = 30;

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => ResultBox(
          result: score,
          questionLength: questionLength,
          onPressed: startOver,
        ),
      );
    } else {
      if (isPressed) {
        _controller.restart();
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select any option'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20.0),
          ),
        );
      }
    }
  }

  void checkAnswerAndUpdate(List<bool> ans, value) {
    for (int i = 0; i < ans.length; i++) {
      if (isAlreadySelected) {
        return;
      } else {
        if (ans[i] == true) {
          if (i == value) {
            score++;
          }
          {
            setState(() {
              isPressed = true;
              isAlreadySelected = true;
            });
          }
        }
      }
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Quiz>(
      future: fdata,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(child: Text('Error loading data'));
        } else if (!snapshot.hasData) {
          print(fdata);
          return const Center(child: Text('No questions available.'));
        }

        var data = snapshot.data!;
        print(data);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Quiz App"),
            backgroundColor: appbar,
            shadowColor: const Color.fromARGB(0, 113, 113, 113),
            actions: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Score:  $score',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.timer_outlined,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Countdown(
                      controller: _controller,
                      seconds: timer,
                      build: (BuildContext context, double time) =>
                          Text(time.toString()),
                      interval: const Duration(seconds: 1),
                      onFinished: () {
                        isPressed = true;
                        nextQuestion(data.uid.question.length);
                        print('Timer is done!');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Container(
            color: background,
            child: Column(
              children: [
                const SizedBox(height: 30),
                QuestionWidget(
                  indexAction: index,
                  question: data.uid.question[index].que,
                  totalQuestions: data.uid.question.length,
                ),
                const SizedBox(height: 40.0),
                for (int i = 0; i < data.uid.question[index].option.length; i++)
                  GestureDetector(
                    onTap: () => checkAnswerAndUpdate(
                        data.uid.question[index].answer, i),
                    child: OptionCard(
                      option: data.uid.question[index].option[i],
                      color: isPressed
                          ? data.uid.question[index].answer[i]
                              ? correct
                              : incorrect
                          : Colors.white,
                    ),
                  ),
              ],
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: () => nextQuestion(data.uid.question.length),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: NextButton(),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
