import 'package:bom_hamburguer/data/models/item.dart';
import 'package:bom_hamburguer/data/states/current_order.dart';
import 'package:bom_hamburguer/router/routes.dart';
import 'package:bom_hamburguer/ui/home/widgets/menu_item.dart';
import 'package:bom_hamburguer/ui/home/widgets/non_sanswich_list_tile.dart';
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
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Flexible(
            child: ref.watch(currentOrderProvider)?.items.isNotEmpty ?? false 
                ? ListView(
              children: <Widget>[
                ...ref.watch(currentOrderProvider)!.items.toSet().toList().map(
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
                  onPressed: ref.watch(currentOrderProvider)?.items.isNotEmpty
                      ?? false
                      ?()=>context.push(resume)
                      :null,
                  child: const Text('Place Order'),
              ),
          ),
        ],
      ),
    );
  }
}
