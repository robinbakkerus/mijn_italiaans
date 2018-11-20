import 'dart:convert'; // for parsing JSON strings
import 'package:http/http.dart' as http;

import '../data/constants.dart';
import 'vertaal_intf.dart';

const oneSecond = Duration(seconds: 1);

const String URL =
    'https://translation.googleapis.com/language/translate/v2';

class VertaalServiceV2 implements IVertaalService {

  static const API_KEY = "ya29.c.ElpaBiHdq-QgO6QrIrCp8LELowrovYc9N-qiRRhTcgkEVUsSgAZkSO_uydNXq7shsn-y_YieJpmmQLbrgGeQlaKGXMqXuu8rsYlg-3OBxW8hyGzhoyMhCeabkwg";

  @override
  Future<String> vertaal(String text) async {
    print(text + ".");
    var result = "?";

    var response = await http.post(
      _makeUrl(text),
      body: _getBody(text),
      headers: {"Authorization": "Bearer " + API_KEY},
    );

    if (response.statusCode == 200) {
      String responseBody = response.body;
      var responseJSON = json.decode(responseBody);
      print(responseJSON);
      result = responseJSON.data.translations[0].translatedText;
      print(result);
    } else {
      print('Something went wrong. \nResponse Code : ${response.body}');
    }
    return Future.delayed(oneSecond, () => result);
  }

  String _makeUrl(String text) {
    String url = URL.replaceAll("=nl", "=" + _lowerLang(Constants.current.nativeLang));
    url = url.replaceAll("=it", "=" + _lowerLang(Constants.current.targetLang));
    return Uri.encodeFull(url.replaceAll("%s", text));
  }

  String _getBody(String text) {
    return '''
    {
  'q': '$text',
  'source' : 'nl',
  'target': 'it'
}
    ''';
  }

  String _lowerLang(LangEnum lang) {
    return Constants.toLangName(lang);
  }
}
