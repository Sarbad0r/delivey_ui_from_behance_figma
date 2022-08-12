import '../../models/user.dart';

abstract class UserAbs {
  Future<bool> updateUser(Map<String, dynamic> body, String password);
  Future<bool> logout();
  Future<void> getAllUsers();
}
