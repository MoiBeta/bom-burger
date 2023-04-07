import 'package:bom_hamburguer/data/enums/item_type.dart';
import 'package:bom_hamburguer/data/models/item.dart';
import 'package:bom_hamburguer/data/models/order.dart';
import 'package:bom_hamburguer/data/states/available_items.dart';
import 'package:bom_hamburguer/data/states/current_order.dart';
import 'package:bom_hamburguer/data/states/user.dart';
import 'package:bom_hamburguer/ui/home/widgets/menu_drawer.dart';
import 'package:bom_hamburguer/ui/home/widgets/sandwich_item_list.dart';
import 'package:bom_hamburguer/ui/home/widgets/shopping_cart_drawer.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(
      BuildContext context,
      ) {
    Order? currentOrder = ref.watch(currentOrderProvider);
    AsyncValue<List<Item>> availableItem = ref.watch(availableItemsProvider);
    return Scaffold(
      key: _key,
      drawer: const MenuDrawer(),
      endDrawer: const ShoppingCartDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _key.currentState?.openEndDrawer();
            },
            icon: badges.Badge(
              showBadge: currentOrder?.items.isNotEmpty ?? false,
                    badgeContent: currentOrder?.items.isNotEmpty ?? false
                        ? Text(currentOrder!.items.length.toString())
                        : null,
                    child: const Icon(Icons.shopping_cart_outlined))
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Sandwiches',
                style: TextStyle(fontSize: 18),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: availableItem.when(
                      data: (List<Item> availableItems){
                        List<Item> sandwichItems = availableItems.where(
                                (Item item) => item.type == ItemType.sandwich)
                            .toList();
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sandwichItems.length,
                            itemBuilder: (BuildContext context, int index)
                            => SandwichItemList(
                                currentItem: sandwichItems[index],
                            ),
                        );
                      },
                      error: (Object error, StackTrace trace){
                        return Text(error.toString());
                      },
                      loading: (){
                        return SkeletonLoader(
                          builder: Container(),
                          items: 10,
                        );
                      },
                  ),
                ),
              ),
              const Text(
                'Extras',
                style: TextStyle(fontSize: 18),
              ),
              Flexible(
                child: availableItem.when(
                    data: (List<Item> items){
                      List<Item> nonSandwichItems = items.where(
                              (Item item) => item.type != ItemType.sandwich)
                          .toList();
                      return ListView.builder(
                        itemCount: nonSandwichItems.length,
                        itemBuilder: (BuildContext context,int index){
                          return Card(
                            child: ListTile(
                              title: Text(nonSandwichItems[index].name),
                            ),
                          );
                        },
                      );
                    },
                    error: (Object error, StackTrace trace){
                      return Text(error.toString());
                    },
                    loading: ()=> const SkeletonLoader(builder: ListTile()),
                ),
              ),
            ],
        ),
      ),
    );
  }
}