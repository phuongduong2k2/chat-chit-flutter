import 'package:chat_chit_flutter/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  @override
  User? build() => null;

  void setUser(User user) => state = user;

  void clearUser() => state = null;
}
