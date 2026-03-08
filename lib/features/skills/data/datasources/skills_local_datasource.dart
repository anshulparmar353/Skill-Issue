import 'package:hive/hive.dart';
import '../models/skill_model.dart';

abstract class SkillsLocalDataSource {
  Future<void> cacheSkills(List<SkillModel> skills);
  Future<List<SkillModel>> getCachedSkills();
}

class SkillsLocalDataSourceImpl implements SkillsLocalDataSource {
  final Box box;

  SkillsLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheSkills(List<SkillModel> skills) async {
    await box.put("skills", skills.map((e) => e.toJson()).toList());
  }

  @override
  Future<List<SkillModel>> getCachedSkills() async {
    final data = box.get("skills");

    if (data == null) return [];

    return (data as List)
        .map((e) => SkillModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}