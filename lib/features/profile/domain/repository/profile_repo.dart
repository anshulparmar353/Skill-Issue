import 'package:skill_issue/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {

  Future<Profile> getProfile();

  Future<Profile> updateProfile({
    required String name,
  });
}
