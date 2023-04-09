import 'package:bom_hamburguer/data/models/order.dart';
import 'package:bom_hamburguer/data/repository/order_repository.dart';
import 'package:bom_hamburguer/data/states/current_order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateNotifierProvider<OrderListNotifier, List<Order>> orderListProvider =
StateNotifierProvider<OrderListNotifier, List<Order>>(
        (StateNotifierProviderRef<OrderListNotifier, List<Order>> ref)
    => OrderListNotifier(ref));


class OrderListNotifier extends StateNotifier<List<Order>> {
  OrderListNotifier(this.ref) : super(<Order>[]);

  StateNotifierProviderRef<OrderListNotifier, List<Order>> ref;

  OrderRepository repository = OrderRepository();

  void getOrdersList(){
    state = repository.getOrders();
  }


}