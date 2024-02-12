// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:quiz_app/models/constants.dart';
import '../constants.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {Key? Key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions})
      : super(key: Key);
// here we need the question title and the total number of question , and also the index.
  final String question;
  final int indexAction;
  final int totalQuestions;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Question: ',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w800, fontSize: 32),
          ),
          Text(
            ' ${indexAction + 1}/$totalQuestions: $question',
            style: TextStyle(
                fontSize: 28.0,
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
