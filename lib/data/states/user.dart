import 'package:bom_hamburguer/data/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateNotifierProvider<UserNotifier,User?> userProvider =
StateNotifierProvider<UserNotifier,User?>(
        (StateNotifierProviderRef<UserNotifier,User?> ref)
    => UserNotifier(null));

class UserNotifier extends StateNotifier<User?>{
  UserNotifier(super.state);

  void createUser(String name){
    state = User(name: name);
  }

}