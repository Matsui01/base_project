import 'package:json_annotation/json_annotation.dart';

part '../generated/joke.g.dart';

@JsonSerializable()
class Joke {
  String id;
  String value;

  Joke({
    required this.id,
    required this.value,
  });

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);
  Map<String, dynamic> toJson() => _$JokeToJson(this);
}