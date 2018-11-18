import '../model/settings.dart';

class Constants {
  //TODO uit dbs halen.
  static Settings current = new Settings(LangEnum.NL, LangEnum.IT, "");
  static bool speaker = true;
  static WhichWords whichWords = WhichWords.ALL_WORDS;
  static SortOrder sortOrder = SortOrder.ID_DESC;

  static const Map<LangEnum, String> LANG_SELECT_CB = const {
    LangEnum.NL: "Nederlands",
    LangEnum.IT: "Italiaans",
    LangEnum.ES: "Spaans",
    LangEnum.FR: "Frans",
    LangEnum.DE: "Duits",
    LangEnum.EN: "Engels",
  };

  static const Map<LangEnum, String> LANG_ISO = const {
    LangEnum.NL: "nl-NL",
    LangEnum.IT: "it-IT",
    LangEnum.ES: "es-ES",
    LangEnum.FR: "fr-FR",
    LangEnum.DE: "de-DE",
    LangEnum.EN: "en-EN",
  };

  static LangEnum fromValue(String value) {
    LangEnum result = LangEnum.NL;
    LANG_SELECT_CB.forEach((k, v) {
      if (v == value) {
        print('found');
        result = k;
      }
    });
    return result;
  }

  static String toLangName(LangEnum lang) {
    return lang.toString().split('.').last;
  }

  static const Map<WhichWords, String> WORDS_WHICH_CB = const {
    WhichWords.ALL_WORDS: "Alle bij deze taal",
    WhichWords.WORDS_ONLY: "Alleen woorden",
    WhichWords.SENTENCE_ONLY: "Alleen zinnen",
    WhichWords.ANY: "Alles uit dbs",
  };

  static const Map<SortOrder, String> WORDS_SORT_CB = const {
    SortOrder.ID_ASC: "Nieuwste eerst",
    SortOrder.ID_DESC: "Laatste eerste",
    SortOrder.RANDOM: "Random",
  };

  static SortOrder toSortOrder(String value) {
    SortOrder result;
    WORDS_SORT_CB.forEach((k, v) {
      if (v == value) {
        result = k;
      }
    });
    if (result == null) throw Exception("kan $value niet vinden");
    return result;
  }

  static WhichWords toWhichWords(String value) {
    WhichWords result;
    WORDS_WHICH_CB.forEach((k, v) {
      if (v == value) {
        result = k;
      }
    });
    if (result == null) throw Exception("kan $value niet vinden");
    return result;
  }
}

enum LangEnum { NL, IT, ES, FR, DE, EN }

enum SortOrder { ID_ASC, ID_DESC, RANDOM }

enum WhichWords { ALL_WORDS, WORDS_ONLY, SENTENCE_ONLY, ANY }
