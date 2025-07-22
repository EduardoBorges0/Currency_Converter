import 'package:shared_preferences/shared_preferences.dart';

class PreferenceCoin{
  final PREFERENCE_COIN_KEY = 'PREFERENCE_COIN';
  final PREFERENCE_COIN_SYMBOL_KEY = 'PREFERENCE_COIN_SYMBOL_KEY';

  final PREFERENCE_LANGUAGE_KEY = 'PREFERENCE_LANGUAGE';


  void savePreferenceCoin(String coin, String language, String symbol) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREFERENCE_COIN_KEY, coin);
    await prefs.setString(PREFERENCE_LANGUAGE_KEY, language);
    await prefs.setString(PREFERENCE_COIN_SYMBOL_KEY, symbol);

  }
  Future<Map<String, String>> getPreferenceLocaleAndSymbol() async {
    final prefs = await SharedPreferences.getInstance();

    final language = prefs.getString(PREFERENCE_LANGUAGE_KEY) ?? 'pt_br';
    final coinSymbol = prefs.getString(PREFERENCE_COIN_SYMBOL_KEY) ?? "R\$";

    return {
      'language': language,
      'symbol': coinSymbol,
    };
  }


  Future<String> getPreferenceCoin() async {
    final prefs = await SharedPreferences.getInstance();
    String? preferenceLanguage = prefs.getString(PREFERENCE_COIN_KEY);
    return preferenceLanguage ?? 'BRL';
  }

}