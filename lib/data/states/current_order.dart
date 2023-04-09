import 'package:bom_hamburguer/data/enums/item_type.dart';
import 'package:bom_hamburguer/data/models/item.dart';
import 'package:bom_hamburguer/data/models/order.dart';
import 'package:bom_hamburguer/data/repository/order_repository.dart';
import 'package:bom_hamburguer/data/states/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

StateNotifierProvider<CurrentOrderNotifier,Order?> currentOrderProvider =
StateNotifierProvider<CurrentOrderNotifier,Order?>(
        (StateNotifierProviderRef<CurrentOrderNotifier, Order?> ref)
    => CurrentOrderNotifier(ref),
);

class CurrentOrderNotifier extends StateNotifier<Order?>{
  CurrentOrderNotifier(this.ref) : super(null);

  StateNotifierProviderRef<CurrentOrderNotifier, Order?> ref;

  OrderRepository repository = OrderRepository();

  void addItem(Item item){
    state ??= Order(
            userName: ref.read(userProvider)?.name ?? 'User',
            items: <Item>[],
            id: DateTime.now().toString(),
      total: 0,
      discount: 0,
      finalPrice: 0,
          );
    state = state?.copyWith(items: <Item>[...state?.items ?? <Item>[], item]);
    calculateTotal();
  }

  void removeItem(Item currentItem) {
    if(state != null){
      List<Item> currentList = state!.items;
      currentList.remove(currentItem);
      state = state!.copyWith(items: currentList);

      calculateTotal();
    }
  }

  bool checkIfOrderIsValid(BuildContext context){

    if(state!.items.where((Item item) => item.type == ItemType.sandwich)
        .length > 1){
      showGenericDialog(context, "You can't select more than one sandwich.");
      return false;
    }
    else if(state!.items.where((Item item) => item.type == ItemType.fries)
            .length > 1){
      showGenericDialog(context, "You can't select more than one frie.");
      return false;
    }
    else if(state!.items.where((Item item) => item.type == ItemType.softDrink)
        .length > 1){
      showGenericDialog(context, "You can't select more than one soft drink.");
      return false;
    }
    return true;
  }

  void showGenericDialog(BuildContext context, String message){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
              onPressed: ()=>context.pop(),
              child: Text(AppLocalizations.of(context).got_it),
          ),
        ],
      );
    });
  }

  void calculateTotal() {
    if(state?.items != null){
      List<Item> items = state!.items;
      double total = 0;
      double discount = 0;
      double finalPrice = 0;
      for(int i = 0; i < items.length; i++){
        total += items[i].price;
      }
      if(
      items.where((Item item) => item.type == ItemType.sandwich).length == 1 &&
      items.where((Item item) => item.type == ItemType.fries).length == 1 &&
      items.where((Item item) => item.type == ItemType.softDrink).length == 1
      ){
        discount = total * 0.2;
      } else if(
      items.where((Item item) => item.type == ItemType.sandwich).length == 1 &&
          items.where((Item item) => item.type == ItemType.softDrink).length == 1
      ){
        discount = total * 0.15;
      } else if(
      items.where((Item item) => item.type == ItemType.sandwich).length == 1 &&
          items.where((Item item) => item.type == ItemType.fries).length == 1
      ){
        discount = total * 0.1;
      } else {
        discount = 0;
      }
      finalPrice = total - discount;
      state = state!.copyWith(
        total: total,
        discount: discount,
        finalPrice: finalPrice,
      );
    }
  }

  Future<void> placeOrder() async {
    await repository.createOrder(state!);
    state = null;
  }

}