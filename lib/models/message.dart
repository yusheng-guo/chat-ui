import 'dart:convert';

enum MessageStatus {
  messageStatusFailed, // 消息发送失败
  messageStatusSent, // 已发送
  messageStatusReceived, // 已接收
  messageStatusRead, // 已读取
}

enum MessageType {
  messageTypeText, // 文本
  messageTypeImage, // 图片
  messageTypeVideo, // 视频
  messageTypeFile, // 文件
  messageTypeAudio, // 音频
  messageTypeMD, // markdown
}

class Message {
  String sender; // 发送者
  String receiver; // 接收者
  String content; // 消息内容
  MessageStatus state; // 消息状态
  MessageType type; // 消息类型
  DateTime timestamp;

  Message({
    required this.sender,
    required this.receiver,
    required this.content,
    required this.timestamp,
    this.state = MessageStatus.messageStatusSent,
    this.type = MessageType.messageTypeText,
  });

  // 辅助方法：将整数类型的枚举值转换为对应的枚举类型
  static T enumFromString<T>(Iterable<T> values, String valueStr) {
    return values.firstWhere(
      (type) => type.toString().split('.')[1] == valueStr,
      orElse: () => throw Exception('Unknown value: $valueStr'),
    );
  }

  // 反序列化方法
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'],
      receiver: json['receiver'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      state: enumFromString(MessageStatus.values, json['state']),
      type: enumFromString(MessageType.values, json['type']),
    );
  }

  // 序列化方法
  Map<String, dynamic> toJson() => {
        'sender': sender,
        'receiver': receiver,
        'content': content,
        'state': state.toString().split('.')[1],
        'type': type.toString().split('.')[1],
        'timestamp': timestamp.toIso8601String(),
      };

  // 将服务器发送给客户端的 JSON 数据反序列化为 Message 对象
  static Message parseMessage(String jsonStr) {
    Map<String, dynamic> json = jsonDecode(jsonStr);
    return Message.fromJson(json);
  }
}
