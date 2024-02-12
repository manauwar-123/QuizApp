// ignore_for_file: avoid_print, empty_statements

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'fetch.dart';

class DBconnect {
  String? param;
  DBconnect(this.param);

  Future<Quiz> fetchQuestions() async {
    final url = Uri.parse(
        "https://simplequiapp-default-rtdb.firebaseio.com/$param.json");
    var response = await http.get(url);

    print('response : ${response.body}');
    if (response.statusCode == 200) {
      if (response.body != null && response.body.isNotEmpty) {
        Quiz data = Quiz.fromJson(jsonDecode(response.body));
        print(data);
        print(data.uid.question.length);
        return data;
      } else {
        throw Exception('Response body is null or empty');
      }
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
