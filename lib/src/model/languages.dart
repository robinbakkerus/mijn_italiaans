
class Languages {

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

  static String name(LangEnum lang) {
    return lang.toString().split('.').last;
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
