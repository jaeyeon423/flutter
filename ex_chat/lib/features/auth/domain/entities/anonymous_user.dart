import 'package:freezed_annotation/freezed_annotation.dart';

part 'anonymous_user.freezed.dart';
part 'anonymous_user.g.dart';

@freezed
class AnonymousUser with _$AnonymousUser {
  const factory AnonymousUser({
    required String uid,
  }) = _AnonymousUser;

  factory AnonymousUser.fromJson(Map<String, dynamic> json) =>
      _$AnonymousUserFromJson(json);
}
