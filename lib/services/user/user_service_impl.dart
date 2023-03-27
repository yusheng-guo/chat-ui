import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:talk/models/user.dart';
import 'package:talk/services/user/user_service_contract.dart';

class UserService implements IUserService {
  final String _url;
  late Dio d;

  UserService(this._url);

  @override
  Future<void> connect(User user) async {
    d = Dio(BaseOptions(
      baseUrl: _url,
    ));
  }

  @override
  Future<void> disconnect(User user) async {
    d.close();
  }

  @override
  Future<List<User>> online() async {
    // 获取所有在线用户
    final response = await d.get("/online_users");
    var data = await jsonDecode(response.data);
    return List<User>.from(data['users']);
  }

  @override
  Future<List<User>> fetch(List<String?> ids) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  // @override
  // Future<List<User>> fetch(List<String> ids) {
  //   // 获取指定的id中 active为true的用户
  //   d.post("/");
  //   return
  // }

  // @override
  // Future<List<User>> fetch(List<String?> ids) async {
  //   Cursor users = await r
  //       .table('users')
  //       .getAll(r.args(ids))
  //       .filter({'active': true}).run(_connection);

  //   List userList = await users.toList();
  //   return userList.map((e) => User.fromJson(e)).toList();
  // }
}
