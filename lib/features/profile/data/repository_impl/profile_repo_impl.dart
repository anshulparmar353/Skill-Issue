import 'package:skill_issue/features/profile/data/datasources/profile_api.dart';
import 'package:skill_issue/features/profile/domain/entities/profile.dart';
import 'package:skill_issue/features/profile/domain/repository/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepository {

  final ProfileApi api;

  ProfileRepoImpl(this.api);

  @override
  Future<Profile> getProfile() async {
    return await api.getProfile();
  }

  @override
  Future<Profile> updateProfile({
    required String name,
  }) async {

    return await api.updateProfile(name: name);
  }
}
