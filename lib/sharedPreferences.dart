import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static String sharedPrefUserSinginKey = 'IsSingIn';
  static String sharedPrefUserSkipLogIn = 'SkipLogIn';
  static String sharedPrefUserCountryCode = 'UserCountryCode';
  static String sharedPrefUserLong = 'Long';
  static String sharedPrefUserselectedProImage = 'IsSelected';
  static String sharedPrefAppLang = 'AppLan';
  static String sharedPrefApiLang = 'ApiLang';
  static String sharedPrefUserPre = 'pref';
  static String sharedPrefUserName = 'UserName';
  static String sharedPrefUserUserEmail = 'UserEmail';
  static String sharedPrefUserUserAge = 'UserAge';
  /*static String sharedPrefUserUserGender = 'UserGender';*/

  static String sharedPrefUserCountryName = 'UserCountryName';
  /*static String sharedPrefUserCountryCode = 'UserCode';*/

  static String sharedPrefUserUserPhone = 'UserPhone';
  static String sharedPrefUserUserPassword = 'UserPassword';
  static String sharedPrefUserImageUrl = 'userImageUrl';
  static String sharedPrefTotalPraic = 'TotalPraic';
  static String sharedPrefOnboarding = 'onBoarding';
  static String sharedPrefUserId = 'userId';
  static String sharedPrefCartConslProdect = 'cartConsulPro';
  static String sharedPrefCounsultFillterIndex = 'FillterIndex';
  static String sharedPrefCounsultFillterType = 'FillterType';
  static String sharedPrefUserGender = 'UserGender';
  static String sharedPrefCoursesFillterType = 'FillterType';
  //save data
  static Future<bool> saveUserSingIn(bool isSingin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPrefUserSinginKey, isSingin);
  }

  static Future<bool> saveUserSkipLogIn(bool isSkipLogIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPrefUserSkipLogIn, isSkipLogIn);
  }

  static Future<bool> saveUserOnboarding(bool isOnboarding) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPrefOnboarding, isOnboarding);
  }

  static Future<bool> saveTotalPrice(double price) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setDouble(sharedPrefTotalPraic, price);
  }

  static Future<bool> saveUserselectedProImage(bool isSelected) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPrefUserselectedProImage, isSelected);
  }

  static Future<bool> saveUserUserName(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserName, userName);
  }

  static Future<bool> saveFilltterIndex(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(sharedPrefCounsultFillterIndex, index);
  }

  static Future<bool> saveFilltterType(String type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefCounsultFillterType, type);
  }

  static Future<bool> saveUserGender(String index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserGender, index);
  }

  static Future<bool> saveCoursesFilltterType(String type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefCoursesFillterType, type);
  }

  static Future<bool> saveCountryCode(String lat) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserCountryCode, lat);
  }

  static Future<bool> saveUserlong(String long) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserLong, long);
  }

  static Future<bool> saveUserUserPassword(String userPasswrod) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        sharedPrefUserUserPassword, userPasswrod);
  }

  static Future<bool> saveUserId(String? userToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserId, userToken.toString());
  }

  static Future<bool> saveAppLang(String appLang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefAppLang, appLang);
  }

  static Future<bool> saveApiLang(String apiLang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefApiLang, apiLang);
  }

  static Future<bool> saveUserPrfe(String appLang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserPre, appLang);
  }

  static Future<bool> saveUserUserEmail( userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserUserEmail, userEmail);
  }

  static Future<bool> saveUserUserAge(String userAge) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserUserAge, userAge);
  }

/*  static Future<bool> saveUserUserGender(String userGender) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserUserGender, userGender);
  }*/

  static Future<bool> saveUserCountryName(String userStutes) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserCountryName, userStutes);
  }

  static Future<bool> saveUserUserPhoneNumber(String userPhoneNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        sharedPrefUserUserPhone, userPhoneNumber);
  }

  static Future<bool> saveUserImageUrl(String userImageUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserImageUrl, userImageUrl);
  }

  // getdata
  static getUserSingIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var isSingin = (preferences.getBool(sharedPrefUserSinginKey) ?? false);
    return isSingin;
  }

  static getUserSkipLogIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var isSkipLogIn = (preferences.getBool(sharedPrefUserSkipLogIn) ?? false);
    return isSkipLogIn;
  }

  static getUserselectedProImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var isSelected =
        (preferences.getBool(sharedPrefUserselectedProImage) ?? false);
    return isSelected;
  }

  static Future<String?> getUserUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? name = preferences.getString(sharedPrefUserName.toString());
    return name;
  }

  static getFiltterIndex() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? index = preferences.getInt(sharedPrefCounsultFillterIndex);
    return index;
  }

  static getFiltterType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? type = preferences.getString(sharedPrefCounsultFillterType);
    return type;
  }

  static getUserGender() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? index = preferences.getInt(sharedPrefUserGender);
    return index;
  }

  static getCoursesFiltterType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? type = preferences.getString(sharedPrefCoursesFillterType);
    return type;
  }

  static getCountryCode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? lat = preferences.getString(sharedPrefUserCountryCode);
    return lat;
  }

  static getUserlong() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? long = preferences.getString(sharedPrefUserLong);
    return long;
  }

  static getUserUserPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? password = preferences.getString(sharedPrefUserUserPassword);
    return password;
  }

  Future getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString(sharedPrefUserId);
    return token;
  }

  static getAppLang() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var appLang = preferences.getString(sharedPrefAppLang);
    return appLang;
  }

  static getApiLang() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var appLang = preferences.getString(sharedPrefApiLang);
    return appLang;
  }

  static getUserPre() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var appLang = preferences.getString(sharedPrefUserPre);
    return appLang;
  }

  Future getUserUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var email = preferences.getString(sharedPrefUserUserEmail);
    return email;
  }

  static getuserImageUrl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userImageUrl = preferences.getString(sharedPrefUserImageUrl);
    return userImageUrl;
  }

  static getUserUserAge() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? age = preferences.getString(sharedPrefUserUserAge);
    return age;
  }

  static getOnBoarding() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? onBoarding = preferences.getBool(sharedPrefOnboarding);
    return onBoarding;
  }

 /* static getUserUserGender() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? age = preferences.getString(sharedPrefUserUserGender);
    return age;
  }*/

  static getUserCountryName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? age = preferences.getString(sharedPrefUserCountryName);
    return age;
  }

  static getUserUserPhoneNumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? phoneNamber = preferences.getString(sharedPrefUserUserPhone);
    return phoneNamber;
  }

  static getTotalPrice() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    double price = (preferences.getDouble(sharedPrefTotalPraic) ?? 0.0);
    return price;
  }

  // static saveDataOfConsulPro(value) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var listConsulPro = value
  //       .map(
  //         (items) => jsonEncode(
  //           items.toMap(),
  //         ),
  //       )
  //       .toList();
  //   await preferences.setStringList(sharedPrefCartConslProdect, listConsulPro);
  // }

  // static getDataOfConsulPro() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   var listConsulPro = preferences.getStringList(sharedPrefCartConslProdect);

  //   return listConsulPro
  //       .map((itmes) => SaveProduct.formMap(jsonDecode(itmes)))
  //       .toList();
  // }
}
