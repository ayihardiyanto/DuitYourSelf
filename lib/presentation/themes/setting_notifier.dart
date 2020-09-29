import 'package:duit_yourself/common/constants/common_constants.dart';
import 'package:duit_yourself/domain/enums/entity_enum.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingNotifier with ChangeNotifier {
  ThemeData _themeData;
  static Entity entityParent;
  Locale _appLocale;

  ThemeData getTheme() => _themeData;

  static set setEntity(String entity){
    if(entity.toLowerCase() == CommonConstants.entityAmaan ){
      entityParent = Entity.AMAAN;
    }else if(entity.toLowerCase() == CommonConstants.entityGofin){
      entityParent = Entity.GO_FIN;
    }else{
      entityParent = Entity.PX;
    }
  }
  static String get getEntity{
    if(entityParent == Entity.AMAAN){
      return CommonConstants.entityAmaan;
    }else if(entityParent == Entity.GO_FIN){
      return CommonConstants.entityGofin;
    }else{
      return CommonConstants.entityPx;
    }
  }

  Locale get appLocal => _appLocale ?? Locale('en');

  void setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  void fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('en');
    }
    _appLocale = Locale(prefs.getString('language_code'));
  }

  void changeLanguage(Locale type) async {
    print(type.languageCode);
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale('id')) {
      _appLocale = Locale('id');
      await prefs.setString('language_code', 'id');
      await prefs.setString('countryCode', 'ID');
    } else if (type == Locale('en')) {
      _appLocale = Locale('en');
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    } else {
      //default
      _appLocale = Locale('en');
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }

}
