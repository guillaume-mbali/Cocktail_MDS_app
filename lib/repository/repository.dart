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

  Future<void> unsaveFavoriteCocktail(List<Cocktail> cocktails) async {
    _preferencesRepository.unsaveFavoriteCocktail(cocktails);
  }



  Future<List<Cocktail>> loadCocktails() async =>_preferencesRepository.loadCocktails();

/*
  Future<void> saveCompanies(List<Company> companies) async {
    _preferencesRepository.saveCompanies(companies);
  }
  Future<List<Company>> loadCompanies() async =>_preferencesRepository.loadCompanies();
  */

}