import 'dart:convert';

class Resto {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late List foods;
  late List drinks;

  Resto({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  Resto.fromJson(Map<String, dynamic> resto) {
    id = resto['id'];
    name = resto['name'];
    description = resto['description'];
    pictureId = resto['pictureId'];
    city = resto['city'];
    rating = double.parse(resto['rating'].toString());
    foods = resto['menus']['foods'];
    drinks = resto['menus']['drinks'];
  }
}

List<Resto> parseResto(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parsedMap = jsonDecode(json);
  final List parsed = parsedMap['restaurants'];
  return parsed.map((json) => Resto.fromJson(json)).toList();
}
