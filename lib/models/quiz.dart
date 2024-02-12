class Quiz {
  String quizName;
  List<Question> questions;

  Quiz({
    required this.quizName,
    required this.questions,
  });
}

class Question {
  String? question;
  List<String>? options;
  List<bool>? correctAnswers;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswers,
  });

  Question.fromJson(Map<String, dynamic> que) {
    question = que['question'];
    options = que['option'];
    correctAnswers = que['correctAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['option'] = this.options;
    data['correctAnswer'] = this.correctAnswers;
    return data;
  }
}
