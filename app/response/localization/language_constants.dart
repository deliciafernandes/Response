//import 'package:flutter/material.dart';
//import 'appLocalization.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//const String LAGUAGE_CODE = 'languageCode';
//
////languages code
//const String ENGLISH = 'en';
//const String MARATHI = 'mr';
//const String HINDI = 'hi';
//
//Future<Locale> setLocale(String languageCode) async {
//  SharedPreferences _prefs = await SharedPreferences.getInstance();
//  await _prefs.setString(LAGUAGE_CODE, languageCode);
//  return _locale(languageCode);
//}
//
//Future<Locale> getLocale() async {
//  SharedPreferences _prefs = await SharedPreferences.getInstance();
//  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
//  // print(_prefs.getString('LANGUAGE_CODE'));
//  return _locale(languageCode);
//}
//
//Locale _locale(String languageCode) {
//  switch (languageCode) {
//    case ENGLISH:
//      return Locale(ENGLISH, 'US');
//    case HINDI:
//      return Locale(HINDI, "IN");
//    case MARATHI:
//      return Locale(MARATHI, "IN");
//    default:
//      return Locale(ENGLISH, 'US');
//  }
//}
//
//String getTranslated(BuildContext context, String key) {
//  return AppLocalizations.of(context).translate(key);
//}
