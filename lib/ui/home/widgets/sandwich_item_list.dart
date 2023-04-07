import 'package:bom_hamburguer/data/models/item.dart';
import 'package:bom_hamburguer/data/states/current_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;
import 'package:skeleton_loader/skeleton_loader.dart';

/// Widget used as an item of the sandwiches' list.
class SandwichItemList extends ConsumerWidget {
  const SandwichItemList({required this.currentItem, Key? key})
      : super(key: key);

  final Item currentItem;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    int? count = ref
        .watch(currentOrderProvider)
        ?.items
        .where((Item item) => item.id == currentItem.id)
        .length ?? 0;
    return Container(
      margin: const EdgeInsets.all(5),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width / 2.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                  child: Center(
                      child: Image.network(
                          currentItem.imageUrl,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress)
                        => loadingProgress != null
                            ? const CircularProgressIndicator():child,
                      ),
                  ),
              ),
              Flexible(
                flex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        '\$${currentItem.price}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(currentItem.name),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: FittedBox(
                            child: RatingBarIndicator(
                              rating: currentItem.rate,
                              itemBuilder: (BuildContext context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    const Divider(),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FloatingActionButton(
                            mini: true,
                            child: const Icon(Icons.remove),
                            onPressed: (){
                              ref.read(currentOrderProvider.notifier)
                                  .removeItem(currentItem);
                            },
                          ),
                          Text(
                              (count).toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          FloatingActionButton(
                            mini: true,
                            child: const Icon(Icons.add),
                            onPressed: (){
                              ref.read(currentOrderProvider.notifier)
                                  .addItem(currentItem);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
