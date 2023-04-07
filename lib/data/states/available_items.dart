import 'package:bom_hamburguer/data/models/item.dart';
import 'package:bom_hamburguer/data/repository/order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

FutureProvider<List<Item>> availableItemsProvider =
FutureProvider<List<Item>>(
        (_) => OrderRepository().getAvailableItems(),
);