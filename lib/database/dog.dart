part 'dog.g.dart';

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  factory Dog.fromJson(Map<String, dynamic> json) => _$DogFromJson(json);
  Map<String, dynamic> toJson() => _$DogToJson(this);
}