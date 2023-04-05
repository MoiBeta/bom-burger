import 'package:bom_hamburguer/data/models/order.dart';
import 'package:localstorage/localstorage.dart';

class OrderRepository {
  OrderRepository();

  final LocalStorage storage = LocalStorage('order_app.json');

  Future<void> createOrder(Order order) async {
    List<Order> list;
    try {
      list = (storage.getItem('orders') as List<dynamic>)
          .map((map) => Order.fromJson(map))
          .toList();
    } catch (_) {
      list = <Order>[];
    }
    list.add(order);
    storage.setItem(
        'orders', list.map((Order order) => order.toJson()).toList());
  }

  List<Order>? getOrdersByCustomer(String customerName) {
    return (storage.getItem('orders') as List<dynamic>)
        .map((map) => Order.fromJson(map))
        .toList()
        .where((Order order) => order.userName == customerName)
        .toList();
  }
}
