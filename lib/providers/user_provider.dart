import 'package:chat_chit_flutter/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends Notifier<User?> {
  @override
  User? build() {
    return null;
  }

  void setUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}

final userProvider = NotifierProvider(UserProvider.new);
