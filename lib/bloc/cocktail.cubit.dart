import 'package:cocktail_app_mds/models/cocktail.dart';
import 'package:bloc/bloc.dart';
import 'package:cocktail_app_mds/repository/repository.dart';

class CocktailCubit extends Cubit<List<Cocktail>> {

  CocktailCubit(this._repository) : super([]);

  final Repository _repository;



  void addCocktail(Cocktail cocktail) {

    emit([...state, cocktail]);
    _repository.saveFavoriteCocktail(state);
  }

  void removeCocktail(Cocktail cocktail) {

     emit([...state, cocktail]);
    _repository.unsaveFavoriteCocktail(state);
  }

  Future<void> loadCocktails() async {
    final List<Cocktail> cocktail = await _repository.loadCocktails();
    emit(cocktail);
  }
}
