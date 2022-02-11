class RandomCocktail {
  RandomCocktail({
    required this.strDrink,
    required this.strDrinkThumb,
    required this.idDrink,
  });

  String strDrink;
  String strDrinkThumb;
  String idDrink;


  factory RandomCocktail.fromJson(Map<String, dynamic> json) {
    return RandomCocktail(
        strDrink: json['strDrink'],
        strDrinkThumb: json['strDrinkThumb'],
        idDrink:  json['idDrink']
    );
  }
}
