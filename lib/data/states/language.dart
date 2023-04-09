import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

StateProvider<Locale> languageProvider = StateProvider<Locale>(
        (StateProviderRef<Locale> ref) => const Locale('en'));