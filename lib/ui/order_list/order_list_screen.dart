import 'package:bom_hamburguer/data/models/order.dart';
import 'package:bom_hamburguer/data/states/order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderListScreen extends ConsumerStatefulWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends ConsumerState<OrderListScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(Duration.zero, ref.read(orderListProvider.notifier)
          .getOrdersList);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Order> orders = ref.watch(orderListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).order_list),
      ),
      body: orders.isEmpty
          ? Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
                children: <Widget>[
                  Icon(
                    Icons.sentiment_very_dissatisfied,
                    size: 100,
                    color: const Color(0xFFFFA000).withOpacity(0.5),
                  ),
                  Text(
                    AppLocalizations.of(context).no_order_placed,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFFFA000).withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              children: <Widget>[
                ...orders
                    .map(
                      (Order order) => Card(
                        child: ListTile(
                          leading: Text(order.userName),
                          title: Text('${AppLocalizations.of(context)
                              .number_item} ${order.items.length}'),
                          trailing: Text(
                            '\$${order.finalPrice.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ).toList(),
              ],
            ),
    );
  }
}
