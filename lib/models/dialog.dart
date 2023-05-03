class DialogM {
  String name; // 发送者姓名
  String text; // 最后一条消息
  String image; // 头像地址
  String time; // 时间
  int unReadMessageCount;
  String senderID = ""; // 消息发送者的用户ID

  DialogM({
    required this.name,
    required this.text,
    required this.image,
    required this.time,
    this.unReadMessageCount = 0,
  });

  void read() {
    // 已读 之后未读消息数量为0
    unReadMessageCount = 0;
  }
}
