class ApiEndpoints {

  static const baseUrl = "http://YOUR_FASTAPI_URL";

  /// Auth
  static const login = "/auth/login";
  static const register = "/auth/register";
  static const refresh = "/auth/refresh";

  /// User
  static const currentUser = "/users/me";

  /// Skills
  static const skills = "/skills";

  /// Analysis
  static const skillGap = "/analysis/skill-gap";
}
