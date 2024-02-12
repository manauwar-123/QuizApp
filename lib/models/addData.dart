import 'dart:convert';
import 'package:http/http.dart' as http;

class FirebaseDataManager {
  final String databaseUrl;

  FirebaseDataManager(this.databaseUrl);

  Future<void> addData(Map<String, dynamic> dataToAdd) async {
    // Convert data to JSON
    print('decoding');
    String jsonData = json.encode(dataToAdd);

    // Make an HTTP POST request to add data
    var response = await http.post(
      Uri.parse(databaseUrl),
      body: jsonData,
    );

    // Check the response
    if (response.statusCode == 200) {
      print("Data added successfully");
    } else {
      print("Failed to add data. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  }
}
