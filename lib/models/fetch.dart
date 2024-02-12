import 'dart:convert';
// Quiz quizFromJson(String str) => Quiz.fromJson(json.decode(str));

// String quizToJson(Quiz data) => json.encode(data.toJson());

class Quiz {
  Uid uid;

  Quiz({
    required this.uid,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final key = json.keys.first; // Get the first key dynamically
    return Quiz(
      uid: Uid.fromJson(json[key]),
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid.toJson(),
      };
}

class Uid {
  List<Question> question;
  String quiz;

  Uid({
    required this.question,
    required this.quiz,
  });

  factory Uid.fromJson(Map<String, dynamic> json) => Uid(
        question: List<Question>.from(
            json["question"].map((x) => Question.fromJson(x))),
        quiz: json["quiz"],
      );

  Map<String, dynamic> toJson() => {
        "question": List<dynamic>.from(question.map((x) => x.toJson())),
        "quiz": quiz,
      };
}

class Question {
  List<bool> answer;
  List<String> option;
  String que;

  Question({
    required this.answer,
    required this.option,
    required this.que,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        answer: List<bool>.from(json["Answer"].map((x) => x)),
        option: List<String>.from(json["option"].map((x) => x)),
        que: json["que"],
      );

  Map<String, dynamic> toJson() => {
        "Answer": List<dynamic>.from(answer.map((x) => x)),
        "option": List<dynamic>.from(option.map((x) => x)),
        "que": que,
      };
}
