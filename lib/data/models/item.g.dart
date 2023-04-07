// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as num,
      type: $enumDecode(_$ItemTypeEnumMap, json['type']),
      imageUrl: json['imageUrl'] as String,
      rate: (json['rate'] as num).toDouble(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'type': _$ItemTypeEnumMap[instance.type]!,
      'imageUrl': instance.imageUrl,
      'rate': instance.rate,
    };

const _$ItemTypeEnumMap = {
  ItemType.sandwich: 'sandwich',
  ItemType.fries: 'fries',
  ItemType.softDrink: 'softDrink',
};
