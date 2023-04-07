import 'package:bom_hamburguer/data/models/item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  String id;
  List<Item> items = <Item>[];
  String userName;
  double total;
  double discount;
  double finalPrice;

  Order({
    required this.id,
    required this.userName,
    required this.items,
    required this.total,
    required this.discount,
    required this.finalPrice,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order copyWith({
    String? id,
    List<Item>? items,
    String? userName,
    double? total,
    double? discount,
    double? finalPrice,
  }) =>
      Order(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        items: items ?? this.items,
        total: total ?? this.total,
        discount: discount ?? this.discount,
        finalPrice: finalPrice ?? this.finalPrice,
      );
}
