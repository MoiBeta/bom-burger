
import 'package:bom_hamburguer/data/enums/item_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  final String name;
  final num price;
  final ItemType type;

  Item({
    required this.name,
    required this.price,
    required this.type,
});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
