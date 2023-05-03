// Gender 性别
import 'dart:convert';

enum Gender {
  other, // 其他(未知或者隐藏)
  male, // 男性(默认)
  female, // 女性
  ladyboy, // 中性
}

// User 定义
class User {
  String id; // 用户id
  String name; // 姓名
  String email; // 邮箱
  Gender gender; // 性别
  String profileImage; // 头像
  bool isOnline; // 是否在线

  User({
    required this.id,
    required this.name,
    required this.email,
    this.gender = Gender.other,
    this.isOnline = false,
    this.profileImage = "",
  });

  // 辅助方法：将整数类型的 Gender 值转换为对应的枚举类型
  static Gender getGender(int value) {
    switch (value) {
      case 1:
        return Gender.male;
      case 2:
        return Gender.female;
      case 3:
        return Gender.ladyboy;
      default:
        return Gender.other;
    }
  }

  // 反序列化方法
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: getGender(json['gender']),
      isOnline: json['is_online'],
      profileImage: json["profile_image"], // 头像
    );
  }

  // 序列化方法
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'gender': gender.index,
        'is_online': isOnline,
        'profile_image': profileImage,
      };
}

// 将服务器发送给客户端的 JSON 数据反序列化为 User 对象
User parseUser(String jsonStr) {
  Map<String, dynamic> json = jsonDecode(jsonStr);
  return User.fromJson(json);
}
