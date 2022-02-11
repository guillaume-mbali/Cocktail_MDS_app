import 'package:cocktail_app_mds/models/cocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CocktailRepository {

  Future<List<Cocktail>> fetchAllCocktail() async {
    final response =
    await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'));

    if (response.statusCode == 200) {
      final List<Cocktail> cocktails = [];
      final Map<String, dynamic> json = jsonDecode(response.body);

      final List<dynamic> features = json['drinks'];
      for (var featureJson in features) {
        cocktails.add(Cocktail.fromGeoJson(featureJson));
      }
      return cocktails;
    } else {
      throw Exception('Impossible de récuperer les cocktails');
    }
  }

  Future<List<Cocktail>> fetchCocktailByCategory(String category) async {
    final response =
    await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=$category'));

    if (response.statusCode == 200) {
      final List<Cocktail> cocktails = [];
      final Map<String, dynamic> json = jsonDecode(response.body);

      final List<dynamic> features = json['drinks'];
      for (var featureJson in features) {
        cocktails.add(Cocktail.fromGeoJson(featureJson));
      }
      return cocktails;
    } else {
      throw Exception('Impossible de récuperer les cocktails');
    }
  }

  Future<List<Cocktail>> fetchCocktailByName(String query) async {
    final response =
    await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$query'));

    if (response.statusCode == 200) {
      final List<Cocktail> cocktails = [];
      final Map<String, dynamic> json = jsonDecode(response.body);

      final List<dynamic> features = json['drinks'];
      for (var featureJson in features) {
        cocktails.add(Cocktail.fromGeoJson(featureJson));
      }
      return cocktails;
    } else {
      throw Exception('Impossible de récuperer les cocktails');
    }
  }
}

