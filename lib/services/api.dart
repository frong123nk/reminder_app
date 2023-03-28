import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class APIManager {
  static const String BASE_URL = 'https://api.example.com/';
  static String authToken = ''; // get from local

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse(BASE_URL + endpoint),
      headers: _getRequestHeaders(),
    );
    return _parseResponse(response);
  }

  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(BASE_URL + endpoint),
      body: jsonEncode(data),
      headers: _getRequestHeaders(),
    );
    return _parseResponse(response);
  }

  static Map<String, String> _getRequestHeaders() {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    if (authToken.isNotEmpty) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $authToken';
    }
    return headers;
  }

  static Map<String, dynamic> _parseResponse(http.Response response) {
    if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else if (response.statusCode == 403) {
      throw Exception('Forbidden');
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw Exception('Bad Request');
    } else if (response.statusCode >= 500) {
      throw Exception('Internal Server Error');
    }
    final jsonBody = json.decode(response.body);
    if (jsonBody is Map<String, dynamic> && jsonBody.containsKey('error')) {
      throw Exception(jsonBody['error']);
    }
    return jsonBody;
  }

  static void setAuthToken(String token) {
    authToken = token;
  }

  // add more functions as needed for other HTTP methods like PUT, DELETE, etc.
}
