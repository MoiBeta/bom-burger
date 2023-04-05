import 'package:bom_hamburguer/data/models/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateProvider<Order?> currentOrderProvider = StateProvider<Order?>(
        (StateProviderRef<Order?> ref) => null);
