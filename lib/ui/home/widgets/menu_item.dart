import 'package:bom_hamburguer/data/models/item.dart';
import 'package:bom_hamburguer/data/states/current_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuItem extends ConsumerWidget {
  const MenuItem(this.currentItem,{Key? key}) : super(key: key);

  final Item currentItem;

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.network(
                currentItem.imageUrl,
              height: 100,
              width: 100,
            ),
            Column(
              children: <Widget>[
                Text(
                    currentItem.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      mini: true,
                      onPressed: () {
                        ref.read(currentOrderProvider.notifier)
                            .removeItem(currentItem);
                      },
                      child: const Icon(Icons.remove),
                    ),
                    const VerticalDivider(),
                    Text((ref
                        .watch(currentOrderProvider)
                        ?.items
                        .where((Item item) => item.id == currentItem.id)
                        .length ?? 0).toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const VerticalDivider(),
                    FloatingActionButton(
                      mini: true,
                      onPressed: () {
                        ref.read(currentOrderProvider.notifier)
                            .addItem(currentItem);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
