
class DetailCocktail {
  final String idDrink;
  final String strDrink;
  final String strInstructions;
  final String strCategory;
  final String strGlass;
  final String strDrinkThumb;
  final String? strIngredient1;
  final String? strIngredient2;
  final String? strIngredient3;
  final String? strIngredient4;
  final String? strIngredient5;


  const DetailCocktail({
    required this.idDrink,
    required this.strDrink,
    required this.strInstructions,
    required this.strCategory,
    required this.strGlass,
    required this.strDrinkThumb,
    required this.strIngredient1,
    required this.strIngredient2,
    required this.strIngredient3,
    required this.strIngredient4,
    required this.strIngredient5,
  });

  factory DetailCocktail.fromJson(Map<String, dynamic> json) {
    return DetailCocktail(
      idDrink: json['idDrink'],
      strDrink: json['strDrink'],
      strInstructions: json['strInstructions'],
      strCategory: json['strCategory'],
      strGlass: json['strGlass'],
      strDrinkThumb: json['strDrinkThumb'],
      strIngredient1: json['strIngredient1'],
      strIngredient2: json['strIngredient2'],
      strIngredient3: json['strDrinkThumb3'],
      strIngredient4: json['strIngredient4'],
      strIngredient5: json['strIngredient5'],

    );
  }

}