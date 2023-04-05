import 'package:bom_hamburguer/data/models/item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order{

  List<Item> items = <Item>[];
  String userName;

  Order({
    required this.userName,
    required this.items,
});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
