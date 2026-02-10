import 'package:hive_flutter/hive_flutter.dart';

class HiveService {

  static const userBox = "user_box";
  static const skillBox = "skill_box";

  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox(userBox);
    await Hive.openBox(skillBox);
  }
}
