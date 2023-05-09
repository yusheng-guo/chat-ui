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
  String id; // id
  String sender; // 发送者
  String receiver; // 接收者
  String content; // 消息内容
  MessageStatus state; // 消息状态
  MessageType type; // 消息类型
  int createdAt; // 创建时间

  Message({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.createdAt,
    this.state = MessageStatus.messageStatusSent,
    this.type = MessageType.messageTypeText,
  });

  // static MessageStatus stateInt2Enum(intstate) {
  //   MessageStatus enumstate;
  //   switch (intstate) {
  //     case 1:
  //       enumstate = MessageStatus.messageStatusSent;
  //       break;
  //     case 2:
  //       enumstate = MessageStatus.messageStatusReceived;
  //       break;
  //     case 3:
  //       enumstate = MessageStatus.messageStatusRead;
  //       break;
  //     default: // 包括为 0
  //       enumstate = MessageStatus.messageStatusFailed;
  //       break;
  //   }
  //   return enumstate;
  // }

  // static MessageType typeInt2Enum(inttype) {
  //   MessageType enumtype;
  //   switch (inttype) {
  //     case 1:
  //       enumtype = MessageType.messageTypeImage;
  //       break;
  //     case 2:
  //       enumtype = MessageType.messageTypeVideo;
  //       break;
  //     case 3:
  //       enumtype = MessageType.messageTypeFile;
  //       break;
  //     case 4:
  //       enumtype = MessageType.messageTypeAudio;
  //       break;
  //     case 5:
  //       enumtype = MessageType.messageTypeMD;
  //       break;
  //     default:
  //       enumtype = MessageType.messageTypeText;
  //       break;
  //   }
  //   return enumtype;
  // }
  static Map<int, MessageStatus> int2StateMap = {
    0: MessageStatus.messageStatusFailed,
    1: MessageStatus.messageStatusSent,
    2: MessageStatus.messageStatusReceived,
    3: MessageStatus.messageStatusRead,
  };

  static Map<int, MessageType> int2TypeMap = {
    0: MessageType.messageTypeText,
    1: MessageType.messageTypeImage,
    2: MessageType.messageTypeVideo,
    3: MessageType.messageTypeFile,
    4: MessageType.messageTypeAudio,
    5: MessageType.messageTypeMD,
  };

  // 反序列化方法
  factory Message.fromJson(Map<String, dynamic> json) {
    int intstate = json['state'];
    int inttype = json['type'];
    MessageType enumtype = int2TypeMap[inttype] ?? MessageType.messageTypeText;
    MessageStatus enumstate =
        int2StateMap[intstate] ?? MessageStatus.messageStatusSent;

    return Message(
      id: json['id'],
      sender: json['sender'],
      receiver: json['receiver'],
      content: json['content'],
      // createdAt: DateTime.parse(json['created_at']),
      createdAt: json['created_at'],
      state: enumstate,
      type: enumtype,
    );
  }

  static Map<MessageStatus, int> state2IntMap = {
    MessageStatus.messageStatusFailed: 0,
    MessageStatus.messageStatusSent: 1,
    MessageStatus.messageStatusReceived: 2,
    MessageStatus.messageStatusRead: 3,
  };

  static Map<MessageType, int> type2IntMap = {
    MessageType.messageTypeText: 0,
    MessageType.messageTypeImage: 1,
    MessageType.messageTypeVideo: 2,
    MessageType.messageTypeFile: 3,
    MessageType.messageTypeAudio: 4,
    MessageType.messageTypeMD: 5,
  };

  // 序列化方法
  Map<String, dynamic> toJson() => {
        'id': id,
        'sender': sender,
        'receiver': receiver,
        'content': content,
        'state': state2IntMap[state],
        'type': type2IntMap[type],
        'created_at': createdAt,
      };

  // 将服务器发送给客户端的 JSON 数据反序列化为 Message 对象
  static Message parseMessage(String jsonStr) {
    Map<String, dynamic> json = jsonDecode(jsonStr);
    return Message.fromJson(json);
  }
}
