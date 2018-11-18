import '../model/settings.dart';

class Constants {

  //TODO uit dbs halen.
  static Settings current = new Settings(LangEnum.NL, LangEnum.IT, "");
  static bool speaker = true;
  static SortOrder whichWords = SortOrder.ALL_WORDS;
  static SortOrder sortOrder = SortOrder.ID_DESC;

  static const  Map<LangEnum, String> LANG_SELECT_CB = const {
    LangEnum.NL : "Nederlands",
    LangEnum.IT : "Italiaans",
    LangEnum.ES : "Spaans",
    LangEnum.FR : "Frans",
    LangEnum.DE : "Duits",
    LangEnum.EN : "Engels",
  };

static const  Map<LangEnum, String> LANG_ISO = const {
    LangEnum.NL : "nl-NL",
    LangEnum.IT : "it-IT",
    LangEnum.ES : "es-ES",
    LangEnum.FR : "fr-FR",
    LangEnum.DE : "de-DE",
    LangEnum.EN : "en-EN",
  };

 static LangEnum fromValue(String value)  {
    LangEnum result =  LangEnum.NL;
    LANG_SELECT_CB.forEach((k,v) {
      if (v == value) {print('found'); result = k;}
    });
    return result;
  }

  static String langName(LangEnum lang) {
    return lang.toString().split('.').last;
  }

   static const Map<SortOrder, String> WORDS_WHICH_CB = const {
    SortOrder.ALL_WORDS: "Alle bij deze taal",
    SortOrder.WORDS_ONLY: "Alleen woorden",
    SortOrder.SENTENCE_ONLY: "Alleen zinnen",
     SortOrder.ANY : "Alles uit dbs",
  };

  static const Map<SortOrder, String> WORDS_SORT_CB = const {
    SortOrder.ID_ASC: "Nieuwste eerst",
    SortOrder.ID_DESC: "Laatste eerste",
    SortOrder.RANDOM: "Random",
  };

  static String selectQuerySql() {
    StringBuffer sb = new StringBuffer();
    String lang = langName(Constants.current.targetLang);
    if (Constants.whichWords == SortOrder.ALL_WORDS) {
      sb.write("SELECT * FROM Vertaling WHERE lang='$lang' ");
    } else if (Constants.whichWords == SortOrder.WORDS_ONLY) {
      sb.write("SELECT * FROM Vertaling WHERE lang='$lang' AND words NOT LIKE '% %' ");
    } else if (Constants.whichWords == SortOrder.SENTENCE_ONLY) {
      sb.write("SELECT * FROM Vertaling WHERE lang='$lang' AND words LIKE '% %' ");
    } else if (Constants.whichWords == SortOrder.ANY) {
      sb.write("SELECT * FROM Vertaling ");
    }
    if (Constants.sortOrder == SortOrder.ID_ASC) {
       sb.write(" ORDER BY id ASC");
    } else if (Constants.sortOrder == SortOrder.ID_DESC) {
       sb.write(" ORDER BY id DESC");
    } 
    return sb.toString();
  }

  static SortOrder fromSortOrderValue(String value) {
    SortOrder result;
    WORDS_WHICH_CB.forEach((k, v) {
      if (v == value) {
        result = k;
      }
    });
    if (result == null) {
      WORDS_SORT_CB.forEach((k, v) {
        if (v == value) {
          result = k;
        }
      });
    }
    if (result == null) throw Exception("kan $value niet vinden");
    return result;
  }
}


enum LangEnum {
  NL,
  IT,
  ES,
  FR,
  DE,
  EN
}

enum SortOrder { ALL_WORDS, ID_ASC, ID_DESC, WORDS_ONLY, SENTENCE_ONLY, RANDOM,  ANY}

