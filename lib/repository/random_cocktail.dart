import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cocktail_app_mds/models/random_cocktail.dart';


class RandomCocktailRepository{
  Future<RandomCocktail> fetchRandomCocktail() async {
    final response =
    await http.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php'));

    if (response.statusCode == 200) {
      final preparsed = json.decode(response.body)['drinks'][0];
      return RandomCocktail.fromJson(preparsed);

    } else {
      throw Exception('Failed to load random cocktail');
    }
  }
}
