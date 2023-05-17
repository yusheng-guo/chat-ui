import 'package:http/http.dart' as http;
import 'dart:convert';

// 获取好友列表
class Friend {
  final String id;
  final String name;
  final String email;

  Friend({required this.id, required this.name, required this.email});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(id: json['id'], name: json['name'], email: json['email']);
  }
}

List<String> ids = [];

Future<void> fetchFriends() async {
  final response = await http.get(Uri.parse(''));
  if (response.statusCode == 200) {
    List<String>.from(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load friends');
  }
}
