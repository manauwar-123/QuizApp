import 'package:flutter/material.dart';
import 'package:quiz_app/models/addData.dart';

import '../models/quiz.dart';

class CreateQuizPage extends StatefulWidget {
  @override
  _CreateQuizPageState createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final TextEditingController _quizNameController = TextEditingController();
  final List<Question> _questions = [];
  bool _submitted = false;

  String firebaseUrl =
      "https://simplequiapp-default-rtdb.firebaseio.com/question.json";

  // Create an instance of FirebaseDataManager

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: _submitted
              ? _buildSubmissionMessage()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _quizNameController,
                      decoration: InputDecoration(labelText: 'Quiz Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a quiz name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    for (int i = 0; i < _questions.length; i++)
                      Column(
                        key: ValueKey<int>(i),
                        children: [
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Question ${i + 1}'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a question';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _questions[i].question = value;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          for (int j = 0; j < 4; j++)
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Option ${j + 1}'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter an option';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _questions[i].options![j] = value;
                                      });
                                    },
                                  ),
                                ),
                                Checkbox(
                                  value: _questions[i].correctAnswers![j],
                                  onChanged: (value) {
                                    setState(() {
                                      _questions[i].correctAnswers![j] =
                                          value ?? false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          SizedBox(height: 16),
                        ],
                      ),
                    if (_questions.isNotEmpty) SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _addQuestion();
                      },
                      child: Text('Add Question'),
                    ),
                    if (_questions.isNotEmpty) SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _submitQuiz();
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildSubmissionMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Quiz Submitted!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text('Quiz Name: ${_quizNameController.text}'),
        SizedBox(height: 8),
        Text('Number of Questions: ${_questions.length}'),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Clear the form and update UI
            setState(() {
              _quizNameController.clear();
              _questions.clear();
              _submitted = false;
            });
          },
          child: Text('Start a New Quiz'),
        ),
      ],
    );
  }

  void _addQuestion() {
    if (_quizNameController.text.isNotEmpty) {
      setState(() {
        _questions.add(Question(
          question: '',
          options: List.filled(4, ''),
          correctAnswers: List.filled(4, false),
        ));
      });
    }
  }

  Future<void> _submitQuiz() async {
    if (_quizNameController.text.isNotEmpty) {
      // Process the quiz data
      Quiz quiz = Quiz(
        quizName: _quizNameController.text,
        questions: List.from(_questions),
      );

      try {
// Convert questions to a map
        Map<String, dynamic> quizData = {};

        // Convert each question to a map representation and add to the quizData map
        for (int i = 0; i < quiz.questions.length; i++) {
          quizData['question${i + 1}'] = {
            'que': quiz.questions[i].question,
            'option': quiz.questions[i].options,
            'Answer': quiz.questions[i].correctAnswers,
          };
        }
        List<Map<String, dynamic>> quizList = [];

// Convert each question to a map representation and add to the quizList
        for (int i = 0; i < quizData.length; i++) {
          quizList.add({
            'que': quizData['question${i + 1}']!['que'],
            'option': quizData['question${i + 1}']!['option'],
            'Answer': quizData['question${i + 1}']!['Answer'],
          });
        }

// Print the resulting list
        print(quizList);

        print(quizData);
        FirebaseDataManager firebaseDataManager = FirebaseDataManager(
            "https://simplequiapp-default-rtdb.firebaseio.com/${_quizNameController.text}.json");

        Map<String, dynamic> dataToAdd = {
          'quiz': quiz.quizName,
          'question': quizList,
        };
        Question que;
        firebaseDataManager.addData(dataToAdd);
        print('Data Adding');

        // Add the quiz to Firebase
        // await FirebaseFirestore.instance.collection('quizzes').add({
        //   'quizName': quiz.quizName,
        //   'questions': quiz.questions.map((question) {
        //     return {
        //       'question': question.question,
        //       'options': question.options,
        //       'correctAnswers': question.correctAnswers,
        //     };
        //   }).toList(),
        // });

        // Display a message using Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Quiz Submitted! Quiz Name: ${quiz.quizName}, Number of Questions: ${quiz.questions.length}',
            ),
          ),
        );

        // Update UI to show submission message
        setState(() {
          _submitted = true;
        });
      } catch (error) {
        print('Error submitting quiz: $error');
        // Handle the error as needed
      }
    }

    bool _formIsValid() {
      // You can add additional validation logic if needed
      return true;
    }
  }
}
