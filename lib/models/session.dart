class Session {
  String id; // 发送者 ID
  String name; // 发送者姓名
  String text; // 最后一条消息
  String image; // 头像地址
  DateTime timestrap; // 时间
  int unReadMessageCount;
  String sender = ""; // 消息发送者的用户ID

  Session({
    required this.id,
    required this.name,
    required this.text,
    required this.image,
    required this.timestrap,
    this.unReadMessageCount = 0,
  });

  void read() {
    // 已读 之后未读消息数量为0
    unReadMessageCount = 0;
  }
}
