import 'dart:convert'; // for parsing JSON strings
import 'package:http/http.dart' as http;

const oneSecond = Duration(seconds: 3);

const String URL =
    'https://translate.googleapis.com/translate_a/single?client=gtx&sl=nl&tl=it&dt=t&q=%s';

class VertaalService {
  static Future<String> vertaal(String text) async {
    var result = "?";

    var response = await http.get(
      _makeUrl(text),
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      String responseBody = response.body;
      var responseJSON = json.decode(responseBody);
      print(responseJSON);
      result = responseJSON[0][0][0];
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
    return Future.delayed(oneSecond, () => result);
  }

  static String _makeUrl(String text) {
    return Uri.encodeFull(URL.replaceAll("%s", text));
  }
}
