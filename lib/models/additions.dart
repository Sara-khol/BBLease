
import 'package:json_annotation/json_annotation.dart';

part 'additions.g.dart';

@JsonSerializable()
class Addition{

  @JsonKey(name: 'name')
  late String title;
  @JsonKey(name: 'key')
  late String name;
  @JsonKey(name: 'total')
  late double price;


  @JsonKey(includeFromJson: false)
  bool isChecked=false;
  @JsonKey(includeFromJson: false)
  bool isEnabled=true;


  Addition({required this.title,required this.name,required this.price});


  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.1
  factory Addition.fromJson(Map<String, dynamic> json) => _$AdditionFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AdditionToJson(this);

}