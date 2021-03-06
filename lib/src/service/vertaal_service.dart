import 'dart:convert'; // for parsing JSON strings
import 'package:http/http.dart' as http;

import '../data/constants.dart';
import 'vertaal_intf.dart';

const oneSecond = Duration(milliseconds: 100);

const String URL =
    'https://translate.googleapis.com/translate_a/single?client=gtx&sl=nl&tl=it&dt=t&q=%s';

class VertaalService implements IVertaalService {
  
  @override
  Future<String> vertaal(String text) async {
    print(text + ".");
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

  String _makeUrl(String text) {
    String url = URL.replaceAll("=nl", "=" + _lowerLang(Constants.current.nativeLang));
    url = url.replaceAll("=it", "=" + _lowerLang(Constants.current.targetLang));
    return Uri.encodeFull(url.replaceAll("%s", text));
  }

  String _lowerLang(LangEnum lang) {
    return Constants.toLangName(lang);
  }
}
