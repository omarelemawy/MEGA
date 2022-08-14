import 'package:flutter/cupertino.dart';
import 'package:gnon/localization/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context)?.getTranslatedValue(key);
}

// language code
const String ARABIC = 'ar';
const String ENGLISH = 'en';

const String LANGUAGE_CODE = 'ar';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();

  await _prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case 'ar':
      _temp = Locale('ar', 'EG');
      break;
    case 'en':
      _temp = Locale('en', 'US');
      break;
    default:
      _temp = Locale('en', 'US');
  }
  return _temp;
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();

  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? 'en';
  return _locale(languageCode);
}
