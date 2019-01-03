final String thumbsJsonUrl = 'http://gkathir15.github.io/splash.json';

final String IS_SPLASH_DATA_STORED = "isSplashDataStored";
final String SPLASH_DATA_SIZE = "SplashDataSize";
final String SPLASH_Pic = "Splash_no_";
final String PROFILE_HERO_KEY = "GprofilePicHeroKey";

//FireStore Keys

final String Collection_DIARY_DATA = "DIARY_DATA";
final String FIELD_ID = "DATE";
final String CARD_CREATED_BY = "CARD_CREATED_BY";

final String CARD_CREATED_AT = "CARD_CREATED_AT";

final String CREATED_DAY ="CREATED_DAY";

final String IS_READ_BY_CREATOR = "IS_READ_BY_CREATOR";

final String IS_READ_BY_RECIEVER = "IS_READ_BY_RECIEVER";

final String BG_URL ="BG_URL";


//LeafPage Constants

final String PARA_TYPE = "PARA_TYPE";

final String TYPE_IMAGE ="TYPE_IMAGE";
final String TYPE_TEXT ="TYPE_TEXT";
final String TYPE_LINK = "TYPE_LINK";
final String TYPE_AUDIO ="TYPE_AUDIO";
final String PARA_WRITER ="PARA_WRITER";
final String PARA_TIMESTAMP = "PARA_TIMESTAMP";








// Date Constants


class Helpers {
  static String getDay(int day) {
    switch (day) {
      case 1:
        return 'monday';
      case 2:
        return 'tuesday';
      case 3:
        return 'wednesday';
      case 4:
        return 'thursday';
      case 5:
        return 'friday';
      case 6:
        return 'saturday';
      case 7:
        return 'sunday';

      default:
        return "sunday";
    }
  }
}

