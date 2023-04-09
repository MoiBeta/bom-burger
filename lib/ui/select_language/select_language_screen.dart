import 'package:bom_hamburguer/data/states/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectLanguageScreen extends ConsumerWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    Locale selectedLanguage = ref.watch(languageProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).language),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
                AppLocalizations.of(context).select_language,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    ref.read(languageProvider.notifier).state
                    = const Locale('es');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: selectedLanguage == const Locale('es')
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          width: selectedLanguage == const Locale('es') ? 3 : 1,
                      ),
                    ),
                    child: Text(AppLocalizations.of(context).spanish,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                GestureDetector(
                  onTap: (){
                    ref.read(languageProvider.notifier).state 
                    = const Locale('en');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedLanguage == const Locale('en')
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        width: selectedLanguage == const Locale('en') ? 3 : 1,
                      ),
                    ),
                    child: Text(AppLocalizations.of(context).english,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
