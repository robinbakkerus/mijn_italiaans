
// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../model/settings.dart';


const oneSecond = Duration(seconds: 3);

const String URL =
    'https://texttospeech.googleapis.com/v1beta1/text:synthesize';

class TTSService {

  // static Dio _dio = new Dio();

  static Future<void> speak(String text) async {
    // _dio.options.headers = _geHeader();
    // var response = await _dio.post(URL, data: _getData(text);
    // print(response);
  var url = "http://httpbin.org/post";
  var client = new http.Client();
  var request = new http.Request('POST', Uri.parse(url));
  var body = {'content':'this is a test', 'email':'john@doe.com', 'number':'441276300056'};
  // request.headers[HttpHeaders.contentTypeHeader] = 'application/json; charset=utf-8';
  request.headers[HttpHeaders.authorizationHeader] = 'Basic 021215421fbe4b0d27f:e74b71bbce';
  request.bodyFields = body;
  var future = client.send(request).then((response)
      => response.stream.bytesToString().then((value)
          => print(value.toString()))).catchError((error) => print(error.toString()));
  
  }

  // static Map<String, dynamic> _geHeader() {
  //  var map = new Map<String, dynamic>();
  //   map["Authorization: Bearer"] = _nativeLang;
  //   map["target_lang"] = _targetLang;
  //   map["email_address"] = _emailAdress;
  //   return map;

  // }

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


  // jsonString = "{    'input':{  'text':'Android is a mobile operating system developed by Google, }, 'voice':{ 'languageCode':'en-gb',  'name':'en-GB-Standard-A',  'ssmlGender':'FEMALE'  },    'audioConfig':{  'audioEncoding':'MP3' }}" "https://texttospeech.googleapis.com/v1/text:synthesize";
    
    jsonString = '''
{
    'input':{
      'text':'Android is a mobile operating system developed by Google,
         based on the Linux kernel and designed primarily for
         touchscreen mobile devices such as smartphones and tablets.'
    },
    'voice':{
      'languageCode':'en-gb',
      'name':'en-GB-Standard-A',
      'ssmlGender':'FEMALE'
    },
    'audioConfig':{
      'audioEncoding':'MP3'
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
