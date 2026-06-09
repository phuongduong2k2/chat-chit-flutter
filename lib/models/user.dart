import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const User._();

  const factory User({
    required String email,
    required String username,
    String? avatarName,
  }) = _User;

  String get avatarUrl {
    if (avatarName == null || (avatarName != null && avatarName!.isEmpty)) {
      return "";
    }
    return "http://localhost:8082/api/v1/upload/files/$avatarName";
  }

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
