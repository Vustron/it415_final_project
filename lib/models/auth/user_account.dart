import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_account.freezed.dart';
part 'user_account.g.dart';

@freezed
class UserAccount with _$UserAccount {
  const factory UserAccount({
    required String id,
    required String name,
    String? address,
    String? phoneNumber,
    required String email,
    String? provider,
    String? profileImg,
    String? description,
    String? validId,
    required String role,
    bool? onlineStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserAccount;

  factory UserAccount.fromJson(Map<String, dynamic> json) =>
      _$UserAccountFromJson(json);
}
