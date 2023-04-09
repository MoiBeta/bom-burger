import 'package:bom_hamburguer/data/models/item.dart';
import 'package:bom_hamburguer/data/models/order.dart';
import 'package:bom_hamburguer/data/states/current_order.dart';
import 'package:bom_hamburguer/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResumeScreen extends ConsumerWidget {
  ResumeScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
  ) {
    final Order currentOrder = ref.read(currentOrderProvider)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 100,
            child: FittedBox(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      AppLocalizations.of(context).about_place_order,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context).order_resume,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _key,
          child: ListView(
            children: <Widget>[
              ...currentOrder.items.map((Item item)
              => Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                        item.imageUrl,
                      width: 50,
                    ),
                    title: Text(item.name),
                    trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                  ),
                  const Divider(),
                ],
              ),
              ).toList(),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text('\$${currentOrder.total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(AppLocalizations.of(context).discounts,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text('-\$${currentOrder.discount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).final_price,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text('\$${currentOrder.finalPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const Divider(),
              const Divider(
                color: Colors.transparent,
              ),
              Text(
                AppLocalizations.of(context).enter_name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextFormField(
                validator: (String? text){
                  if(text?.isEmpty ?? true){
                    return 'You must enter name.';
                  }
                  ref.read(currentOrderProvider.notifier).state = currentOrder
                      .copyWith(userName: text);
                  return null;
                },
              ),

              const Divider(
                color: Colors.transparent,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if(_key.currentState!.validate()){
                      await ref.read(currentOrderProvider.notifier)
                          .placeOrder();
                      if(context.mounted){
                        await showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: const Icon(
                                  Icons.check_circle,
                                  size: 100,
                                  color: Color(0xFFFFA000),
                                ),
                                content: Text(AppLocalizations.of(context)
                                    .order_processed),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: ()=> context.go(home),
                                    child: Text(AppLocalizations.of(context)
                                        .got_it),
                                  ),
                                ],
                              );
                            });
                      }
                    }
                  },
                  child: Text(AppLocalizations.of(context).place_order),
              )
            ],
          ),
        ),
      ),
    );
  }
}
