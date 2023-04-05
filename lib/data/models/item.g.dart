// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      name: json['name'] as String,
      price: json['price'] as num,
      type: $enumDecode(_$ItemTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'type': _$ItemTypeEnumMap[instance.type]!,
    };

const _$ItemTypeEnumMap = {
  ItemType.sandwich: 'sandwich',
  ItemType.fries: 'fries',
  ItemType.softDrink: 'softDrink',
};
