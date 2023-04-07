import 'dart:developer';

import 'package:bom_hamburguer/data/models/item.dart';
import 'package:bom_hamburguer/data/models/order.dart';
import 'package:bom_hamburguer/data/states/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateNotifierProvider<CurrentOrderNotifier,Order?> currentOrderProvider =
StateNotifierProvider<CurrentOrderNotifier,Order?>(
        (StateNotifierProviderRef<CurrentOrderNotifier, Order?> ref)
    => CurrentOrderNotifier(ref),
);

class CurrentOrderNotifier extends StateNotifier<Order?>{
  CurrentOrderNotifier(this.ref) : super(null);

  StateNotifierProviderRef<CurrentOrderNotifier, Order?> ref;

  void addItem(Item item){
    state ??= Order(
            userName: ref.read(userProvider)?.name ?? 'User',
            items: <Item>[],
            id: DateTime.now().toString(),
          );
    state = state?.copyWith(items: <Item>[...state?.items ?? <Item>[], item]);
    log('Item received: $item, Items: ${state?.items}');
  }

  void removeItem(Item currentItem) {}

}