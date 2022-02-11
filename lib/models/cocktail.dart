import 'dart:convert';


class Cocktail {


  String id;
  String name;
  String img;
  bool? isFavorite;

  Cocktail(this.id, this.name, this.img, this.isFavorite);

  String toJson() {
  return jsonEncode({
  'id': id,
  'name': name,
  'img': img,


  });
  }
  factory Cocktail.fromJson(String json) {
  Map<String, dynamic> map = jsonDecode(json);
  return Cocktail(
  map['id'],
  map['name'],
  map['img'],
    map['isFavorite'],
  );
  }


  factory Cocktail.fromGeoJson(Map<String, dynamic> json) {
    final String id = json['idDrink'];
    final String name = json['strDrink'];
    final String img = json['strDrinkThumb'];
    const bool isFavorite = false;


  return Cocktail(id, name, img, isFavorite);
  }
  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is Cocktail && name == other.name;
  }

}