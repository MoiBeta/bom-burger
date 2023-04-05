import 'package:bom_hamburguer/data/models/order.dart';
import 'package:bom_hamburguer/data/repository/order_repository.dart';
import 'package:bom_hamburguer/data/states/current_order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateNotifierProvider<OrdersListNotifier, List<Order>> ordersListProvider =
StateNotifierProvider<OrdersListNotifier, List<Order>>(
        (StateNotifierProviderRef<OrdersListNotifier, List<Order>> ref)
    => OrdersListNotifier(ref));


class OrdersListNotifier extends StateNotifier<List<Order>> {
  OrdersListNotifier(this.ref) : super(<Order>[]);

  StateNotifierProviderRef<OrdersListNotifier, List<Order>> ref;

  OrderRepository repository = OrderRepository();

  void addOrder(){
    if(ref.read(currentOrderProvider) != null){
      repository.createOrder(ref.read(currentOrderProvider)!);
    }
  }



}