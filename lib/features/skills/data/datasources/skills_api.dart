import '../../../../core/network/dio_client.dart';
import '../models/skill_model.dart';

class SkillsApi {
  final DioClient dio;

  SkillsApi(this.dio);

  Future<List<SkillModel>> getSkills() async {
    final res = await dio.dio.get("/users/skills");

    return (res.data as List).map((e) => SkillModel.fromJson(e)).toList();
  }

  Future<void> addSkill({required String name}) async {
    await dio.dio.post("/users/skills", data: {"name": name});
  }

  Future<void> deleteSkill(String skillId) async {
    await dio.dio.delete("/users/skills/$skillId");
  }
}
