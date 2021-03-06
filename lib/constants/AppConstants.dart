final String thumbsJsonUrl = 'http://gkathir15.github.io/splash.json';

final String IS_SPLASH_DATA_STORED = "isSplashDataStored";
final String SPLASH_DATA_SIZE = "SplashDataSize";
final String SPLASH_Pic = "Splash_no_";
final String PROFILE_HERO_KEY = "GprofilePicHeroKey";


const String appTitle ="Moments";

//FireStore Keys

final String Collection_DIARY_DATA = "DIARY_DATA";
final String PARA_ARRAY = "PARA";
final String DATE_ID = "DATE";
final String CARD_CREATED_BY = "CARD_CREATED_BY";

final String CARD_CREATED_AT = "CARD_CREATED_AT";

final String CREATED_DAY = "CREATED_DAY";

final String IS_READ_BY_CREATOR = "IS_READ_BY_CREATOR";

final String IS_READ_BY_RECIEVER = "IS_READ_BY_RECIEVER";

final String BG_URL = "BG_URL";

final String LAST_EDIT_BY = "LAST_EDIT_BY";
final PARA_COUNT = "COUNT";

//LeafPage Constants
final String PARA_DATA = "PARA_DATA";
final String PARA_TYPE = "PARA_TYPE";
const String TYPE_IMAGE = "TYPE_IMAGE";
const String TYPE_VIDEO = "TYPE_VIDEO";
const String TYPE_TEXT = "TYPE_TEXT";
const String TYPE_LINK = "TYPE_LINK";
const String TYPE_AUDIO = "TYPE_AUDIO";
final String PARA_WRITER = "PARA_WRITER";
final String PARA_TIMESTAMP = "PARA_TIMESTAMP";
final String PARA_ID = 'PARA_ID';
final String PARA_FONT = 'PARA_FONT';
final String PARA_CREATOR_URL ="CREATOR_URL";


//Shared Prefs

final String IS_SIGNED_IN = 'IS_SIGNED_IN';

// Date Constants

class AppConstants {
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

  static String defaultIfNull(String value, String defaultValue) {
    return value.isNotEmpty && value != null ? value : defaultValue;
  }

  //Colors


//Routes

final String ROUTE_SIGIN='SIGNIN';
  final String ROUTE_GOOGLE = "GOOGLE_LOGIN";
  final String ROUTE_PROFILE="PROFILE";
  final String ROUTE_LEAFPAGE="LEAF_PAGE";
  final String UNKNOWN ="UNKNOWN";


}
