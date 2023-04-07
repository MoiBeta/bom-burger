import 'package:bom_hamburguer/data/enums/item_type.dart';
import 'package:bom_hamburguer/data/models/item.dart';
import 'package:bom_hamburguer/data/models/order.dart';
import 'package:localstorage/localstorage.dart';

class OrderRepository {
  OrderRepository();

  final LocalStorage storage = LocalStorage('order_app.json');

  Future<void> createOrder(Order order) async {
    List<Order> list;
    list = (storage.getItem('orders') as List<Map<String, dynamic>>)
        .map((Map<String, dynamic> map) => Order.fromJson(map))
        .toList();
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

  Future<List<Item>> getAvailableItems() async{
    return Future<List<Item>>.delayed(
        const Duration(seconds: 1),
        ()=> <Item>[
          Item(
              id: 'df54hd4h165fd1h56fd1',
              name: 'Bacon',
              price: 7.00,
              type: ItemType.sandwich,
              imageUrl: 'https://firebasestorage.googleapis.com/v0/b/equipo1proyecto-98cd8.appspot.com/o/bacon.png?alt=media&token=d2217104-19e5-4e81-a50e-6416a85fd17a',
            rate: 4.5,
          ),
          Item(
              id: '4fd56h41adf6h41df16h46',
              name: 'Egg',
              price: 4.50,
              type: ItemType.sandwich,
              imageUrl: 'https://firebasestorage.googleapis.com/v0/b/equipo1proyecto-98cd8.appspot.com/o/egg.png?alt=media&token=d89161d1-fee1-4f55-8ae2-61edf4b346fd',
            rate: 4,
          ),
          Item(
              id: '6s1dag4a1sg6das1g6654g',
              name: 'Burger',
              price: 7.0,
              type: ItemType.sandwich,
              imageUrl: 'https://firebasestorage.googleapis.com/v0/b/equipo1proyecto-98cd8.appspot.com/o/burger.png?alt=media&token=e4bbd0f3-5d89-4b3c-8857-4363bb7f9424',
            rate: 3,
          ),
          Item(
              id: 'j6f1fg61jfgdjfdj6461df',
              name: 'Fries',
              price: 2.0,
              type: ItemType.fries,
              imageUrl: 'https://firebasestorage.googleapis.com/v0/b/equipo1proyecto-98cd8.appspot.com/o/fries.png?alt=media&token=d2b78eae-4cb7-45ca-a35c-df49055d1ba0',
            rate: 5,
          ),
          Item(
              id: 'ffj51fdgj1er651y4w6d46j',
              name: 'Soft Drink',
              price: 2.5,
              type: ItemType.softDrink,
              imageUrl: 'https://firebasestorage.googleapis.com/v0/b/equipo1proyecto-98cd8.appspot.com/o/soft_drink.png?alt=media&token=c1be35ba-4f70-4709-9f7d-fbe99ce36b5d',
            rate: 4.5,
          ),
        ],
    );
  }
}
