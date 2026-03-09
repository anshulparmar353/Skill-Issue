
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

  /// Profile
  static const profile = "/profile";

  /// Profile
  static const updateProfile = "/updateProfile";
  
  /// Dashboard
  static const dashboard = "/dashboard";

  /// Analysis
  static const roadmap = "/roadmap";

  /// Quiz
  static const quiz = "/quiz";
  
  /// Multi Quiz
  static const multiQuiz = "/multiQuiz";

  /// Submit Quiz
  static const submitQuiz = "/submitQuiz";
  
}
