import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {

  ProfileModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {

    return ProfileModel(
      id: json["id"].toString(),
      name: json["name"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }
}
