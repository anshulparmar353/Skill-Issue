import 'package:skill_issue/features/auth/data/datasources/auth_api.dart';
import 'package:skill_issue/features/auth/data/datasources/user_api.dart';
import 'package:skill_issue/features/auth/domain/repository/auth_repo.dart';

import '../../domain/entities/user.dart';
import '../../../../core/storage/token_storage.dart';

class AuthRepoImpl implements AuthRepository {

  final AuthApi api;
  final UserApi userApi;
  final TokenStorage tokenStorage;

  AuthRepoImpl(this.api, this.userApi, this.tokenStorage);

  @override
  Future<User> login({required String email, required String password}) async {
    final response = await api.login(email: email, password: password);

    await tokenStorage.saveTokens(
      access: response.accessToken,
      refresh: response.refreshToken,
    );

    return response.user;
  }

  @override
  Future<User> getCurrentUser() async {
    final user = await userApi.getCurrentUser();
    return user;
  }
}
