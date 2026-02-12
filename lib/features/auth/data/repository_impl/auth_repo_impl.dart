import 'package:skill_issue/features/auth/data/datasources/auth_api.dart';
import 'package:skill_issue/features/auth/data/datasources/user_api.dart';
import 'package:skill_issue/features/auth/data/models/auth_result.dart';
import 'package:skill_issue/features/auth/domain/repository/auth_repo.dart';

import '../../../../core/storage/token_storage.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthApi api;
  final UserApi userApi;
  final TokenStorage tokenStorage;

  AuthRepoImpl(this.api, this.userApi, this.tokenStorage);

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final response = await api.login(email: email, password: password);

    await tokenStorage.saveTokens(
      access: response.accessToken,
      refresh: response.refreshToken,
    );

    return AuthResult(user: response.user, isNewUser: response.isNewUser);
  }

  @override
  Future<AuthResult> getCurrentUser() async {
    final result = await userApi.getCurrentUser();
    return AuthResult(user: result.user, isNewUser: result.isNewUser);
  }
}
