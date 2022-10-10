import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpRequest {
  static final HttpRequest _singleton = HttpRequest._internal();

  factory HttpRequest() {
    return _singleton;
  }

  HttpRequest._internal();

  final ENDPOINT = "https://www.googleapis.com/books/v1/volumes?q=";

  Future<dynamic> getBooks(var bookTitle) async {
    try {
      final uri = Uri.parse(ENDPOINT + bookTitle);
      var _response = await http.get(uri);
      if (_response.statusCode == 200) {
        var _content = jsonDecode(_response.body);
        return _content;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
