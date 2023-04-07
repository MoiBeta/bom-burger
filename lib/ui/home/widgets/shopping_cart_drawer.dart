import 'package:flutter/material.dart';

class ShoppingCartDrawer extends StatelessWidget {
  const ShoppingCartDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text('Sopping Cart'),
        ],
      ),
    );
  }
}