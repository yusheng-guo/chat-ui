import 'package:talk/models/user.dart';

abstract class IUserService {
  Future<void> connect(User user);
  Future<List<User>> online();
  Future<void> disconnect(User user);
  Future<List<User>> fetch(List<String?> ids);
}