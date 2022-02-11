class FavoriteCocktailrepository{

  List<String> savedCocktails = <String>[];

  getStateCocktail(String name){
    if(savedCocktails.contains(name)){
      savedCocktails.remove(name);
    }else{
      savedCocktails.add(name);
    }
  }
}