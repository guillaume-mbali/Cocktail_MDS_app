import 'package:cocktail_app_mds/models/cocktail.dart';
import 'package:cocktail_app_mds/repository/cocktail_repository.dart';
import 'package:cocktail_app_mds/repository/preferences_repository.dart';


class Repository {

  final CocktailRepository _cocktailRepository;
  final PreferencesRepository _preferencesRepository;

  Repository(this._cocktailRepository, this._preferencesRepository);

  Future<List<Cocktail>> fetchAllCocktail() {
    return _cocktailRepository.fetchAllCocktail();
  }
  Future<List<Cocktail>> fetchCocktailByCategory(category) {
    return _cocktailRepository.fetchCocktailByCategory(category);
  }

  Future<List<Cocktail>> fetchCocktailByName(query) {
    return _cocktailRepository.fetchCocktailByName(query);
  }

  Future<void> saveFavoriteCocktail(List<Cocktail> cocktails) async {
    _preferencesRepository.saveFavoriteCocktail(cocktails);
  }

  Future<void> deleteFavoriteCocktail(List<Cocktail> cocktails, String query) async {
    _preferencesRepository.deleteCocktail(cocktails, query);
  }

  Future<List<Cocktail>> loadCocktails() async =>_preferencesRepository.loadCocktails();


}