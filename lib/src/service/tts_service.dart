
import 'package:dio/dio.dart';

import '../model/settings.dart';


const oneSecond = Duration(seconds: 3);

const String URL =
    'https://texttospeech.googleapis.com/v1beta1/text:synthesize';

class TTSService {

  static Dio _dio = new Dio();

  static Future<void> speak(String text) async {

    var response = await _dio.post(URL, data: _getData(text));

  }

  static String _getData(String text) {
    var jsonString = '''
    
    {
      "audioConfig": {
        "audioEncoding": "LINEAR16",
        "pitch": "0.00",
        "speakingRate": "1.00"
      },
      "input": {
        "text": "hi text"
      },
     "voice": {
    "languageCode": "en-US",
    "name": "en-US-Wavenet-D"
  }
    }
    ''';

    print(jsonString);
    return jsonString;
  }

  static String _makeUrl(String text) {
    String url = URL.replaceAll("=nl", "=" + Settings.current.nativeLang);
    url = url.replaceAll("=it", "=" + Settings.current.targetLang);
    return Uri.encodeFull(url.replaceAll("%s", text));
  }
}
