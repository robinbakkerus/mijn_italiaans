import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import '../model/settings.dart';
import '../model/languages.dart';

enum TtsState { playing, stopped }

class TextToSpeech {

  TextToSpeech() {
    _initState();
  }

  FlutterTts flutterTts;
  List<dynamic> languages;
  String language;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  _initState() {
    _initTts();
    _getLanguages();
  }

  _initTts() async {
    flutterTts = new FlutterTts();

    flutterTts.setStartHandler(() {
        ttsState = TtsState.playing;
    });

    flutterTts.setCompletionHandler(() {
        ttsState = TtsState.stopped;
    });

    flutterTts.setErrorHandler((msg) {
        ttsState = TtsState.stopped;
    });
  }

  Future speak(String text) async {
    _setLang();
    var result = await flutterTts.speak(text);
    if (result == 1) ttsState = TtsState.playing;
  }

  Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1) ttsState = TtsState.stopped;
  }

  void dispose() {
    flutterTts.stop();
  }

  void _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) {
      print(languages);
    }
  }

  void _setLang() {
    String l = Languages.LANG_ISO[Settings.current.targetLang];
    flutterTts.setLanguage(l);
  }

}
