class SortUtils {

 static const  Map<SortOrder, String> SORTORDER_CB = const {
    SortOrder.ID_ASC :  "Standaard",
    SortOrder.ID_DESC :  "Laatste bovenaan",
    SortOrder.WORDS_ONLY :  "Alleen woorden",
    SortOrder.SENTENCE_ONLY :  "Alleen zinnen",
    SortOrder.RANDOM :  "Random",
  };


 static const  Map<SortOrder, String> SORTORDER_SQL = const {
    SortOrder.ID_ASC :  " ORDER BY id ASC",
    SortOrder.ID_DESC :  " ORDER BY id DESC",
    SortOrder.WORDS_ONLY :  " WHERE words NOT LIKE \'% %\' ",
    SortOrder.SENTENCE_ONLY :  " WHERE words LIKE \'% %\' ",
    SortOrder.RANDOM :  " ORDER BY id",
  };

  static SortOrder fromValue(String value)  {
    SortOrder result =  SortOrder.ID_DESC;
    SORTORDER_CB.forEach((k,v) {
      if (v == value) {print('found'); result = k;}
    });
    return result;
  }
}

enum SortOrder {
  ID_ASC,
  ID_DESC,
  WORDS_ONLY,
  SENTENCE_ONLY,
  RANDOM
}

