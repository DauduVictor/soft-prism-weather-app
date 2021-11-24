import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {

  /// An object for decoding json values
  final JsonDecoder _decoder = const JsonDecoder();

  /// A function to do any get request with the url and headers
  /// then sends back a json decoded result
  Future<dynamic> get(String url) async {
    try {
      return
        http
            .get(Uri.parse(url))
            .then((http.Response response) {
          final String res = response.body;
          final int statusCode = response.statusCode;
          if (statusCode < 200 || statusCode > 400) throw ('Error occurred');
          return _decoder.convert(res);
        });
    }catch (e){
      throw (e);
    }
  }
}