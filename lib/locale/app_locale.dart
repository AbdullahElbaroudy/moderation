import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AppLocale {

  Locale locale;

  AppLocale(this.locale);

  Map<String, dynamic> _loadedLocalizedValue;

  static AppLocale of(BuildContext context) {
    return Localizations.of(context, AppLocale);
  }
  List<String> supportedLanguges(){
    return ['en','ar'];
  }
  LocaleType langNowType(BuildContext context){
    switch (Localizations.localeOf(context).languageCode) {
      case 'en':
        return LocaleType.en;
        break;
      case 'ar':
        return LocaleType.ar;
        break;
      default:
    }    
  }
  Future loadLang() async {
    String _loadedFile =
        await rootBundle.loadString('assets/langs/${locale.languageCode}.json');
    _loadedLocalizedValue = jsonDecode(_loadedFile);
  }

  String translat(String key) {
    return _loadedLocalizedValue[key].toString();
  }

  
  static const LocalizationsDelegate<AppLocale> delegate = _AppLocalDelegate() ;
}

class _AppLocalDelegate extends LocalizationsDelegate<AppLocale>{

const _AppLocalDelegate();
  //List<String> suppurtedLangs = ['en', 'ar'];

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale appLocal = AppLocale(locale);
    await appLocal.loadLang();
    return appLocal;
  }

  @override
  bool shouldReload(LocalizationsDelegate old) => false;
}
