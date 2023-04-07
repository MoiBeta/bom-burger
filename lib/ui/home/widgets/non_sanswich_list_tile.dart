import 'package:bom_hamburguer/data/models/item.dart';
import 'package:bom_hamburguer/data/states/current_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NonSandwichListTile extends ConsumerWidget {
  const NonSandwichListTile(this.currentItem, {Key? key}) : super(key: key);

  final Item currentItem;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image.network(currentItem.imageUrl),
          title: Column(
            children: <Widget>[
              Text(currentItem.name),
              Text('\$${currentItem.price.toStringAsFixed(2)}')
            ],
          ),
          trailing: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                mini: true,
                onPressed: () {
                  ref
                      .read(currentOrderProvider.notifier)
                      .removeItem(currentItem);
                },
                child: const Icon(Icons.remove),
              ),
              const VerticalDivider(),
              Text(
                (ref
                            .watch(currentOrderProvider)
                            ?.items
                            .where((Item item) => item.id == currentItem.id)
                            .length ??
                        0)
                    .toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const VerticalDivider(),
              FloatingActionButton(
                mini: true,
                onPressed: () {
                  ref.read(currentOrderProvider.notifier).addItem(currentItem);
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
