import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 1)
class Favorite extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String email;

  @HiveField(2)
  List<Coffee> coffees;

  Favorite({
    required this.email,
    required this.coffees,
  });
}

@HiveType(typeId: 2)
class Coffee extends HiveObject {
  @HiveField(0)
  String id;

  // @HiveField(1)
  // int coffeeId;

  @HiveField(2)
  String name;

  @HiveField(3)
  String description;

  @HiveField(4)
  double price;

  @HiveField(5)
  String region;

  @HiveField(6)
  int weight;

  @HiveField(7)
  List<String> flavorProfile;

  @HiveField(8)
  List<String> grindOption;

  @HiveField(9)
  int roastLevel;

  @HiveField(10)
  String imageUrl;

  Coffee({
    required this.id,
    //required this.coffeeId,
    required this.name,
    required this.description,
    required this.price,
    required this.region,
    required this.weight,
    required this.flavorProfile,
    required this.grindOption,
    required this.roastLevel,
    required this.imageUrl,
  });
}
