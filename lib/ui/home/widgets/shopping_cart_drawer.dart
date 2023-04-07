import 'package:bom_hamburguer/data/models/item.dart';
import 'package:bom_hamburguer/data/models/order.dart';
import 'package:bom_hamburguer/data/states/current_order.dart';
import 'package:bom_hamburguer/router/routes.dart';
import 'package:bom_hamburguer/ui/home/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ShoppingCartDrawer extends ConsumerWidget {
  const ShoppingCartDrawer({Key? key}) : super(key: key);

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final Order? currentOrder = ref.watch(currentOrderProvider);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Flexible(
            child: currentOrder?.items.isNotEmpty ?? false
                ? ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                          'Total:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: <Widget>[
                          Text(
                            '\$${currentOrder?.finalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 20
                            ),
                          ),
                          if(currentOrder?.discount != 0)
                            Text(
                              '\$${currentOrder?.total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                ...currentOrder!.items.toSet().toList().map(
                        (Item item) => MenuItem(item)).toList(),
              ],
            ) : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                    Icons.sentiment_very_dissatisfied,
                  size: 100,
                  color: const Color(0xFFFFA000).withOpacity(0.5),
                ),
                Text(
                    "You haven't selected any items yet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFFFA000).withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 0,
              child: ElevatedButton(
                  onPressed: currentOrder?.items.isNotEmpty
                      ?? false
                      ? (){
                    bool isValid = ref.read(currentOrderProvider.notifier)
                        .checkIfOrderIsValid(context);
                    if(isValid){
                      context.pop();
                      context.push(resume);
                    }

                  }
                      :null,
                  child: const Text('Place Order'),
              ),
          ),
        ],
      ),
    );
  }
}
