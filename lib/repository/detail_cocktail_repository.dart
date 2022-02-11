import 'dart:convert';
import 'package:cocktail_app_mds/models/detail_cocktail.dart';
import 'package:http/http.dart' as http;


class CocktailDetailRepository {

  Future<DetailCocktail> fetchDetailCocktail(String id) async {
    final response =
    await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id'));

    if (response.statusCode == 200) {
      final preparsed = json.decode(response.body)['drinks'][0];
      return DetailCocktail.fromJson(preparsed);
      //final preparsed = json.decode(response.body);
     // final parsed = json.decode(response.body)['drinks'].cast<Map<String, dynamic>>();

     // return parsed.map<DetailCocktail>((json) => DetailCocktail.fromJson(json))
     //     .toList();
    } else {
      throw Exception('Failed to load cocktail');
    }
  }

}

