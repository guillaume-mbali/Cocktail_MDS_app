import 'package:cocktail_app_mds/models/cocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

 class PreferencesRepository {

  Future<List<Cocktail>> loadCocktails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? list = prefs.getStringList('cocktails');

    if (list == null) {
      return [];
    }

    final List<Cocktail> cocktails = list.map((element) {
      return Cocktail.fromJson(element);
    }).toList();

    return cocktails;
  }

  Future<List<Cocktail>> favoritesCocktails() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? list = prefs.getStringList('cocktails');


    if (list == null) {
      return [];
    }

    final List<Cocktail> cocktails = list.map((element) {
      return Cocktail.fromJson(element);
    }).toList();

    return cocktails;

  }

  Future<void> saveFavoriteCocktail(List<Cocktail> cocktails,) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> listJson = [];
    for (final Cocktail cocktail in cocktails) {
      listJson.add(cocktail.toJson());
    }

    prefs.setStringList('cocktails', listJson);
  }

  Future<void> deleteCocktail(List<Cocktail> cocktails, String query) async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();

    for (final Cocktail cocktail in cocktails) {
      if(cocktail.id == query){
        cocktails.remove(cocktail);
        break;
      }
    }


    //prefs.setStringList('cocktails', listJson);
  }


}