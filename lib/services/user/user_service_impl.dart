import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talk/models/user.dart';
import 'package:talk/services/user/user_service_contract.dart';
import 'package:web_socket_channel/io.dart';

class UserService implements IUserService {
  final String _url;
  late IOWebSocketChannel _channel;

  UserService(this._url);

  @override
  Future<void> connect(User user) async {
    _channel = IOWebSocketChannel.connect(_url);
    var data = user.toJson();
    if (user.id != null) data['id'] = user.id;
    _channel.sink.add(data);
  }

  @override
  Future<void> disconnect(User user) async {
    _channel.sink.close();
  }

  @override
  Future<List<User>> online() async {
    // 获取所有在线用户
    final response = await Dio().get('http://localhost:8080/online_users');
    var data = await jsonDecode(response.data);
    return List<User>.from(data['users']);
  }

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
