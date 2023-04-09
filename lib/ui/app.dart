import 'package:bom_hamburguer/core/themes/light_theme.dart';
import 'package:bom_hamburguer/data/states/language.dart';
import 'package:bom_hamburguer/router/router_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BomApp extends ConsumerWidget  {
  const BomApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp.router(
      locale: ref.watch(languageProvider),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routerConfig: ref.watch(router),
    );
  }
}
