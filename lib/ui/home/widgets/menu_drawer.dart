import 'package:bom_hamburguer/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           ListTile(
             leading: const Icon(Icons.list),
             title: Text(AppLocalizations.of(context).order_list),
             onTap: ()=>context.push(ordersList),
           ),
           ListTile(
             leading: const Icon(Icons.language),
             title: Text(AppLocalizations.of(context).language),
             onTap: ()=>context.push(language),
           ),
        ],
      ),
    );
  }
}
